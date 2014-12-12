require 'spec_helper'

describe IdealPostcodes::Address do
	describe '.lookup' do
		it 'returns an address for a valid UDPRN' do
			address = IdealPostcodes::Address.lookup 0
			expect(is_address(address)).to eq(true)
		end
		it 'returns nil for an invalid UDPRN' do
			address = IdealPostcodes::Address.lookup -1
			expect(address).to be_nil
		end
		it 'raises an exception if invalid key' do
			old_key = IdealPostcodes.api_key
			IdealPostcodes.api_key = 'foo'
			expect {
				IdealPostcodes::Address.lookup 0
			}.to raise_error(IdealPostcodes::AuthenticationError)
			IdealPostcodes.api_key = old_key
		end
		it 'raises an exception if no lookups remaining' do
			expect {
				IdealPostcodes::Address.lookup -2
			}.to raise_error(IdealPostcodes::TokenExhaustedError)
		end
		it 'raises an exception if limit breached' do
			expect {
				IdealPostcodes::Address.lookup -3
			}.to raise_error(IdealPostcodes::LimitReachedError)
		end
	end	
end
