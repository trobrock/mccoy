class Handler
  class << self
    def match(regex)
      class_eval <<-EVAL
        def self.match?(error)
          !!error.match("#{regex}")
        end
      EVAL
    end

    def search(options={})
      search_string = []
      options.each do |type, string|
        type = type.to_s.upcase

        string.split(" ").each do |word|
          search_string << [type, word].join(" ")
        end
      end

      search_string = search_string.join(" ")

      class_eval <<-EVAL
        def self.search
          "#{search_string}"
        end
      EVAL
    end
  end

  def initialize(error)
    @error = error
  end

end
