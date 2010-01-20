$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require File.join(File.dirname(__FILE__), '../app')
require 'spec'
require 'spec/autorun'

begin
  require 'rack/test'
rescue LoadError
  $stderr.puts <<-PLAIN.gsub(/^ {0,4}/, '')

    You need to install brynary's \e[31;1mrack-test\e[0m gem before you can run specs!

  PLAIN
end

Spec::Runner.configure do |config|
  config.include Rack::Test::Methods
end