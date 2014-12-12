module IdealPostcodes
	module Postcode
		def self.lookup postcode
			begin
				response = IdealPostcodes.request :get, "postcodes/#{postcode}"
				addresses = response[:result]
			rescue IdealPostcodes::ResourceNotFoundError => error
				raise error unless error.response_code == 4040
				addresses = []
			end
			addresses
		end

		def self.find_by_location geolocation
			query = {lonlat: "#{geolocation[:longitude]},#{geolocation[:latitude]}"}
			query[:limit] = geolocation[:limit] unless geolocation[:limit].nil?
			query[:radius] = geolocation[:radius] unless geolocation[:radius].nil?

			response = IdealPostcodes.request :get, 'postcodes', query

			response[:result]
		end
	end
end