lib = File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "brooklyn"

class HelloWorld < Brooklyn::App
  get "/" do
    "Hello World!"
  end
end

run HelloWorld.new
