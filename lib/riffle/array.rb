
module Riffle
  module Array
    DEFAULT_RANGE = (1..3)

    def riffle(*args)
      opts = get_opts_from_args(args)
      sources = get_sources_from_args(args)
      config = configure(sources, opts)

      unless sources_valid?(sources)
        raise ArgumentError, "All arguments must be of type `Array`"
      end

      return [] if sources.empty?
      return sources.first if sources.length == 1

      result = []

      until sources.flatten.empty?
        sources.each_with_index do |source, i|
          group_size = config[:prng].rand(config[:ranges][i])
          if source.length < group_size
            result.concat source
            sources[i] = []
          else
            result.concat source.take(group_size)
            sources[i] = source.drop group_size
          end
        end
      end

      result
    end

    private

    def get_opts_from_args(args)
      args.last.is_a?(Hash) ? args.last : {}
    end

    def get_sources_from_args(args)
      args.last.is_a?(Hash) ? args[0...-1] : args
    end

    def configure(sources, opts)
      config = {}
      config[:ranges] = configure_ranges(sources.length, opts)
      config[:prng] = configure_prng(opts[:seed])
      config
    end

    def configure_ranges(sources_length, opts)
      if opts[:range] && opts[:ranges]
        raise ArgumentError, "Cannot pass both :range and :ranges options simultaneously"
      end

      if opts[:ranges].is_a?(::Array)
        if opts[:ranges].length != sources_length
          raise ArgumentError, ":ranges length does not match sources length"
        end

        unless opts[:ranges].select { |r| !r.is_a?(Range) }.empty?
          raise ArgumentError, "All :ranges must be of type `Range`"
        end

        return opts[:ranges]
      end

      range = opts[:range].is_a?(Range) ? opts[:range] : DEFAULT_RANGE

      return [range] * sources_length
    end

    def configure_prng(seed = nil)
      # Random.new(nil) explodes for some reason...
      seed.nil? ? Random.new : Random.new(seed)
    end

    def sources_valid?(sources)
      sources.select { |a| !a.is_a? ::Array }.empty?
    end
  end
end
