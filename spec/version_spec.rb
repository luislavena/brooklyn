require "spec_helper"

describe Brooklyn::VERSION do
  it "wont be nil" do
    Brooklyn::VERSION.wont_be_nil
  end
end
