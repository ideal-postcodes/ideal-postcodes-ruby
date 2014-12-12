require 'cgi'
require 'uri'
require 'json'
require 'rest-client'
require 'idealpostcodes/version'

# Require utility libraries
require 'idealpostcodes/util'
require 'idealpostcodes/errors'

# Require Resources
require 'idealpostcodes/key'
require 'idealpostcodes/address'
require 'idealpostcodes/postcode'

module IdealPostcodes
	@base_url = 'https://api.ideal-postcodes.co.uk'
	@version = '1'

	class << self
		attr_accessor :api_key, :base_url, :version, :secret
	end

	def self.request(method, path, params = {})
		unless @api_key
			raise IdealPostcodes::AuthenticationError.new('No API Key provided. ' +
				'Set your key with IdealPostcodes.api_key = #your_key')
		end

		url = URI.parse(resource_url(path))
		params.merge! api_key: @api_key
		url.query = Util.merge_params(params)
		request_options = {
			method: method.downcase.to_sym,
			url: url.to_s
		}

		begin
			response = generate_request(request_options)
		rescue RestClient::ExceptionWithResponse => error
			if rcode = error.http_code && rbody = error.http_body
				handle_error(rcode, rbody)
			else
				handle_client_error(error)
			end
		rescue RestClient::Exception, Errno::ECONNREFUSED => error
			handle_client_error(error)
		end
		parse response.body
	end

	def self.apply_secret(secret)
		@secret = secret
	end

	def self.key_available
		response = Key.lookup @api_key
		response[:available]
	end

	def self.key_details
		raise IdealPostcodes::AuthenticationError.new('No Secret Key provided. ' +
				'Set your secret key with IdealPostcodes.apply_secret #your_key') if @secret.nil?
		response = Key.lookup_details @api_key, @secret
	end

	private

	def self.resource_url(path='')
		URI.escape "#{@base_url}/v#{@version}/#{path}"
	end

	def self.generate_request(options)
		RestClient::Request.execute(options)
	end

	def self.parse(response)
		begin
      Util.keys_to_sym JSON.parse(response)
    rescue JSON::ParserError => e
      raise handle_client_error(e)
    end
	end

	def self.handle_error(http_code, http_body)
    error = parse http_body

		ideal_code, ideal_message = error[:code], error[:message]
		
		case ideal_code
		when 4010
			raise AuthenticationError.new ideal_message, http_code, http_body, ideal_code
		when 4020
			raise TokenExhaustedError.new ideal_message, http_code, http_body, ideal_code
		when 4021
			raise LimitReachedError.new ideal_message, http_code, http_body, ideal_code
		when 4040
			raise ResourceNotFoundError.new ideal_message, http_code, http_body, ideal_code
		else
			raise IdealPostcodesError.new ideal_message, http_code, http_body, ideal_code
		end
	end

	def self.handle_client_error(error)
		raise IdealPostcodesError.new("An unexpected error occured: #{error.message})")
	end

	def self.general_error(response_code, response_body)
		IdealPostcodesError.new 'Invalid response object', response_code, response_body
	end

end