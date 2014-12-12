require 'spec_helper'

describe IdealPostcodes do
	describe "#request" do
		it "generates a HTTP request" do
			response = IdealPostcodes.request :get, "postcodes/ID1 1QD"
			expect(response[:code]).to eq(2000)
		end
		it "raises an error if no key is provided" do
			old_key = IdealPostcodes.api_key
			IdealPostcodes.api_key = nil
			expect do
				response = IdealPostcodes.request :get, "postcodes/ID1 1QD"
			end.to raise_error(IdealPostcodes::AuthenticationError)
			IdealPostcodes.api_key = old_key
		end
		it "raises authentication error if invalid key is provided" do
			old_key = IdealPostcodes.api_key
			IdealPostcodes.api_key = "foo"
			expect do
				response = IdealPostcodes.request :get, "postcodes/ID1 1QD"
			end.to raise_error(IdealPostcodes::AuthenticationError)
			IdealPostcodes.api_key = old_key
		end
		it "raises token exhausted error if key balance is depleted" do
			expect do
				response = IdealPostcodes.request :get, "postcodes/ID1 CLIP"
			end.to raise_error(IdealPostcodes::TokenExhaustedError)
		end
		it "raises limit reached error if a limit has been breached" do
			expect do
				response = IdealPostcodes.request :get, "postcodes/ID1 CHOP"
			end.to raise_error(IdealPostcodes::LimitReachedError)
		end
	end
end