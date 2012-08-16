require 'satellite/network/event'

describe Satellite::Network::Event do

  before do
    @it = Satellite::Network::Event.new(receiver_id: ' bob ', sender_id: ' alice ', kind: ' bob ', data: { :one => 1 })
  end

  describe '#initialize' do
    it 'assigns attributes' do
      @it.receiver_id.should == 'bob'
      @it.sender_id.should == 'alice'
      @it.data.should == { :one => 1 }
    end
  end

  describe '#broadcast?' do
    it 'identifies a event to be sent to one receiver' do
      event = Satellite::Network::Event.new receiver_id: 'bob'
      event.should_not be_broadcast
    end

    it 'identifies a event to be sent to everyone' do
      event = Satellite::Network::Event.new
      event.should be_broadcast
    end
  end

  describe '#kind' do
    it 'returns the kind as a symbol' do
      event = Satellite::Network::Event.new kind: 'important'
      event.kind.should == :important
    end

    it 'assigns a default kind if none was specified' do
      event = Satellite::Network::Event.new
      event.kind.should == :undefined
    end
  end

end