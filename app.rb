require 'rubygems'
require 'bundler/setup'
Bundler.require
require 'active_support/dependencies'
require 'active_support/core_ext/hash'

ActiveSupport::Dependencies.autoload_paths += %w{ lib lib/* }

Application.configure

poller = Poller.new(DateTime.parse("2012-06-13 13:57"))

poller.run do |since|
  p "Processing errors since #{since}"
  errors = Receiver.receive(since)
  ap "Found #{errors.size} error messages"

  Doctor.cure!(errors)
end
