require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |s|
  s.rspec_opts = ["--fail-fast", "--color"]
end

require 'yard'
YARD::Rake::YardocTask.new(:yard)

task :default => :spec