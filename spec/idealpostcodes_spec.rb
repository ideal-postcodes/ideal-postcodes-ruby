require 'spec_helper'

describe IdealPostcodes do
	describe '#request' do
		it 'generates a HTTP request' do
			response = IdealPostcodes.request :get, 'postcodes/ID1 1QD'
			expect(response[:code]).to eq(2000)
		end
		it 'raises an error if no key is provided' do
			IdealPostcodes.api_key = nil
			expect do
				response = IdealPostcodes.request :get, 'postcodes/ID1 1QD'
			end.to raise_error(IdealPostcodes::AuthenticationError)
		end
		it 'raises authentication error if invalid key is provided' do
			IdealPostcodes.api_key = 'foo'
			expect do
				response = IdealPostcodes.request :get, 'postcodes/ID1 1QD'
			end.to raise_error(IdealPostcodes::AuthenticationError)
		end
		it 'raises token exhausted error if key balance is depleted' do
			expect do
				response = IdealPostcodes.request :get, 'postcodes/ID1 CLIP'
			end.to raise_error(IdealPostcodes::TokenExhaustedError)
		end
		it 'raises limit reached error if a limit has been breached' do
			expect do
				response = IdealPostcodes.request :get, 'postcodes/ID1 CHOP'
			end.to raise_error(IdealPostcodes::LimitReachedError)
		end
	end

	describe '.key_available' do
		it 'returns true if key is available' do
			IdealPostcodes.api_key = "iddqd"
			expect(IdealPostcodes.key_available).to equal(true)
		end
		it 'returns false if key is unavailable' do
			IdealPostcodes.api_key = "idkfa"
			expect(IdealPostcodes.key_available).to equal(false)
		end
	end

	describe '.key_details' do
		it 'raises an exception if no secret is provided' do
			expect {
				IdealPostcodes.key_details
			}.to raise_error(IdealPostcodes::AuthenticationError)
		end
		it 'returns key information' do
			IdealPostcodes.apply_secret(secret_key)
			response = IdealPostcodes.key_details
			expect(is_key(response)).to eq(true)
		end
	end
end