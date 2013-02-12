require "redis-objects-model/version"
require "redis"
require "redis/objects"

class Redis
  module Objects

    ##
    # The simplest possible Model to use with redis-objects.
    #
    # The minimum requirement for a class to be usable as a model with
    # redis-objects is that it must provide an id attribute. So here is a
    # base class that provides an id attribute - lazily yet atomically
    # allocated using Redis, of course.
    #
    # A few convenience methods are provided to allow you to check whether an
    # id has been allocated, to do idiomatic 'find' type lookups, and to
    # create with immediate id allocation.
    class Model
      include Redis::Objects

      ##
      # The name of the redis counter which will be used to allocate keys.
      def redis_objects_model_next_id
        "#{self.class.redis_prefix}:next_id"
      end

      ##
      # Create an instance of the model.
      #
      # If the +id+ parameter is not nil, the model will be for the object
      # with that id. Otherwise, you are creating a new object and a new id
      # will be allocated atomically as needed.
      def initialize(id = nil)
        @id = id
      end

      ##
      # Retrieve the id of the object.
      #
      # If the instance is referencing an existing object, the id of that
      # object will be returned. Otherwise a new id will be allocated (and
      # immediately saved).
      #
      # In other words, accessing the id attribute is basically equivalent to
      # persisting the object.
      def id
        @id || @id = self.redis.incr(self.redis_objects_model_next_id)
      end

      #########################################################################
      # :section: Convenience Methods
      #########################################################################

      ##
      # Returns true if no id has been allocated for this object yet.
      def new_record?
        @id.nil?
      end

      ##
      # Returns false if no id has been allocated for this object yet.
      def persisted?
        !new_record?
      end

      ##
      # Create a new object, persisting it immediately.
      def self.create
        i = self.new
        i.id
        i
      end

      ##
      # Look up an object by id.
      def self.find(id)
        self.new id
      end
    end
  end
end
