require "spec_helper"

describe Riffle do
  it "requires all arguments to be of type `Array`, except when the last arg is an opts Hash" do
    expect { Array.riffle 1 }.to raise_error(ArgumentError)
    expect { Array.riffle [1], :foo }.to raise_error(ArgumentError)
    expect { Array.riffle({}, [1]) }.to raise_error(ArgumentError)

    # allow an opts Hash to be passed as the last arg
    expect { Array.riffle [1], { range: (1..2) } }.to_not raise_error
  end

  it "does not raise exceptions when empty args are passed" do
    expect { Array.riffle [], [] }.to_not raise_error
    Array.riffle([], []).should be_empty
  end

  it "supports more than two arguments" do
    numbers = [1, 2, 3, 4, 5, 6]
    letters = %w(a b c d e f)
    symbols = [:foo, :bar, :baz, :qux]
    result = Array.riffle(numbers, letters, symbols)

    result.length.should == numbers.length +
                            letters.length +
                            symbols.length

    # filtering out integers from the result should be exactly equal to the
    # original `numbers` array. particularly the order should be the same
    result.select { |r| r.is_a? Integer }.should.eql? numbers

    # filtering out strings from the result should be exactly equal to the
    # original `letters` array. particularly the order should be the same
    result.select { |r| r.is_a? String }.should.eql? letters

    # filtering out strings from the result should be exactly equal to the
    # original `letters` array. particularly the order should be the same
    result.select { |r| r.is_a? Symbol }.should.eql? symbols
  end

  it "merges all argument arrays while maintaining the order of the items in the original arrays" do
    numbers = [1, 2, 3, 4, 5, 6]
    letters = %w(a b c d e f)
    result = Array.riffle(numbers, letters)

    result.length.should == numbers.length + letters.length

    # filtering out integers from the result should be exactly equal to the
    # original `numbers` array. particularly the order should be the same
    result.select { |r| r.is_a? Integer }.should.eql? numbers

    # filtering out strings from the result should be exactly equal to the
    # original `letters` array. particularly the order should be the same
    result.select { |r| r.is_a? String }.should.eql? letters
  end

  it "merges the arguments in the order in which they are passed" do
    numbers = [1, 2, 3, 4, 5, 6]
    letters = %w(a b c d e f)
    symbols = [:a, :b, :c, :d, :e, :f]
    result = Array.riffle(numbers, letters, symbols)

    expect(result.index(1) < result.index("a")).to be_true
    expect(result.index("a") < result.index(:a)).to be_true
  end

  it "maintains the first element in the array on which `riffle` was called" do
    a = [1, 2, 3]
    b = %w(a b c)
    Array.riffle(a, b).first.should == a.first
  end

  it "supports defining a min and max group size through an opts Hash passed as the last arg" do
    a = [1, 2, 3, 4, 5, 6, 7, 8]
    b = %w(a b c d e f g h)
    r = Array.riffle(a, b, { range: (2..2) })
    r.slice(0..1).each { |x| x.is_a?(Integer).should be_true }
    r.slice(2..3).each { |x| x.is_a?(String).should be_true }
    r.slice(6..7).each { |x| x.is_a?(String).should be_true }
    r.slice(8..9).each { |x| x.is_a?(Integer).should be_true }
  end

  it "supports passing a custom seed" do
    a = [1, 2, 3, 4, 5, 6, 7, 8]
    b = %w(a b c d e f g h)
    r1 = Array.riffle(a, b, seed: 123)
    r2 = Array.riffle(a, b, seed: 123)
    expect(r1).to eql(r2)
  end
end

