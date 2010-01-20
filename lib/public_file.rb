class PublicFile
  attr_reader :path, :pathname

  def initialize(sinatra_app, path = nil)
    if path.nil?
      raise ArgumentError, "a path must be provided when initialising a PublicFile"
    end

    @sinatra_app = sinatra_app
    @pathname = Pathname.new(path)
    rewrite_path
  end

  def self.push(sinatra_app, path)
    self.new(sinatra_app, path).push
  end

  def push
    full_path = File.join(File.dirname(__FILE__), '..', 'public',  @path)
    @sinatra_app.send_file(full_path)
  end

private
  def rewrite_path
    dirs, file_name, extension = [''] * 3

    if @pathname.extname.empty?
      dirs      = @pathname.dirname + @pathname.basename
      file_name = 'index'
      extension = '.html'
    elsif @pathname.extname == '.htm'
      dirs      = @pathname.dirname
      file_name = @pathname.basename('.htm')
      extension = '.html'
    else
      dirs      = @pathname.dirname
      file_name = @pathname.basename
    end

    @path = File.join(dirs.to_s, "#{file_name}#{extension}")
  end
end
