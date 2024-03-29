require 'satellite/db/model'

describe Satellite::DB::Model do

  before do
    @it = Satellite::DB::Model.new
  end

  after do
    @it.class.destroy_all
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
      copy = @it.class.create
      copy.should be_instance_of Satellite::DB::Model
      copy.class.all.should == [copy]
      @it.class.all.should == [copy]
    end
  end

  describe '.create_or_update' do
    it 'creates a record if it doesnt exist' do
      copy = @it.class.create_or_update
      copy.should be_instance_of Satellite::DB::Model
      copy.class.all.should == [copy]
      @it.class.all.should == [copy]
    end

    it 'updated a record if it already exist' do
      new_record = @it.class.create_or_update id: 'abcdefgh'
      new_record.should be_instance_of Satellite::DB::Model
      new_record.class.all.should == [new_record]
      new_record.class.create_or_update id: 'abcdefgh', name: 'Luke'
      another_record = new_record.class.create_or_update
      another_record.update_attribute :name, 'Anakin'
      @it.class.all.should == [new_record, another_record]
      @it.class.last.read_attribute(:name).should == 'Anakin'
      @it.class.first.read_attribute(:name).should == 'Luke'
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

  context 'Enumerable Mixin' do
    it 'answers to .take' do
      @it.save
      @it.class.take(1).should == [@it]
    end
  end

  describe '#export' do
    it 'exports all attributes' do
      @it.export.id.should == @it.id
    end
  end

  describe '.export' do
    before do
      blue_record = @it.class.create id: 'bbbbbbbb'
      red_record = @it.class.create id: 'rrrrrrrr'
      blue_record.update_attribute :color, 'blue'
      red_record.update_attribute :color, 'red'
    end

    it 'exports all records' do
      export = @it.class.export
      export.first.id.should == 'bbbbbbbb'
      export.first.color.should == 'blue'
      export.last.id.should == 'rrrrrrrr'
      export.last.color.should == 'red'
    end

    it 'exports only selected attributes' do
      export = @it.class.export :color
      export.first.id.should == nil
      export.first.color.should == 'blue'
      export.last.id.should == nil
      export.last.color.should == 'red'
    end
  end

  describe '#update' do
    it 'updates the attributes' do
      @it.update name: 'Joe', height: '5m'
      @it.read_attribute(:name).should == 'Joe'
      @it.read_attribute(:height).should == '5m'
    end
  end


end