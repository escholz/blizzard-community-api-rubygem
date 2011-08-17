# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "battle.net"
  gem.homepage = "http://github.com/escholz/battle.net"
  gem.license = "MIT"
  gem.summary = %Q{World of Warcraft API Client Library}
  gem.description = %Q{Ruby Implementation of Blizzard's World of Warcraft API}
  gem.email = "eric.scholz@gmail.com"
  gem.authors = ["Eric Scholz"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
RSpec::Core::RakeTask.new(:rcov) do |rcov|
  rcov.rcov = true
  rcov.rcov_opts = ['--exclude', 'spec']
  rcov.rspec_opts = ["-c"]
end

task :default => :spec

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "battle.net #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
