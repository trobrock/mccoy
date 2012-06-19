class Poller
  def initialize(since)
    @since = since
  end

  def run(&block)
    while true
      yield(@since)

      @since = DateTime.now

      sleep 1
    end
  end
end
