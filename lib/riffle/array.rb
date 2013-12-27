
module Riffle
  module Array
    def riffle(*args)
      result = []

      return self if args.empty?

      opts = get_opts_from_args(args)

      # insert self at front of args list if self is an Array instance
      args.unshift self if self.is_a?(Array)

      opts[:range] ||= (1..3)

      unless args.select { |a| !a.is_a? Array }.empty?
        raise ArgumentError, "All arguments must be of type `Array`"
      end

      until args.flatten.empty?
        args.each_with_index do |arg, i|
          group_size = rand(opts[:range])
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
