require "spec_helper"

describe Riffle do
  it "requires all arguments to be of type `Array`, except when the last arg is an opts Hash" do
    expect { [].riffle 1 }.to raise_error(ArgumentError)
    expect { [].riffle [1], :foo }.to raise_error(ArgumentError)
    expect { [].riffle({}, [1]) }.to raise_error(ArgumentError)

    # allow an opts Hash to be passed as the last arg
    expect { [].riffle [1], { min_group_size: 1 } }.to_not raise_error
  end

  it "does not raise exceptions when empty args are passed" do
    expect { [].riffle [], [] }.to_not raise_error
    expect([].riffle [], []).to be_empty
  end

  it "supports more than two arguments" do
    numbers = [1, 2, 3, 4, 5, 6]
    letters = %w(a b c d e f)
    symbols = [:foo, :bar, :baz, :qux]
    result = numbers.riffle letters, symbols

    total_length = numbers.length +
                   letters.length +
                   symbols.length

    expect(result.length).to be(total_length)

    # filtering out integers from the result should be exactly equal to the
    # original `numbers` array. particularly the order should be the same
    result_numbers = result.select { |r| r.is_a? Integer }
    expect(result_numbers).to eql(numbers)

    # filtering out strings from the result should be exactly equal to the
    # original `letters` array. particularly the order should be the same
    result_letters = result.select { |r| r.is_a? String }
    expect(result_letters).to eql(letters)

    # filtering out strings from the result should be exactly equal to the
    # original `letters` array. particularly the order should be the same
    result_symbols = result.select { |r| r.is_a? Symbol }
    expect(result_symbols).to eql(symbols)
  end

  it "merges all argument arrays while maintaining the order of the original arrays in relation to themselves" do
    numbers = [1, 2, 3, 4, 5, 6]
    letters = %w(a b c d e f)
    result = numbers.riffle letters

    total_length = numbers.length + letters.length
    expect(result.length).to eql(total_length)

    # filtering out integers from the result should be exactly equal to the
    # original `numbers` array. particularly the order should be the same
    result_numbers = result.select { |r| r.is_a? Integer }
    expect(result_numbers).to eql(numbers)

    # filtering out strings from the result should be exactly equal to the
    # original `letters` array. particularly the order should be the same
    result_letters = result.select { |r| r.is_a? String }
    expect(result_letters).to eql(letters)
  end

  it "maintains the first element in the array on which `riffle` was called" do
    a = [1, 2, 3]
    b = %w(a b c)
    r = a.riffle(b)
    expect(r.first).to be(a.first)
  end

  it "supports defining a min and max group size through an opts Hash passed as the last arg" do
    a = [1, 2, 3, 4, 5, 6, 7, 8]
    b = %w(a b c d e f g h)
    r = a.riffle(b, { range: (2..2) })
    r.slice(0..1).each { |x| expect(x).to be_a(Integer) }
    r.slice(2..3).each { |x| expect(x).to be_a(String) }
    r.slice(6..7).each { |x| expect(x).to be_a(String) }
    r.slice(8..9).each { |x| expect(x).to be_a(Integer) }
  end

  it "supports passing a custom seed" do
    a = [1, 2, 3, 4, 5, 6, 7, 8]
    b = %w(a b c d e f g h)
    r1 = Array.riffle(a, b, seed: 123)
    r2 = Array.riffle(a, b, seed: 123)
    expect(r1).to eql(r2)
  end
end

