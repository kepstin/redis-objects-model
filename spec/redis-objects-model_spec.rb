require 'fakeredis'
require 'redis-objects-model'

describe 'redis-objects-model' do
  it 'should not be persisted by default' do
    model = Redis::Objects::Model.new
    model.should be_new_record
    model.should_not be_persisted
  end

  it 'should be persisted after assigning an id' do
    model = Redis::Objects::Model.new
    model.id.should > 0
    model.should_not be_new_record
    model.should be_persisted
  end

  it 'should return the same id with multiple calls' do
    model = Redis::Objects::Model.new
    id_1 = model.id
    id_2 = model.id
    id_1.should == id_2
  end

  it 'should not create multiple models with the same id' do
    model_1 = Redis::Objects::Model.new
    model_2 = Redis::Objects::Model.new
    model_1.id.should_not == model_2.id
  end

  it 'should allow being created with an assigned id' do
    id = Random.rand(1..100000)
    model = Redis::Objects::Model.new id
    model.should be_persisted
    model.id.should == id
  end

  it 'should be persisted immediately when called with create' do
    model = Redis::Objects::Model.create
    model.should be_persisted
    model.id.should > 0
  end
end
