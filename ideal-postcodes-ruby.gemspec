$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'idealpostcodes/version'

spec = Gem::Specification.new do |s|
  s.name = 'ideal_postcodes'
  s.version = IdealPostcodes::VERSION
  s.summary = 'Wrapper for the Ideal-Postcodes.co.uk API'
  s.description = 'Ideal Postcodes is a simple postcode lookup API for UK addresses.  See https://ideal-postcodes.co.uk'
  s.authors = ['Chris Blanchard']
  s.email = ['cablanchard@gmail.com']
  s.homepage = 'https://ideal-postcodes.co.uk/documentation'

  s.add_dependency('rest-client', '~> 1.6')
  s.add_dependency('multi_json', '~> 1.7.9')

  s.add_development_dependency('mocha', '~> 0.14.0')
  s.add_development_dependency('test-unit')
  s.add_development_dependency('shoulda', '~> 3.5.0')
  s.add_development_dependency('rake')

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ['lib']
end
