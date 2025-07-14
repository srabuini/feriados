Gem::Specification.new do |s|
  s.name          = 'feriados'
  s.version       = '4.5.0'  # Minor version bump for new features
  s.authors       = ['Sebastian Rabuini']
  s.email         = ['srabuini@gmail.com']
  s.summary       = 'Holidays calendars with advanced querying capabilities'
  s.description   = 'Make holidays calendars from rules. Supports querying holidays by year, date ranges, and finding next holidays.'
  s.license       = 'MIT'
  s.homepage      = 'https://github.com/srabuini/feriados'
  s.files         = Dir['lib/**/*.rb']
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.3'

  s.metadata = {
    'bug_tracker_uri' => 'https://github.com/srabuini/feriados/issues',
    'changelog_uri' => 'https://github.com/srabuini/feriados/blob/master/CHANGELOG.md',
    'source_code_uri' => 'https://github.com/srabuini/feriados'
  }

  s.add_development_dependency 'minitest', '~> 5.14'
  s.add_development_dependency 'simplecov', '~> 0.17'
  s.add_development_dependency 'rake', '~> 13.0'
end
