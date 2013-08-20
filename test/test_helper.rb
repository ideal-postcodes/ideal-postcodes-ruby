require 'test/unit'
require 'mocha/setup'
require 'ideal-postcodes'
require 'shoulda'

module IdealPostcodes

	attr_accessor :mock

	def self.mock=(mock)
		@mock = mock
	end

	def self.generate_request(options)
		method = options[:method]
		url = options[:url]
		@mock.execute method, url
	end

end

def test_response(body, status=200)
	body = MultiJson.dump(body)
	m = mock
	m.instance_variable_set('@instance_vals', {code: status, body: body})
	def m.body; @instance_vals[:body]; end
	def m.code; @instance_vals[:code]; end
	m
end

def test_postcode
	"ID11QD"
end

def valid_postcode(params={})
	{
		result: [
			{
				postcode: "ID1 1QD",
				post_town: "LONDON",
				line_1: "Kingsley Hall",
				line_2: "Powis Road",
				line_3: ""
			}
		],
		message: "Success",
		code: 2000 
	}
end

def invalid_postcode
	{
		message: "Postcode not found",
		code: 4040
	}
end

def invalid_token
	{
		message: "Invalid key",
		code: 4010 
	}
end

def limit_reached
	{
		code: 4021,
		message: "Lookup Limit Reached"
	}
end

def token_exhausted
	{
		code: 4020,
		message: "Token exhausted"
	}
end