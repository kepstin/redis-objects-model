require 'fakeredis'
require 'redis-objects-model'

class MyModel < Redis::Objects::Model
end

describe 'redis-objects-model' do
  it 'should derive key from subclass name' do
    model = MyModel.new
    model.redis_objects_model_next_id.should == 'my_model:next_id'
  end

  it 'should not be persisted by default' do
    model = MyModel.new
    model.should be_new_record
    model.should_not be_persisted
  end

  it 'should be persisted after assigning an id' do
    model = MyModel.new
    model.id.should > 0
    model.should_not be_new_record
    model.should be_persisted
  end

  it 'should return the same id with multiple calls' do
    model = MyModel.new
    id_1 = model.id
    id_2 = model.id
    id_1.should == id_2
  end

  it 'should not create multiple models with the same id' do
    model_1 = MyModel.new
    model_2 = MyModel.new
    model_1.id.should_not == model_2.id
  end

  it 'should allow being created with an assigned id' do
    id = Random.rand(1..100000)
    model = MyModel.new id
    model.should be_persisted
    model.id.should == id
  end

  it 'should be persisted immediately when called with create' do
    model = MyModel.create
    model.should be_persisted
    model.id.should > 0
  end

  it 'should not allow models to interfere with id allocation' do
    class OtherModel < Redis::Objects::Model
    end

    model = MyModel.create
    other_model = OtherModel.create

    other_model.id.should == 1
  end
end
