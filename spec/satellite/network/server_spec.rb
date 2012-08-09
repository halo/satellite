require 'spec_helper'
require 'satellite/network/server'

describe Satellite::Network::Server do

  before do
    @it = Satellite::Network::Server.new id: 'abcdefgh', port: 33033
    @client1 = UDPSocket.new
    @client2 = UDPSocket.new
    @client1.bind(nil, 12345)
    @client2.bind(nil, 23456)
    @client1.connect('127.0.0.1', 33033)
    @client2.connect('127.0.0.1', 33033)
  end

  after do
    @it.reset!
    @client1.close
    @client2.close
  end

  describe '#initialize' do
    it 'assigns the parameters' do
      @it.port.should == 33033
    end
  end

  describe '#send_event' do
    it 'sends an event to a registered remote' do
      @client1.send Marshal.dump({ id: 'abcdefgh', event_name: :hello, data: 'abcdefgh' }), 0
      sleep 0.01
      @it.receive_events {}
      @it.send_event id: 'abcdefgh', event_name: :blue, data: { :some => 'data' }
      Marshal.load(@client1.recvfrom(65507).first).should == { event_name: :blue, data: { some: 'data' } }
    end
  end

  describe '#broadcast' do
    it 'sends events to all registered remotes' do
      @client1.send Marshal.dump({ id: 'abcdefgh', event_name: :hello }), 0
      @client2.send Marshal.dump({ id: 'ijklmnop', event_name: :hello }), 0
      @client2.send Marshal.dump({ id: 'ijklmnop', event_name: :hello }), 0
      sleep 0.01
      @it.receive_events {}
      @it.send_event id: 'abcdefgh', event_name: :blue, data: { :some => 'one' }
      @it.send_event id: 'ijklmnop', event_name: :green, data: { :some => 'two' }
      @it.send_event id: 'ijklmnop', event_name: :white, data: { :some => 'three' }
      client1_data = []
      client2_data = []
      client1_data << @client1.recvfrom_nonblock(65507)
      lambda { client1_data << @client1.recvfrom_nonblock(65507) }.should raise_error(Errno::EAGAIN)
      client2_data << @client2.recvfrom_nonblock(65507)
      client2_data << @client2.recvfrom_nonblock(65507)
      lambda { client2_data << @client2.recvfrom_nonblock(65507) }.should raise_error(Errno::EAGAIN)
      client1_data.size.should == 1
      client2_data.size.should == 2
      Marshal.load(client1_data.first.first).should == { event_name: :blue, data: { some: 'one' } }
      Marshal.load(client2_data.first.first).should == { event_name: :green, data: { some: 'two' } }
      Marshal.load(client2_data.last.first).should == { event_name: :white, data: { some: 'three' } }
    end
  end

  describe '#receive_events' do
    it 'yields nothing if there are no events' do
      result = []
      @it.receive_events { |event| result << event }
      result.should be_empty
    end

    it 'yields all events' do
      @client1.send Marshal.dump({ id: 'abcdefgh',event_name: :luke, data: { :some => 'ice' } }), 0
      @client2.send Marshal.dump({ id: 'ijklmnop',event_name: :anakin, data: { :some => 'fire' } }), 0
      @client2.send Marshal.dump({ id: 'ijklmnop',event_name: :lea, data: { :some => 'water' } }), 0
      sleep 0.01
      result = []
      @it.receive_events { |id, event, data| result << [id, event, data] }
      result.should == [['abcdefgh', :luke, { some: 'ice' }], ['ijklmnop', :anakin, { some: 'fire' }], ['ijklmnop', :lea, { some: 'water' }]]
    end
  end

end
