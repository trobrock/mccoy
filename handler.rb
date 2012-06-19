require File.join(File.dirname(__FILE__), 'handlers/aggregation_server_down_handler')

class Handler
  @@handlers = [
    AggregationServerDownHandler
  ]

  class << self
    def run(errors)
      error_messages(errors).each do |error|
        ap handler_for(error)
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
