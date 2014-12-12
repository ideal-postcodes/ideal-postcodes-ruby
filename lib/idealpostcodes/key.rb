module IdealPostcodes
	module Key
		def self.lookup api_key
			response = IdealPostcodes.request :get, "keys/#{api_key}"
			response[:result]
		end

		def self.lookup_details api_key, secret
			response = IdealPostcodes.request :get, "keys/#{api_key}", { user_token: secret }
			response[:result]
		end
	end
end