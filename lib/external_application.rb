class UpdateFailure < StandardError ; end
class ExternalApplication
  @instances = {}

  def self.instance(app)
    app = app.to_sym
    @instances[app] ||= self.new(app)
  end

  def initialize(app)
    @config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/applications.yml'))[app.to_s]

    @name   = app
    @path   = File.join(File.dirname(__FILE__), '../applications', @name.to_s)
    @scm    = @config["scm"]
    @branch = @config["branch"]
    @repo   = @config["repo"]

    create_or_update!
  end

  def to_s
    @name.to_s
  end

  def create_or_update!
    if !created?
      create!
    else
      update!
    end
  end

  private

  def created?
    Dir.exists? @path
  end

  def create!
    %x{
      mkdir -p #@path &&
      git clone git@github.com:#@repo.git #@path
    }
    raise CreateFailure unless $?.success?
  end

  def update!
    %x{
      cd #@path &&
      git checkout #@branch &&
      git pull origin #@branch
    }
    raise UpdateFailure unless $?.success?
  end
end
