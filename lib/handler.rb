class FailedCheck < StandardError ; end

class Handler
  @@fixes = []

  class << self
    def fixes
      @@fixes
    end

    def match(regex)
      class_eval <<-EVAL
        def self.match?(error)
          !!error.match(#{regexp_to_string(regex)})
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

    def data(options={})
      options.each do |name, matcher|
        class_eval <<-EVAL
          def #{name}
            regex = #{regexp_to_string(matcher)}
            matches = @error.match(regex).captures

            matches.size == 1 ? matches.first : matches
          end
        EVAL
      end
    end

    def application(app)
      class_eval <<-EVAL
        def application
          @application ||= ExternalApplication.instance(:#{app})
        end
      EVAL
    end

    def fix(&block)
      @@fixes << block

      class_eval <<-EVAL
        def fix!
          self.instance_eval &self.class.fixes[#{@@fixes.size-1}]
        end
      EVAL
    end

    private

    def regexp_to_string(regex)
      "Regexp.new('#{regex.source}', #{regex.options})"
    end
  end

  def initialize(error)
    @error = error
  end

  def check(msg, &block)
    result = yield
    raise FailedCheck.new(msg) unless result
  end

end
