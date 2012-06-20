module Handlers
  class AggregationServerDownHandler < Handler
    match       /Trigger: Aggregation Server(.*)Trigger status: PROBLEM/m
    search      :subject => "PROBLEM Aggregation"
    data        :server => /\(agg-\w+-([a-z0-9]+):/i
    application :aggregation

    def fix!
      p "cap production thrift:start on #{self.server}"
    end
  end
end
