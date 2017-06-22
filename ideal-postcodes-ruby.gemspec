$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'idealpostcodes/version'

spec = Gem::Specification.new do |s|
  s.name = 'ideal_postcodes'
  s.version = IdealPostcodes::VERSION
  s.summary = 'Wrapper for the Ideal-Postcodes.co.uk API'
  s.description = 'Ideal Postcodes is a simple postcode lookup API for UK addresses. See https://ideal-postcodes.co.uk'
  s.authors = ['Ideal Postcodes']
  s.email = ['support@ideal-postcodes.co.uk']
  s.homepage = 'https://ideal-postcodes.co.uk/'
  s.licenses = ['MIT']

  s.add_dependency('rest-client', '~> 1.8')

  s.add_development_dependency 'rake', '~> 10.1.0'
  s.add_development_dependency 'vcr', '~> 2.9.3'
  s.add_development_dependency 'rspec', '~> 3.1.0'
  s.add_development_dependency 'webmock', '~> 1.20.4'

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
end
