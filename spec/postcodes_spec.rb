require "spec_helper"

describe IdealPostcodes::Postcode do
	describe "#lookup" do
		it "returns a list of addresses for a postcode" do
			postcode = IdealPostcodes::Postcode.lookup "ID1 1QD"
			expect(postcode.addresses.length).to be > 0
			postcode.addresses.each do |address|
				expect(address[:postcode]).to eq("ID1 1QD")
			end
		end
		it "returns an empty array if postcode does not exist" do
			postcode = IdealPostcodes::Postcode.lookup "ID1 KFA"
			expect(postcode.addresses.length).to eq(0)
		end
		it "raises an exception if key has run out of balance" do
			expect {
				IdealPostcodes::Postcode.lookup "ID1 CLIP"
			}.to raise_error(IdealPostcodes::TokenExhaustedError)
		end
		it "raises an exception if limit has been reached" do
			expect {
				IdealPostcodes::Postcode.lookup "ID1 CHOP"
			}.to raise_error(IdealPostcodes::LimitReachedError)
		end
		it "raises an exception if invalid key" do
			old_key = IdealPostcodes.api_key
			IdealPostcodes.api_key = "foo"
			expect {
				IdealPostcodes::Postcode.lookup "ID1 1QD"
			}.to raise_error(IdealPostcodes::AuthenticationError)
			IdealPostcodes.api_key = "foo"
		end
	end
end