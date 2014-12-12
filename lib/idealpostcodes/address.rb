module IdealPostcodes
	module Address
		class SearchResult
			attr_reader :page, :limit, :addresses
			def initialize response
				@page = response[:result][:page]
				@limit = response[:result][:limit]
				@addresses = response[:result][:hits]
			end
		end

		def self.lookup udprn
			begin
				response = IdealPostcodes.request :get, "addresses/#{udprn}"
				address = response[:result]
			rescue IdealPostcodes::IdealPostcodesError => error
				raise error unless error.response_code == 4044
				address = nil
			end
			address
		end

		def self.search search_term, options = {}
			query = { query: search_term }
			query[:limit] = options[:limit] unless options[:limit].nil?
			query[:page] = options[:page] unless options[:page].nil?
			response = IdealPostcodes.request :get, "addresses", query
			SearchResult.new response
		end
	end
end