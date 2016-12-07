default['varnish']['packages'] = %w(varnish)

# NOTE: see http://repo.varnish-cache.org/source/ for versions
default['varnish']['version'] = '4.1.3'

default['varnish']['thread_pool_min'] = 5
default['varnish']['thread_pool_max'] = 20

# default address and port to bind to
default['varnish']['frontend']['ip']   = '127.0.0.1'
default['varnish']['frontend']['port'] = '80'

# set this to point to your content server
default['varnish']['backend']['ip']   = '127.0.0.1'
default['varnish']['backend']['port'] = '8080'

default['varnish']['admin']['ip']   = '127.0.0.1'
default['varnish']['admin']['port'] = '6082'

default['varnish']['cache']['file'] = '/var/lib/varnish/varnish_storage.bin'
default['varnish']['cache']['size'] = '200M'

case node['platform_family']
when 'debian'
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
when 'rhel'
    default['varnish']['dependencies'] = %w(
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
