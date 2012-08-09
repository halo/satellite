require 'satellite/network/datagram'

describe Satellite::Network::Datagram do

  describe '#initialize' do
    it 'assigns attributes' do
      remote = Satellite::Network::Datagram.new(payload: ' bob ', endpoint: ' 192.168.0.1 ', port: ' 1234 ')
      remote.payload.should == ' bob '
      remote.endpoint.should == '192.168.0.1'
      remote.port.should == 1234
      remote.should be_valid
    end
  end

  describe '#valid?' do
    it 'identifies a valid datagram' do
      Satellite::Network::Datagram.new(endpoint: '192.168.0.1', port: 1234).should be_valid
    end
  end

end