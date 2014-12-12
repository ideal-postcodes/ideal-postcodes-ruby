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

	describe '.search' do
		it 'returns results in a SearchResult object' do
			results = IdealPostcodes::Address.search "ID1 1QD"
			expect(results).to be_a(IdealPostcodes::Address::SearchResult)
			expect(results.addresses.length).to be > 0
			results.addresses.each do |address|
				expect(is_address(address)).to eq(true)
			end
		end
		it 'is sensitive to limit' do
			limit = 1
			results = IdealPostcodes::Address.search "High Street", limit: limit
			expect(results.addresses.length).to equal(limit)
			expect(results.limit).to equal(limit)
		end
		it 'is sensitive to page' do
			page = 1
			results = IdealPostcodes::Address.search "High Street", page: page
			expect(results.page).to equal(page)
		end
		it 'raises an exception if invalid key' do
			old_key = IdealPostcodes.api_key
			IdealPostcodes.api_key = 'foo'
			expect {
				results = IdealPostcodes::Address.search "ID1 1QD"
			}.to raise_error(IdealPostcodes::AuthenticationError)
			IdealPostcodes.api_key = old_key
		end
		it 'raises an exception if no lookups remaining' do
			expect {
				results = IdealPostcodes::Address.search "ID1 CLIP"
			}.to raise_error(IdealPostcodes::TokenExhaustedError)
		end
		it 'raises an exception if limit breached' do
			expect {
				results = IdealPostcodes::Address.search "ID1 CHOP"
			}.to raise_error(IdealPostcodes::LimitReachedError)
		end
	end
end
