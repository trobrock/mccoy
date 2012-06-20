module Handlers
  class UnicornDownHandler < Handler
    match       /Trigger: Unicorn Processes(.*)Trigger status: PROBLEM/m
    search      :subject => "PROBLEM Unicorn Processes"
    data        :server => /\(acc-([a-z0-9]+):/i
    application :outright

    def fix!
      p "cap production unicorn:restart on #{self.server}"
    end
  end
end
