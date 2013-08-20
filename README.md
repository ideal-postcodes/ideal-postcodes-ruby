# Ideal-Postcodes.co.uk Ruby API Wrapper

Add UK address lookups with our simple gem that wraps around our API. Ideal Postcodes uses Royal Mail's addressing database, the Postcode Address File (PAF).

PAF is licensed from the Royal Mail and is, unfortunately, not free to use. Ideal Postcodes aims to be simple to use and fairly priced to use for web and mobile developers.

## Getting Started

*Install it*

```bash
gem install ideal-postcodes
```

*Load it*

```ruby
require 'ideal-postcodes'

IdealPostcodes.api_key = "ak_Iddqd8Idkfa7Idchoppers8"
```

*Use it*

```ruby
postcode = IdealPostcodes::Postcode.lookup "ID1 1QD"

postcode.addresses

# => [
#			{
#				:postcode=>"ID1 1QD",
#   		:post_town=>"LONDON",
#   		:line_1=>"Kingsley Hall",
#   		:line_2=>"Powis Road",
#   		:line_3=>""
#			},
#  		{
#				:postcode=>"ID1 1QD",
#   		:post_town=>"LONDON",
#   		:line_1=>"36 Craven Street",
#   		:line_2=>"Charing Cross",
#   		:line_3=>""
#			}, ...
 
```

## Documentation

More documentation can be found [here](https://ideal-postcodes.co.uk/documentation/ruby-wrapper)