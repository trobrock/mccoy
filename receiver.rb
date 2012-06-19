class Receiver
  def self.receive(since)
    Mail.find(:what => :first, :order => :desc, :keys => "SUBJECT PROBLEM SUBJECT Aggregation SINCE #{since.strftime("%d-%b-%Y")}")
  end
end
