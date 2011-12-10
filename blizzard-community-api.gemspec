require "rake"

Gem::Specification.new do |s|
  s.name = %q{blizzard-community-api}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eric Scholz"]
  s.date = %q{2011-12-10}
  s.description = %q{A ruby implementation of standard and authorized (OpenAuth) calls to the Blizzard Community API}
  s.email = %q{eric.scholz@gmail.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = FileList['lib/**/*.rb', '[A-Z]*', 'spec/**/*'].to_a
  s.has_rdoc = true
  s.homepage = %q{http://github.com/escholz/blizzard-community-api-rubygem}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Blizzard Community API RubyGem", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{blizzard-community-api}
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Blizzard Community API RubyGem}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end