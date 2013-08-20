require File.expand_path('../test_helper', __FILE__)

class TestIdealPostcodes < Test::Unit::TestCase
	include Mocha

	context "API" do

		setup do
			@mock = mock
			IdealPostcodes.mock = @mock
		end

		teardown do
			IdealPostcodes.mock = nil
		end

		should "raise an exception if no API key set" do
			IdealPostcodes.api_key = nil
			assert_raises IdealPostcodes::AuthenticationError do
				postcode = IdealPostcodes::Postcode.lookup(test_postcode)
			end
		end

		should "raise an exception if authentication failed" do
			IdealPostcodes.api_key = "BOGUS"
			response = test_response invalid_token
			assert_raises IdealPostcodes::AuthenticationError do
				@mock.expects(:execute).raises(RestClient::ExceptionWithResponse.new(response, 401))
				IdealPostcodes::Postcode.lookup(test_postcode)
			end
		end

		context "Valid API key" do

			setup do
				IdealPostcodes.api_key = "correctkey"
			end

			teardown do
				IdealPostcodes.api_key = nil
			end

			should "raise an exception if tokens exhausted" do
				response = test_response token_exhausted
				assert_raises IdealPostcodes::TokenExhaustedError do
					@mock.expects(:execute).raises(RestClient::ExceptionWithResponse.new(response, 402))
					IdealPostcodes::Postcode.lookup(test_postcode)
				end
			end

			should "raise an exception if limit has been breached" do
				response = test_response limit_reached
				assert_raises IdealPostcodes::LimitReachedError do
					@mock.expects(:execute).raises(RestClient::ExceptionWithResponse.new(response, 402))
					IdealPostcodes::Postcode.lookup(test_postcode)
				end
			end

			should "return postcode object with addresses for valid postcode" do
				response = test_response valid_postcode
				@mock.expects(:execute).returns(response)
				postcode = IdealPostcodes::Postcode.lookup(test_postcode)
				assert_equal postcode.empty?, false
				assert_equal postcode.addresses, valid_postcode[:result]
			end

			should "return postcode object with empty array for non-existent postcode" do
				response = test_response invalid_postcode
				@mock.expects(:execute).raises(RestClient::ExceptionWithResponse.new(response, 404))
				postcode = IdealPostcodes::Postcode.lookup(test_postcode)
				assert_equal postcode.empty?, true
			end

		end

	end

end