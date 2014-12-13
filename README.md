# Ideal Postcodes Ruby Library [![Build Status](https://travis-ci.org/ideal-postcodes/ideal-postcodes-ruby.png)](https://travis-ci.org/ideal-postcodes/ideal-postcodes-ruby)

Ideal Postcodes is a simple JSON API to query UK postcodes and addresses. Find out more at [Ideal-Postcodes.co.uk](https://ideal-postcodes.co.uk/)

Our API uses Royal Mail's Postcode Address File and is updated daily. Each method incurs a small charge (typically 2p) - free methods are labelled as such and are based on open data sources.

## Getting Started

**Install**

```bash
gem install ideal_postcodes
```

Alternatively, include this in your gemfile and bundle install

```ruby
gem 'ideal_postcodes'
```

**Create a Key**

Sign up at [Ideal-Postcodes.co.uk](https://ideal-postcodes.co.uk) and create a key.

**Configure**

Drop in your key when using the library.

```ruby
IdealPostcodes.api_key = "your_key_goes_here"
```

## Error Handling

It's important that you lookout for common exceptions when interacting with the API. The most common exceptions can be caught as shown below.

```ruby
begin
  IdealPostcodes::Postcode.lookup "ID1 1QD"
rescue IdealPostcodes::AuthenticationError => e
	# Invalid API Key
rescue IdealPostcodes::TokenExhaustedError => e
	# Token has run out of lookups
rescue IdealPostcodes::LimitReachedError => e
	# One of your predefinied limits has been reached
rescue IdealPostcodes::IdealPostcodesError => e
	# API Error
rescue => e
	# An unexpected error
end
```

Possible errors to look out for are listed in the [documentation](https://ideal-postcodes.co.uk/documentatpion/response-codes).

## Methods

The client provides a number of methods to allow you to get specific jobs done quickly and easily. These methods are listed below.




## Get all addresses for a postcode [(docs)](https://ideal-postcodes.co.uk/documentation/postcodes#postcode)

```
IdealPostcodes::Postcode.lookup postcode
```

Returns an array of addresses representing all addresses at the specified postcode.

**Arguments**

- `postcode` (string). The postcode you want to lookup, case and space insensitive.

**Returns**

An array of hashes which represent each address at the postcode. Returns an empty array for an invalid postcode.

**Example**

```ruby
addresses = IdealPostcodes::Postcode.lookup "ID1 1QD"

if addresses.empty? 
	puts "Your postcode doesn't have a match"
else
	puts addresses
end

# addresses =>
#[
#  {
#   :postcode => "ID1 1QD",
#   :post_town => "LONDON",
#   :line_1 => "Kingsley Hall",
#   :line_2 => "Powis Road",
#   :line_3 => "",
#   :organisation_name => "",
#   :building_name => "Kingsley Hall",
#   :udprn => 12345678
#   ... and so on
```

**Notes**

**Data Source:** Royal Mail Postcode Address File. Ordnance Survey.

Use the postcode "ID1 1QD" to test this method for free. The complete list of test postcodes is available in the [documentation](https://ideal-postcodes/documentation/postcodes).




## Search for an address [(docs)](https://ideal-postcodes.co.uk/documentation/addresses#query)

Perform a search for addresses which match your search term.

**Arguments**

- `search_term` (string). The address you wish to search for
- `options` (hash, optional). Customise your search. 
	- `limit` (number). The maximum number of returned results per page
	-	`page` (number). Page of results to return (starts at page 0)

**Returns**

Returns a search result object with the following attributes.

- `addresses` (Array). An array of hashes which represent each address at the postcode. The array is ordered by how close the search term and address match.
- `limit` (Number). The maximum number of returned results per page.
- `page` (Number). The returned page of results.


**Example**

```ruby
IdealPostcodes::Address.search "10 Downing Street London"

r.limit # => 10
r.page  # => 0
r.addresses

#[
#  {
#    :line_1=>"Prime Minister & First Lord Of The Treasury", 
#    :line_2=>"10 Downing Street", 
#    :line_3=>"", 
#    :post_town=>"LONDON",  
#    :postcode=>"SW1A 2AA", 
#    :organisation_name=>"Prime Minister & First Lord Of The Treasury", 
#    :premise=>"10", 
#    :latitude=>51.5035398826274
#    :longitude=>-0.127695242183412, 
#    :thoroughfare=>"Downing Street", 
#    :district=>"Westminster", 
#    :ward=>"St James's", 
#    :building_number=>"10", 
#    :udprn=>23747771, 
#	... and so on
```

**Notes**

Data source: Royal Mail Postcode Address File, Ordnance Survey.

Use the address "ID1 1QD" to test integration for free. The complete list of test methods is available in the [documentation](https://ideal-postcodes/documentation/addresses).




## Get nearby postcode for a given geolocation [(docs)](https://ideal-postcodes.co.uk/documentation/postcodes#lonlat)

Retrieve the nearest postcodes for a given geolocation. Free to use.

```ruby
IdealPostcodes::Postcode.find_by_location longitude: lon, latitude: lat
```

**Arguments**

- `location` (Hash)
	- `longitude` (number, required)
	- `latitude` (number, required)
	- `limit` (number, optional) Maximum number of results to return 
	- `radius` (number, optional) search radius (in metres)

**Returns**

An array of hashes which represent the nearest postcodes to the specified location. Ordered by distance from location.

**Example**

```ruby
postcodes = IdealPostcodes::Postcode.find_by_location longitude: 0.629834, latitude: 51.79232

# postcodes =>
#[
#  {
#    :postcode=>"CM8 1EF", 
#    :northings=>213679, 
#    :eastings=>581461, 
#    :longitude=>0.629834723775309, 
#    :latitude=>51.7923246977375, 
#    :distance=>0.52506633}, 
#  {
#    :postcode=>"CM8 1EU", 
#    :northings=>213650, 
#    :eastings=>581507, 
#    :longitude=>0.630485817275861, 
#    :latitude=>51.7920493205979, 
#    :distance=>54.12525282
#  },
```

**Notes**

Data source: Ordnance Survey. Free to use.



## Retrieve an address using UDPRN [(docs)](https://ideal-postcodes.co.uk/documentation/addresses#address)

Retrieve the specific address for a specific UDPRN.

```ruby
IdealPostcodes::Address.lookup udprn
```

**Arguments**

- `udprn` (string | number). A number which uniquely identifies the address.

**Returns**

Returns a hash representing the matching address. Returns `nil` if no matching address is found.

**Example**

```ruby
IdealPostcodes::Address.lookup 23747771

#{
#  :line_1=>"Prime Minister & First Lord Of The Treasury", 
#  :line_2=>"10 Downing Street", 
#  :line_3=>"", 
#  :post_town=>"LONDON",  
#  :postcode=>"SW1A 2AA", 
#  :organisation_name=>"Prime Minister & First Lord Of The Treasury", 
#  :premise=>"10", 
#  :latitude=>51.5035398826274
#  :longitude=>-0.127695242183412, 
#  :thoroughfare=>"Downing Street", 
#  :district=>"Westminster", 
#  :ward=>"St James's", 
#  :building_number=>"10", 
#  :udprn=>23747771, 
#  ... and so on
```

**Notes**

Data source: Royal Mail Postcode Address File, Ordnance Survey.

Use the address `0` to test integration for free. The complete list of test methods is available in the [documentation](https://ideal-postcodes/documentation/addresses).

## Utility Methods

Listed below are free utility methods, e.g. finding the status of your key.

### Find out if your key is in a usable state [(docs)](https://ideal-postcodes.co.uk/documentation/keys#key)

Find out if your key is in a usable state. E.g. it has a positive balance, it is currently under your defined usage limits, etc.

```
IdealPostcodes.key_available
```

**Arguments**

None.

**Returns**

- availability (Boolean). Returns true if key can be used. False if something is preventing the key from making lookups e.g. insufficient balance, reached limits, etc.

**Example**

```ruby
IdealPostcodes.key_available # => true, you're clear to make lookups
```

### Find out private key information [(docs)](https://ideal-postcodes.co.uk/documentation/keys#details)

This method reveals private information about your key such as the lookup balance, whitelisted URLs, etc. Note: a secret key is required to invoke this method.

```
IdealPostcodes.key_details
```

**Arguments**

None.

**Returns**

Returns a hash containing pertinent private information about your key.

**Example**

```ruby
IdealPostcodes.key_details

# {
# 	:lookups_remaining=>9678, 
# 	:daily_limit=>{
# 		:limit=>100, 
# 		:consumed=>1
# 	}, 
# 	:individual_limit=>{
# 		:limit=>15
# 	}, 
# 	:allowed_urls=>["foo.com"], 
# 	:notifications=>{
# 		:emails=>["bar@baz.com"], 
# 	:enabled=>true}, 
# 	:automated_topups=>{
# 		:enabled=>true
# 	}
# }
```

If you intend to use this method, you must pass your secret key (which can be found on your [account page](https://ideal-postcodes.co.uk/account)) along with your API key when instantiating the client. E.g.

```ruby
IdealPostcodes.apply_secret "your secret key"
```

Do not share your secret key and avoid commiting this key to your codebase.


## Changelog

*1.0.0*
- Major rewrite to make way for more resources
- Breaking change applied to postcode lookup functionality
- Implemented [addresses resource](https://ideal-postcodes.co.uk/documentation/addresses)
- Implemented [keys resource](https://ideal-postcodes.co.uk/documentation/keys)
- Implemented [postcodes resource](https://ideal-postcodes.co.uk/documentation/postcodes). Added location-based postcode searches
- Swapped out test suite with rspec and vcr

## Testing

```
bundle exec rake
```

## License

MIT