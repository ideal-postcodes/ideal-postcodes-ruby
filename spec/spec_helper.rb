# Enable VCR
require 'vcr'
require 'webmock'

WebMock.enable!

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
end

# Configure Ideal Postcodes lib
require 'ideal_postcodes'

RSpec.configure do |c|
  c.before(:each) do
    IdealPostcodes.base_url = 'https://localhost:1337'
    IdealPostcodes.api_key = 'gandhi'
    IdealPostcodes.apply_secret nil
  end

  c.around(:each) do |example|
    VCR.use_cassette(example.metadata[:full_description]) { example.run }
  end
end

def contains_attributes(attribute_list, target)
  result = true
  attribute_list.each { |attribute| result = false if target[attribute].nil? }
  result
end

def postcode_location_elements
  %i[postcode longitude latitude northings eastings]
end

def is_postcode_location(postcode)
  contains_attributes postcode_location_elements, postcode
end

def address_elements
  %i[
    postcode
    postcode_inward
    postcode_outward
    post_town
    dependant_locality
    double_dependant_locality
    thoroughfare
    dependant_thoroughfare
    building_number
    building_name
    sub_building_name
    po_box
    department_name
    organisation_name
    udprn
    postcode_type
    su_organisation_indicator
    delivery_point_suffix
    line_1
    line_2
    line_3
    premise
    county
    district
    ward
    longitude
    latitude
    eastings
    northings
  ]
end

def is_address(address)
  contains_attributes address_elements, address
end

def key_elements
  %i[lookups_remaining daily_limit individual_limit allowed_urls notifications]
end

def is_key(key)
  contains_attributes key_elements, key
end

def secret_key
  'uk_hxp6ouk0rmyXoobVJnehrsQcdvTfb'
end
