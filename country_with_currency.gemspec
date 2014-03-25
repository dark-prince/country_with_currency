# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'country_with_currency/version'

Gem::Specification.new do |spec|
  spec.platform                   = Gem::Platform::RUBY
  spec.name                       = "country_with_currency"
  spec.version                    = CountryWithCurrency::VERSION
  spec.summary                    = %q{Provides a helper to get a country list alongwith ISO code, currency code and currency symbol by following ISO 3166 country list.}
  spec.description                = %q{Provides a helper to get a country list alongwith ISO code, currency code and currency symbol by following ISO 3166 country list.}
  spec.license                    = "MIT"
  spec.authors                    = ["Diganta Mandal"]
  spec.email                      = ["urs.diganta@gmail.com"]
  spec.homepage                   = "https://github.com/dark-prince/country_with_currency"
  spec.required_ruby_version      = ">= 1.9.3"
  spec.required_rubygems_version  = ">= 1.8.11"
  spec.files                      = `git ls-files`.split($/)
  spec.executables                = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files                 = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths              = ["lib"]
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "yard", "~> 0.8"
  spec.add_development_dependency "kramdown", "~> 1.1"
end