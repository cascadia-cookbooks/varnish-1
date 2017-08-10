name 'cop_varnish'
maintainer 'Copious Inc.'
maintainer_email 'engineering@copiousinc.com'
license 'MIT'
description 'Installs and configures varnish.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.1.0'

source_url 'https://github.com/copious-cookbooks/varnish'
issues_url 'https://github.com/copious-cookbooks/varnish/issues'

supports 'ubuntu', '>= 14.04'
supports 'debian', '>= 8'
supports 'rhel', '>= 7'
supports 'centos', '>= 7'

depends 'cop_base'
