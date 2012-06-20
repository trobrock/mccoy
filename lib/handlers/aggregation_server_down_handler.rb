module Handlers
  class AggregationServerDownHandler < Handler
    match  /Trigger: Aggregation Server(.*)Trigger status: PROBLEM/m
    search :subject => "PROBLEM Aggregation"

    def fix!
      p "cap production thrift:start"
    end
  end
end
