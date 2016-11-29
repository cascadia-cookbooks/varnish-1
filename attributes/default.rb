default['varnish']['packages'] = %w(varnish)

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
    default['varnish']['version'] = '4.1.3-*'
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
    default['varnish']['version'] = '4.0.3-*'
end
