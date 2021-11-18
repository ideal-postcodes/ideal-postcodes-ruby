require 'uri'

module IdealPostcodes
  DEFAULT_PARSER = URI::Parser.new

  class Util
    def self.escape(str)
      IdealPostcodes::DEFAULT_PARSER.escape(str)
    end

    def self.merge_params(hash)
      result = []
      hash.each do |key, value|
        result << "#{escape(key.to_s)}=#{escape(value.to_s)}"
      end
      result.join('&')
    end

    def self.keys_to_sym(object)
      case object
      when Hash
        temp = {}
        object.each do |key, value|
          key =
            (
              begin
                key.to_sym
              rescue StandardError
                key
              end
            ) || key
          temp[key] = keys_to_sym(value)
        end
        temp
      when Array
        object.map { |elem| keys_to_sym(elem) }
      else
        object
      end
    end
  end
end
