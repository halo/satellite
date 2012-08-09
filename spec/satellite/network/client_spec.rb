require 'spec_helper'
require 'satellite/network/client'

describe Satellite::Network::Client do

  before do
    @it = Satellite::Network::Client.new id: 'abcdefgh', port: 12345, server_endpoint: '127.0.0.1', server_port: 33033
  end

  after do
    @it.reset!
  end

  describe '#initialize' do
    it 'assigns the parameters' do
      @it.id.size.should == 8
      @it.remote.endpoint.should == '127.0.0.1'
      @it.remote.port.should == 33033
      @it.port.should == 12345
    end
  end

  describe '#send_event' do
    before do
      @server = UDPSocket.new
      @server.bind(nil, 33033)
    end

    after do
      @server.close
    end

    it 'sends an event' do
      @it.send_event event_name: :show, data: { :some => 'data' }
      Marshal.load(@server.recvfrom(65507).first).should == { id: 'abcdefgh', event_name: :show, data: { some: 'data' } }
    end
  end

  describe '#receive_events' do
    before do
      @server = UDPSocket.new
      @server.bind(nil, 33033)
      @server.connect('127.0.0.1', 12345)
    end

    after do
      @server.close
    end

    it 'yields nothing if there are no events' do
      result = []
      @it.receive_events { |event| result << event }
      result.should be_empty
    end

    it 'yields all events' do
      @server.send Marshal.dump({ event_name: :shot, data: { some: 'data' } }), 0
      @server.send Marshal.dump({ event_name: :shot, data: { some: 'more data' } }), 0
      result = []
      @it.receive_events { |event, data| result << [event, data] }
      result.should == [[:shot, {:some=>"data"}], [:shot, { some: "more data"}]]
    end
  end

end