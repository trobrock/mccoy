class Receiver
  def self.receive(since)
    errors = []

    Doctor.handlers.each do |handler|
      search = [handler.search, "SINCE #{since.strftime("%d-%b-%Y")}"].join(" ")
      errors << Mail.find(:what => :first, :order => :desc, :keys => search)
    end

    errors.flatten
  end
end
