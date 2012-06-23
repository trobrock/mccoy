module Handlers
  class UnicornDownHandler < Handler
    match       /Trigger: Unicorn Processes(.*)Trigger status: PROBLEM/m
    search      :subject => "PROBLEM Unicorn Processes"
    data        :server => /\(acc-([a-z0-9]+):/i
    application :outright

    fix do
      p "app: #{self.application} :: cap production thrift:start on #{self.server}"
    end
  end
end
