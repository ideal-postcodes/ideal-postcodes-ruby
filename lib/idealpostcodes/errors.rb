module IdealPostcodes
	class IdealPostcodesError < StandardError
		attr_reader :message
		attr_reader :http_code
		attr_reader :http_body
		attr_reader :response_code

		def initialize(message = nil, http_code = nil, http_body = nil, response_code = nil)
			@message = message
			@http_code = http_code
			@http_body = http_body
			@response_code = response_code
		end

		def to_s
			status = @http_code.nil? ? "" : "#{@http_code} error."
			ideal_code = @response_code.nil ? "" : "(#{@response_code})"
			"#{status} error. (#{ideal_code}) #{message}"
		end
	end

	class AuthenticationError< IdealPostcodesError
	end

	class TokenExhaustedError < IdealPostcodesError
	end

	class LimitReachedError < IdealPostcodesError
	end

	class ResourceNotFoundError < IdealPostcodesError
	end
end