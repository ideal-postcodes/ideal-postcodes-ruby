module IdealPostcodes
	module Address
		def self.lookup(udprn)
			begin
				response = IdealPostcodes.request :get, "addresses/#{udprn}"
				address = response[:result]
			rescue IdealPostcodes::IdealPostcodesError => error
				raise error unless error.response_code == 4044
				address = nil
			end
			address
		end
	end
end