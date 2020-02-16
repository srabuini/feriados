Gem::Specification.new do |s|
  s.name          = 'feriados'
  s.version       = '4.2.2'
  s.authors       = ['Sebastian Rabuini']
  s.email         = ['srabuini@gmail.com']
  s.summary       = 'Holidays calendars'
  s.description   = 'Make holidays calendars from rules'
  s.license       = 'MIT'
  s.homepage      = 'https://github.com/srabuini/feriados'
  s.files         = Dir['lib/**/*.rb']
  s.test_files    = Dir['test/**/*.rb']
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.3'
  s.add_development_dependency 'minitest', '~> 5.14'
  s.add_development_dependency 'simplecov', '~> 0.17'
end
