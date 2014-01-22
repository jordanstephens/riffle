# riffle

Extends `Array` by defining `Array#riffle` and `Array.riffle` to merge multiple arrays as if
[riffling a deck of cards](http://en.wikipedia.org/wiki/Shuffling#Riffle).

**Algorithm Description**

`riffle` iterates over argument arrays and selects a random number
of items from each to remove from the front (this default subsequence
length, or *group size* is in `(1..3)`). The removed items are then
appended to a new array which is returned as the result after all items
from each argument array have been merged. This iteration continues
until all argument arrays are empty and all items have been merged.

The order of items in each argument array is preserved in the resulting
array relative to other items originating from the same argument array.

## Usage

### Basic Usage

    numbers = [1, 2, 3, 4, 5, 6]
    letters = %w(a b c d e f)

    numbers.riffle(letters) # => [1, 2, "a", "b", 3, 4, "c", 5, 6, "d", "e", "f"]

### Modifying the Possible *Group Size* Range
You may also pass an options `Hash` as the last argument to define the
possible range of the randomly determined *group size* at each iteration:

    numbers.riffle(letters, { min_group_size: 2, max_group_size: 8 })

**Note on Random Subsequence Lengths**

The resulting subsequence length from any given argument is *random*,
so it is very likely that consecutive runs will produce
different results.

    numbers.riffle(letters) # => [1, "a", "b", 2, 3, "c", 4, 5, 6, "d", "e", "f"]
    numbers.riffle(letters) # => [1, 2, 3, "a", "b", 4, 5, "c", "d", "e", 6, "f"]

## Installation

Add this line to your application's Gemfile:

    gem 'riffle'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install riffle

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Running Tests

    $ rspec spec
