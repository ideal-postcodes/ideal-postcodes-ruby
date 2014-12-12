# Ideal Postcodes Ruby Library [![Build Status](https://travis-ci.org/ideal-postcodes/ideal-postcodes-ruby.png)](https://travis-ci.org/ideal-postcodes/ideal-postcodes-ruby)

Ideal Postcodes is a simple JSON API to query UK postcodes and addresses. Find out more at [Ideal-Postcodes.co.uk](https://ideal-postcodes.co.uk/)

Our API is based off Royal Mail's Postcode Address File and is updated daily. Each convenience method incurs a small charge (typically 2p) - free methods are labelled as free and based off open data sources.

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

Communication with the API requires a key.

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

### Get all addresses for a postcode [(docs)](https://ideal-postcodes.co.uk/documentation/postcodes#postcode)

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

if postcode.empty? 
	puts "Your postcode doesn't have a match"
else
	puts addresses
end

# addresses =>
# [
#  {
#   :postcode => "ID1 1QD",
#   :post_town => "LONDON",
#   :line_1 => "Kingsley Hall",
#   :line_2 => "Powis Road",
#   :line_3 => "",
#   :organisation_name => "",
#   :building_name => "Kingsley Hall",
#   :udprn => 12345678
#  }, ... and so on
```

**Notes**

Data source: Royal Mail Postcode Address File, Ordance Survey. Not free.

Use the postcode "ID1 1QD" to test this method for free. The complete list of test postcodes is available in the [documentation](https://ideal-postcodes/documentation/postcodes).

### Search for an address [(docs)](https://ideal-postcodes.co.uk/documentation/addresses#query)

Perform a search for addresses which match your search term.

```ruby
IdealPostcodes::Address.search search_term[, options]
```

**Arguments**

- `search_term` (string). The address you wish to search for
- `options` (hash, optional). Customise your search. 
	- `limit` (number). The maximum number of returned results per page
	-	`page` (number). Page of results to return (starts at page 0)

**Returns**

What does it return

**Notes**

Data source: Royal Mail Postcode Address File, Ordance Survey. Not free.

Use the address "ID1 1QD" to test integration for free. The complete list of test methods is available in the [documentation](https://ideal-postcodes/documentation/addresses).

### Get nearby postcode for a given geolocation [(docs)](https://ideal-postcodes.co.uk/documentation/postcodes#lonlat)

Retrieve the nearest postcodes for a given geolocation. Free to use.

```ruby
IdealPostcodes::Postcode.find_by_location longitude: lon, latitude: lat [limit: lim, radius: rad]
```

**Arguments**

- `location` (Hash). Requires a `longitude` (number) and `latitude` (number) attribute. `Limit` (number) and `radius` (number) are optional and represent the maxmimum number of results and search radius (in metres) respectively.

**Returns**

An array of hashes which represent the nearest postcodes to the specified location. Ordered by distance from location.

**Example**

```ruby
# An example of how to use this method
```

**Notes**

Data source: Ordance Survey. Free to use.

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