# -*- encoding: utf-8 -*-
# frozen_string_literal: true

lib = File.expand_path("../lib/", __FILE__)
$:.unshift lib unless $:.include?(lib)

require "has_normalized_attributes/version"

Gem::Specification.new do |s|
  s.name          = "has_normalized_attributes"
  s.version       = HasNormalizedAttributes::VERSION
  s.authors       = ["Kyle Ginavan"]
  s.email         = ["kylejginavan@gmail.com"]
  s.date          = "2010-05-18"
  s.summary       = "Normalize user-provided data before save"
  s.description   = <<~DESC
    has_normalized_attributes is a Ruby on Rails gem that lets you normalize user data
    for an improved user experience. It takes messy user input and normalizes it into
    a clean, standard format.
  DESC
  s.homepage = "https://github.com/kylejginavan/has_normalized_attributes"

  s.required_ruby_version = ">= 3.0.0", "< 4.0.0"
  s.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match?(%r{\A(?:test|spec|features)/}) ||
        f.end_with?(".gem")
    end
  end
  s.require_paths    = ["lib"]
  s.extra_rdoc_files = [ "README.rdoc" ]
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables      = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }


  s.add_development_dependency "activerecord",                   "~> 7.2"
  s.add_development_dependency "byebug",                         "~> 12.0"
  s.add_development_dependency "database_cleaner",               "~> 2.1"
  s.add_development_dependency "rspec",                          "~> 3.13"
  s.add_development_dependency "rspec_junit_formatter",          "~> 0.6"
  s.add_development_dependency "rubocop",                        "~> 1.81"      # code quality check for sonarqube
  s.add_development_dependency "rubocop-performance",            "~> 1.26"
  s.add_development_dependency "rubocop-rails",                  "~> 2.34"
  s.add_development_dependency "sqlite3",                        "~> 2.9"
end
