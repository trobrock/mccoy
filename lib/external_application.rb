class ExternalApplication
  @instances = {}

  def self.instance(app)
    @instances[app] ||= self.new(app)
  end

  def initialize(app)
    @name   = app
    @config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/applications.yml'))[app.to_s]
  end

  def path
    File.join(File.dirname(__FILE__), '..', @config["path"])
  end

  def to_s
    @name.to_s
  end
end
