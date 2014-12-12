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


def postcode_location_elements
	[:postcode, :longitude, :latitude, :northings, :eastings]
end

def is_postcode_location(postcode)
	result = true
	postcode_location_elements.each do |attribute|
		result = false if postcode[attribute].nil?
	end
	result
end

def address_elements
	[:postcode, :postcode_inward, :postcode_outward, :post_town, :dependant_locality, 
		:double_dependant_locality, :thoroughfare, :dependant_thoroughfare, 
		:building_number, :building_name, :sub_building_name, :po_box, :department_name, 
		:organisation_name, :udprn, :postcode_type, :su_organisation_indicator, 
		:delivery_point_suffix, :line_1, :line_2, :line_3, :premise, :county, 
		:district, :ward, :longitude, :latitude, :eastings, :northings]
end

def is_address(address)
	result = true
	address_elements.each do |attribute|
		result = false if address[attribute].nil?
	end
	result
end