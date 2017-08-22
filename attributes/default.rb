default['varnish']['packages'] = %w(varnish)

# NOTE: See https://packagecloud.io/varnishcache for version numbers
default['varnish']['version'] = '5'

default['varnish']['binary_path'] = '/usr/local/sbin/varnishd'

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

default['varnish']['cache']['storage_backend'] = 'file'
default['varnish']['cache']['file']            = '/var/lib/varnish/varnish_storage.bin'
default['varnish']['cache']['size']            = '200M'

# Set this cookie to bypass Varnish cache
default['varnish']['bypass_cookie'] = 'no_cache'

default['varnish']['cache_purge_pattern'] = '"req.http.host ~ .*"'
default['varnish']['purge'] = {
    "localhost" => '',
}

default['varnish']['bypass_urls'] = {}

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
