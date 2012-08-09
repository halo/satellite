require 'satellite/db/model'

describe Satellite::DB::Model do

  before do
    @it = Satellite::DB::Model.new
  end

  after do
    @it.destroy_all
  end

  describe '.all' do
    it 'returns no records if there are none' do
      @it.class.all.should == []
    end
  end

  describe '.find' do
    it 'finds a record' do
      @it.save
      @it.class.find(@it.id).should == @it
    end

    it 'returns nil if a record could not be found' do
      @it.class.find('nothing').should == nil
    end
  end

  describe '.create' do
    it 'permanently stores the record' do
      it = @it.class.create
      it.should be_instance_of Satellite::DB::Model
      it.class.all.should == [it]
      @it.class.all.should == [it]
    end
  end

  describe '#save' do
    it 'stores a new record permanently' do
      @it.save.should == @it
      @it.class.all.should == [@it]
    end
  end

  describe '#id' do
    it 'is set' do
      @it.id.should_not be_empty
    end

    it 'always returns the same id' do
      id = @it.id
      id.should == @it.id
      id.should == @it.id
    end
  end

end