# Enable VCR
require 'vcr'

VCR.configure do |c|
	c.cassette_library_dir = 'spec/vcr_cassettes'
	c.hook_into :webmock
end

RSpec.configure do |c|
	c.around(:each) do |example|
		VCR.use_cassette(example.metadata[:full_description]) do
			example.run
		end
	end
end

# Configure Ideal Postcodes lib
require 'ideal_postcodes'
IdealPostcodes.base_url = 'https://localhost:1337'
IdealPostcodes.api_key = "gandhi"
