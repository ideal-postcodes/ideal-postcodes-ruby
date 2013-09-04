# Ideal-Postcodes.co.uk API Wrapper

Get a full list of addresses for any given UK postcode using the Ideal-Postcodes.co.uk API. We use the most accurate addressing database in the UK, Royal Mail's Postcode Address File.

## Getting Started

__Install it__

```bash
gem install ideal_postcodes
```

Alternatively for rails, include this in your gemfile and bundle install

```ruby
gem 'ideal_postcodes'
```

__Get an API Key__

Get a key at [Ideal-Postcodes.co.uk](https://ideal-postcodes.co.uk). Try out the service with the test postcode 'ID1 1QD'

__Configuration__

In order to perform lookups, you'll need to configure the gem by passing in your api key.

**For Rails**, the best way to do this is create a file in your initializers folder and drop in your key with this line of code:

```ruby
IdealPostcodes.api_key = "<your key goes here>"
```

**For General Ruby Scripting**, you'll can do the following:

```ruby
require 'ideal_postcodes'

IdealPostcodes.api_key = "your_key_goes_here"
```

__Usage__

Do address lookups with a few lines of Ruby. Simply call #lookup on the IdealPostcodes::Postcode class. This will return a Postcode object containing the complete list of addresses if the postcode exists.

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
#   :postcode=>"ID1 1QD",
#   :post_town=>"LONDON",
#   :line_1=>"Kingsley Hall",
#   :line_2=>"Powis Road",
#   :line_3=>""
#  }, ... and so on
```

## Registering

PAF is licensed from the Royal Mail and is, unfortunately, not free to use. Ideal Postcodes aims to be simple to use and fairly priced to use for web and mobile developers.

We charge _2p_ per [external](https://ideal-postcodes.co.uk/termsandconditions#external) lookup.

## Documentation

More documentation can be found [here](https://ideal-postcodes.co.uk/documentation/ruby-wrapper)

## License
MIT