# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'xmlparser'
  s.authors = ['Valentin Andreev']
  s.version = '0.1.0'
  s.date = '2019-04-21'
  s.summary = 'xml parser'
  s.files = [
    'lib/xmlparser.rb'
  ]
  s.require_paths = ['lib']

  s.add_runtime_dependency 'upsert'
  s.add_runtime_dependency 'libxml-ruby'

  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
end
