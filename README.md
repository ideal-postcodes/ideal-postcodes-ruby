# Ideal Postcodes (Ruby Wrapper) [![Build Status](https://travis-ci.org/ideal-postcodes/ideal-postcodes-ruby.png)](https://travis-ci.org/ideal-postcodes/ideal-postcodes-ruby)

Ruby wrapper for Ideal-Postcodes.co.uk UK postcode and addressing API.

## Getting Started

__Install it__

```bash
gem install ideal_postcodes
```

Alternatively for Rails, include this in your gemfile and bundle install

```ruby
gem 'ideal_postcodes'
```

__Get an API Key__

Get a key at [Ideal-Postcodes.co.uk](https://ideal-postcodes.co.uk). Try out the service with the test postcode 'ID1 1QD'

__Configuration__

In order to perform lookups, you'll need to configure the gem by passing in your api key by doing the following:

```ruby
require 'ideal_postcodes'

IdealPostcodes.api_key = "your_key_goes_here"
```

**For Rails**, the simplest way to do this is create a file in your initializers folder and drop in your key with this line of code:

```ruby
IdealPostcodes.api_key = "<your key goes here>"
```

__Usage__

IdealPostcodes::Postcode.lookup will return a Postcode object containing the complete list of addresses if the postcode exists.

```ruby
postcode = IdealPostcodes::Postcode.lookup "ID1 1QD"

if postcode.empty? 
	puts "Your postcode doesn't have a match"
else
	postcode.addresses
end

# postcode.addresses =>
#
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

__Exceptions__

The wrapper will raise an exception for anything other than a 200 response or an empty 404 response (which means no addresses at postcode).

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

## Registering

PAF is licensed from the Royal Mail and is, unfortunately, not free to use. It requires an API Key which can be generated with an account.

## Documentation

More documentation can be found [here](https://ideal-postcodes.co.uk/documentation/ruby-wrapper)

## Testing

```
bundle exec rake test
```

## License
MIT