require 'spec_helper'

describe IdealPostcodes::Key do
	describe '.lookup' do
		it 'returns the availability status of a key (true key)' do
			result = IdealPostcodes::Key.lookup "iddqd"
			expect(result[:available]).to eq(true)
		end
		it 'returns the availability status of a key (false key)' do
			result = IdealPostcodes::Key.lookup "idkfa"
			expect(result[:available]).to eq(false)
		end
	end	

	describe '.lookup_details' do
		it 'returns key details' do
			result = IdealPostcodes::Key.lookup_details "gandhi", "uk_hxp6ouk0rmyXoobVJnehrsQcdvTfb"
			expect(result[:lookups_remaining]).to_not be_nil
			expect(result[:daily_limit]).to_not be_nil
			expect(result[:individual_limit]).to_not be_nil
			expect(result[:allowed_urls]).to_not be_nil
			expect(result[:notifications]).to_not be_nil
		end
	end
end