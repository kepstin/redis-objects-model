# redis-objects-model

[![Build Status](https://travis-ci.org/kepstin/redis-objects-model.png)](https://travis-ci.org/kepstin/redis-objects-model)

The simplest possible Model to use with redis-objects.

The minimum requirement for a class to be usable as a model with
redis-objects is that it must provide an id attribute. So here is a
base class that provides an id attribute - lazily yet atomically
allocated using Redis, of course.

## Installation

Add this line to your application's Gemfile:

    gem 'redis-objects-model'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redis-objects-model

## Usage

See the generated rdoc, or just read the documentation headers in
lib/redis-objects-model.rb

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
