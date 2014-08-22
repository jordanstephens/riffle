require "spec_helper"

describe Array do
  context "#riffle" do
    it "defines Array#riffle" do
      expect([]).to respond_to(:riffle)
    end

    it "returns self if no args are passed" do
      a = [1, 2, 3]
      expect(a.riffle).to eql(a)
    end
  end

  context ".riffle" do
    it "defines Array.riffle" do
      expect(Array).to respond_to(:riffle)
    end

    it "returns [] if no args are passed" do
      expect(Array.riffle).to eql([])
    end

    it "returns the arg if only one arg is passed" do
      a = [1,2,3]
      expect(Array.riffle(a)).to eql(a)
    end
  end
end
