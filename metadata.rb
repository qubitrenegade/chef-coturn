name              'coturn'
maintainer        'QubitRenegade'
maintainer_email  'qubitrenegade@protonmail.com'
license           'MIT'
description       'Provides custom resource for installing and configuring `coturn` TURN server'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.1.0'
chef_version      '>= 13.0'

issues_url 'https://github.com/qubitrenegade/chef-coturn/issues'
source_url 'https://github.com/qubitrenegade/chef-coturn'

%w(ubuntu).each do |platform|
  supports platform
end
