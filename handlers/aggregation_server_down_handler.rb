class AggregationServerDownHandler
  def self.match?(error)
    !!error.match(/Trigger: Aggregation Server(.*)Trigger status: PROBLEM/m)
  end

  def self.search
    "SUBJECT PROBLEM SUBJECT Aggregation"
  end

  def initialize(error)
    @error = error
  end
end
