module Handlers
  class UnicornDownHandler < Handler
    match  /Trigger: Unicorn Processes(.*)Trigger status: PROBLEM/m
    search :subject => "PROBLEM Unicorn Processes"

    def fix!
      p "cap production unicorn:restart"
    end
  end
end
