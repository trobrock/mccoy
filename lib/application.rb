class Application
  def self.configure
    config = YAML.load_file(File.join(File.dirname(__FILE__), '../config.yml'))

    Mail.defaults do
      retriever_method :imap, config["mail"].symbolize_keys
    end
  end
end
