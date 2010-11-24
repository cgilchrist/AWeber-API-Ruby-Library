require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |s|
  s.rspec_opts = ["--color"]
end

require 'yard'
YARD::Rake::YardocTask.new(:yard)

task :default => :spec