require 'spec_helper'

describe IdealPostcodes::Postcode do
	describe '.lookup' do
		it 'returns a list of addresses for a postcode' do
			addresses = IdealPostcodes::Postcode.lookup 'ID1 1QD'
			expect(addresses.length).to be > 0
			addresses.each do |address|
				expect(is_address(address)).to eq(true)
				expect(address[:postcode]).to eq('ID1 1QD')
			end
		end
		it 'returns an empty array if postcode does not exist' do
			addresses = IdealPostcodes::Postcode.lookup 'ID1 KFA'
			expect(addresses.length).to eq(0)
		end
		it 'raises an exception if key has run out of balance' do
			expect {
				IdealPostcodes::Postcode.lookup 'ID1 CLIP'
			}.to raise_error(IdealPostcodes::TokenExhaustedError)
		end
		it 'raises an exception if limit has been reached' do
			expect {
				IdealPostcodes::Postcode.lookup 'ID1 CHOP'
			}.to raise_error(IdealPostcodes::LimitReachedError)
		end
		it 'raises an exception if invalid key' do
			IdealPostcodes.api_key = 'foo'
			expect {
				IdealPostcodes::Postcode.lookup 'ID1 1QD'
			}.to raise_error(IdealPostcodes::AuthenticationError)
		end
	end
	describe '.find_by_location' do
		it 'returns an array of postcodes and locations' do
			lon = 0.6298
			lat = 51.7923
			postcodes = IdealPostcodes::Postcode.find_by_location longitude: lon, latitude: lat
			expect(postcodes.length).to be > 0
			postcodes.each do |postcode|
				expect(is_postcode_location(postcode)).to eq(true)
			end
		end
		it 'returns an empty array if no results are found' do
			lon = 0
			lat = 0
			postcodes = IdealPostcodes::Postcode.find_by_location longitude: lon, latitude: lat
			expect(postcodes).to be_a(Array)
			expect(postcodes.length).to eq(0)
		end
		it 'is sensitive to limit parameter' do
			lon = 0.6298
			lat = 51.7923
			limit = 1
			postcodes = IdealPostcodes::Postcode.find_by_location longitude: lon, latitude: lat, limit: limit
			expect(postcodes.length).to eq(limit)
		end
		it 'is sensitive to radius parament' do
			lon = 0.6298
			lat = 51.7923
			small_radius = IdealPostcodes::Postcode.find_by_location longitude: lon, latitude: lat, radius: 10
			large_radius = IdealPostcodes::Postcode.find_by_location longitude: lon, latitude: lat, radius: 100
			expect(large_radius.length > small_radius.length).to eq(true)
		end
	end
end