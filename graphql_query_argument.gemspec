Gem::Specification.new do |s|
  s.name        = 'graphql_query_argument'
  s.version     = '0.0.2'
  s.summary     = 'Graphql query argument'
  s.description = 'For Graphql custom query argument module'
  s.authors     = ['Shang']
  s.email       = 'shangweilin7@gmail.com'
  s.files       = `git ls-files`.split($/)
  s.homepage    = 'https://github.com/shangweilin7/graphql_query_argument'
  s.license     = 'MIT'

  s.add_dependency 'graphql', '> 2.0'

  s.add_development_dependency 'rspec', '> 3.12.2'
end
