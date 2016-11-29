default['varnish']['packages'] = %w(varnish)
default['varnish']['version'] = '4.1.3'

# default address and port to bind to
default['varnish']['ip']   = '127.0.0.1'
default['varnish']['port'] = '80'

# set this to point to your content server
default['varnish']['backend']['ip']   = '127.0.0.1'
default['varnish']['backend']['port'] = '8080'

default['varnish']['admin']['ip']   = '127.0.0.1'
default['varnish']['admin']['port'] = '6082'

case node['platform']
when 'ubuntu', 'debian'
    default['varnish']['dependencies'] = %w(
        automake
        autotools-dev
        libedit-dev
        libjemalloc-dev
        libncurses-dev
        libpcre3-dev
        libtool
        pkg-config
        python-docutils
        python-sphinx
        graphviz
    )
when 'centos', 'rhel'
    default['varnish']['dependencies'] = %w(
        epel-release
        autoconf
        automake
        jemalloc-devel
        libedit-devel
        libtool
        ncurses-devel
        pcre-devel
        pkgconfig
        python-docutils
        python-sphinx
        graphviz
    )
end
