lib = File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "brooklyn"

module MyHelper
  def say_hi
    "Hi!"
  end
end

class ParentApp < Brooklyn::App
  helpers MyHelper
end

class MyApp < ParentApp
  get "/" do
    say_hi
  end
end

run MyApp.new
