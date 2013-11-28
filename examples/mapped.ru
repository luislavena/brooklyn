lib = File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "brooklyn"

class Users < Brooklyn::App
  get "/" do
    puts self.object_id
    "Users#/"
  end
end

class MyApp < Brooklyn::App
  map "/users" do
    run Users.new
  end
end

run MyApp.new
