Gem::Specification.new do |s|
  s.name        = 'netapp'
  s.version     = '0.0.1'
  s.date        = '2013-07-16'
  s.summary     = "Netapp query Tool"
  s.description = "Gem to query netapp information"
  s.authors     = ["Jim Rosser"]
  s.email       = "jarosser06@gmail.com"
  s.files       = %w(lib/netapp.rb lib/netapp/monkey_patches/integer.rb lib/netapp/query.rb lib/netapp/volume.rb)
  s.homepage    = 'https://github.com/jarosser06'

  s.add_dependency 'snmp'
end
