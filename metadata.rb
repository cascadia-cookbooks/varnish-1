name 'cop_varnish'
maintainer 'Copious Inc.'
maintainer_email 'engineering@copiousinc.com'
license 'MIT'
description 'Installs and configures varnish.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.0'

source_url 'https://github.com/copious-cookbooks/varnish'
issues_url 'https://github.com/copious-cookbooks/varnish/issues'

supports 'ubuntu'
supports 'rhel'
supports 'centos'
supports 'fedora'

depends 'apt'
