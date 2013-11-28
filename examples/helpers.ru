lib = File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "brooklyn"

module MyHelper
  def text(value)
    String(value)
  end
end

class MyApp < Brooklyn::App
  helpers MyHelper

  helpers do
    def reverse(value)
      value.reverse
    end
  end

  get "/" do
    text 1234
  end

  get "/:text" do
    reverse params[:text]
  end
end

run MyApp.new
