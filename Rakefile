require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "aweber"
    gem.summary = %Q{TODO: AWeber API gem client.}
    gem.description = %Q{TODO: AWeber <http://labs.aweber.com> API client.}
    gem.email = "matten@aweber.com"
    gem.homepage = "http://github.com/aweber/aweber"
    gem.authors = ["Matte Noble"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
RSpec::Core::RakeTask.new(:rcov) do |s|
  s.rcov = true
  s.rcov_opts = %w{--exclude gems\/,spec\/,features\/}
end

task :spec    => :check_dependencies
task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "aweber #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
