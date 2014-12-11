require 'spec_helper'

describe IdealPostcodes do
	describe "#request" do
		it "generates a HTTP request"
		it "raises an error if no key is provided"
		it "raises authentication error if invalid key is provided"
		it "raises token exhausted error if key balance is depleted"
		it "raises limit reached error if a limit has been breached"
		it "raises 404 for invalid resource"
	end
end