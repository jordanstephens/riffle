require "spec_helper"

describe Array do
  context "#riffle" do
    it "defines Array#riffle" do
      [].respond_to?(:riffle).should be_true
    end

    it "returns self if no args are passed" do
      a = [1, 2, 3]
      a.riffle.should == a
    end
  end

  context ".riffle" do
    it "defines Array.riffle" do
      Array.respond_to?(:riffle).should be_true
    end

    it "returns [] if no args are passed" do
      Array.riffle.should == []
    end

    it "returns the arg if only one arg is passed" do
      a = [1,2,3]
      Array.riffle(a).should == a
    end
  end
end
