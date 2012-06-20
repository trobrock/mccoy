require File.join(File.dirname(__FILE__), 'handlers/aggregation_server_down_handler')
require File.join(File.dirname(__FILE__), 'handlers/unicorn_down_handler')

class Doctor
  @@handlers = [
    AggregationServerDownHandler,
    UnicornDownHandler
  ]

  class << self
    def cure!(errors)
      error_messages(errors).each do |error|
        handler_for(error).fix!
      end
    end

    def handlers
      @@handlers
    end

    private

    def error_messages(errors)
      errors.
        map { |error| error.multipart? ? error.parts[0] : error }.
        map { |error| error.body.decoded }
    end

    def handler_for(error)
      handler = @@handlers.detect do |handler|
        handler.match? error
      end

      handler.new(error)
    end
  end
end
