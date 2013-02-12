# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redis-objects-model/version'

Gem::Specification.new do |gem|
  gem.name          = "redis-objects-model"
  gem.version       = Redis::Objects::Model::VERSION
  gem.authors       = ["Calvin Walton"]
  gem.email         = ["calvin.walton@kepstin.ca"]
  gem.description   = %q{The simplest possible model for redis-objects}
  gem.summary       = %q{You can't use redis-objects as a model in itself, because it requires an ID attribute. So, lets add one.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency('redis-objects', ['~> 0.6.0'])
  gem.add_development_dependency('fakeredis', ['~>0.4.1'])
  gem.add_development_dependency('rake')
  gem.add_development_dependency('rspec', ['~> 2.12.0'])
end
