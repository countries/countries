# frozen_string_literal: true

module ISO3166
  class KwargStruct < Struct
    # Override the initialize to handle hashes of named parameters
    def initialize(*args)
      opts = args.last.is_a?(Hash) ? args.pop : {}
      super(*args)
      opts.each_pair do |k, v|
        send "#{k}=", v
      end
    end
  end
end
