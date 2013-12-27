
module Riffle
  module Array
    def riffle(*args)
      result = []

      return self if args.empty?

      opts = args.pop if args.length > 1 && args.last.is_a?(Hash)

      min_group_size = (opts && opts[:min_group_size]) || 1
      max_group_size = (opts && opts[:max_group_size]) || 3

      # insert self at front of args list
      args.unshift self

      unless args.select { |a| !a.is_a? Array }.empty?
        raise ArgumentError, "All arguments must be of type `Array`"
      end

      until args.flatten.empty?
        args.each_with_index do |arg, i|
          group_size = rand(min_group_size..max_group_size)
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
  end
end
