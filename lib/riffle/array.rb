
module Riffle
  module Array
    def riffle(*args)
      result = []

      # handle empty or insufficient args
      if self == ::Array && args.length < 2
        return args.empty? ? [] : args.first
      elsif self.is_a?(::Array) && args.empty?
        return self
      end

      opts = get_opts_from_args(args)

      opts[:range] ||= (1..3)

      unless args.select { |a| !a.is_a? ::Array }.empty?
        raise ArgumentError, "All arguments must be of type `Array`"
      end

      # insert self at front of args list if self is an Array instance
      args.unshift self if self.is_a?(::Array)

      # Random.new(nil) explodes for some reason...
      if opts[:seed].nil?
        prng = Random.new
      else
        prng = Random.new(opts[:seed])
      end

      until args.flatten.empty?
        args.each_with_index do |arg, i|
          group_size = prng.rand(opts[:range])
          if arg.length < group_size
            result.concat arg
            args[i] = []
          else
            result.concat arg.take(group_size)
            args[i] = arg.drop group_size
          end
        end
      end

      result
    end

    private

    def get_opts_from_args(args)
      opts_passed?(args) ? args.pop : {}
    end

    def opts_passed?(args)
      args.length > 1 && args.last.is_a?(Hash)
    end
  end
end
