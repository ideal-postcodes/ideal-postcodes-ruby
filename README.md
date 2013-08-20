# Ideal-Postcodes.co.uk API Wrapper

Get a full list of addresses for any given UK postcode using the Ideal-Postcodes.co.uk API. We use the most accurate addressing database in the UK, Royal Mail's Postcode Address File.

## Getting Started

__Install it__

```bash
gem install ideal_postcodes
```

__Get an API Key__

Get a key at [Ideal-Postcodes.co.uk](https://ideal-postcodes.co.uk). Try out the service with the test postcode 'ID1 1QD'

__Use it__

Do address lookups with a few lines of Ruby

```ruby
require 'ideal_postcodes'

IdealPostcodes.api_key = "your_key_goes_here"

postcode = IdealPostcodes::Postcode.lookup "ID1 1QD"

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