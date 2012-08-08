# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name = %q{normalizations}
  s.version = Normalizations::VERSION
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kyle Ginavan"]
  s.date = %q{2010-05-18}
  s.homepage = "https://github.com/kylejginavan/normalizations"
  s.summary =  %q{gem for Rails 3 to normalize data prior to save}
  s.description = %q{normalize data prior to save}
  s.email = %q{kylejginavan@gmail.com}
  s.rubyforge_project = "normalizations"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency "thoughtbot-shoulda"
  s.add_development_dependency "rspec"
end

