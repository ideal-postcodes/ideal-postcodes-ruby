# Ideal-Postcodes.co.uk API Wrapper

Get a full list of addresses for any given UK postcode using the Ideal-Postcodes.co.uk API. We use the most accurate addressing database in the UK, Royal Mail's Postcode Address File.

This gem is a simple wrapper for our API.

## Getting Started

_Install it_

```bash
gem install ideal_postcodes
```

_Get an API Key_

Get a key [Ideal-Postcodes.co.uk](https://ideal-postcodes.co.uk). Try out the service with the test postcode 'ID1 1QD'

_Use it_

Start performing address lookups with a few lines of code

```ruby
require 'ideal_postcodes'

IdealPostcodes.api_key = "your_key_goes_here"

postcode = IdealPostcodes::Postcode.lookup "ID1 1QD"

#	postcode.addresses =>
#
# [
#		{
#			:postcode=>"ID1 1QD",
# 		:post_town=>"LONDON",
# 		:line_1=>"Kingsley Hall",
# 		:line_2=>"Powis Road",
# 		:line_3=>""
#		}, 
#		... and so on
```

## Registering

PAF is licensed from the Royal Mail and is, unfortunately, not free to use. Ideal Postcodes aims to be simple to use and fairly priced to use for web and mobile developers.

We charge _2p per [external](https://ideal-postcodes.co.uk/termsandconditions#external) lookup_.

Please read our terms and conditions.

## Documentation

More documentation can be found [here](https://ideal-postcodes.co.uk/documentation/ruby-wrapper)