require "spec_helper"

describe Array do
  it "defines Array#riffle" do
    [].respond_to?(:riffle).should be_true
  end
end
