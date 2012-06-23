module Handlers
  class AggregationServerDownHandler < Handler
    search      :subject => "PROBLEM Aggregation"
    match       /Trigger: Aggregation Server(.*)Trigger status: PROBLEM/m
    data        :server => /\(agg-\w+-([a-z0-9]+):/i
    application :aggregation

    fix do
      check "which server is down" do
        true
      end

      p "app: #{self.application} :: cap production thrift:start on #{self.server}"
    end
  end
end
