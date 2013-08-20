module IdealPostcodes
	class Postcode

		attr_reader :postcode_data, :postcode, :addresses

		def initialize(postcode = nil, postcode_data = nil)
			@raw = postcode_data
			@addresses = (postcode_data.nil? || postcode_data[:result].nil?) ? [] : postcode_data[:result]
			@postcode = postcode
		end

		def self.lookup(postcode)
			begin
				response = IdealPostcodes.request :get, "postcodes/#{postcode}"
			rescue IdealPostcodes::ResourceNotFoundError => error
				raise error unless error.response_code == 4040
				response = nil
			end
			new postcode, response
		end

		def empty?
			@raw.nil?
		end

		def addresses
			@addresses
		end

		def to_s
			addresses.to_s
		end

	end
end