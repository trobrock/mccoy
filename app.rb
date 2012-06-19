require 'rubygems'
require 'bundler/setup'
Bundler.require

require File.join(File.dirname(__FILE__), 'config')
require File.join(File.dirname(__FILE__), 'receiver')
require File.join(File.dirname(__FILE__), 'poller')

poller = Poller.new(DateTime.parse("2012-06-13 13:57"))

poller.run do |since|
  errors = Receiver.receive(since)
  handle_errors = filter_errors!(errors)
  ap "Found #{errors.size} error messages"
end
