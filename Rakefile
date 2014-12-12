begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
rescue LoadError
  # no rspec available
end

task :eject_tapes do
	`rm spec/vcr_cassettes/*.yml`
end