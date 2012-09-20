Gem::Specification.new do |s|
  s.name        = 'acts_as_reviewable'
  s.version     = '0.0.0'
  s.date        =  '2012-09-20'
  s.summary = 'Make any active record model reviewable'
  s.description = 'Make any active record model reviewable'
  s.authors     = ['Ed Shadi']
  s.email       = ['edshadi@gmail.com']
  s.homepage    = 'https://rubygems.org/gems/acts_as_reviewable'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency     'rails', '~> 3.0'
  s.add_development_dependency 'rspec', '~> 2.6'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'

end
