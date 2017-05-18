#
# Cookbook Name:: cop_varnish
# Recipe:: install
# Author:: Copious Inc. <engineering@copiousinc.com>
#

cache    = Chef::Config[:file_cache_path]
varnish  = "varnish-#{node['varnish']['version']}"
tarball  = "#{varnish}.tar.gz"
download = "https://repo.varnish-cache.org/source/#{tarball}"

remote_file 'download varnish' do
    path   "#{cache}/#{tarball}"
    source download
    owner  'root'
    group  'root'
    mode   0644
    action :create
end

execute 'unpack varnish' do
    cwd     cache
    command "gunzip #{tarball} && tar -xf #{varnish}.tar"
    not_if  "test -d #{varnish}"
end

execute 'make precompile varnish' do
    cwd         "#{cache}/#{varnish}"
    environment ({'PATH' => '/sbin:/bin:/usr/sbin:/usr/bin'})
    command     'sh autogen.sh; sh configure; make'
    not_if      'which varnishd'
end

execute 'install varnish' do
    cwd         "#{cache}/#{varnish}"
    environment ({'PATH' => '/sbin:/bin:/usr/sbin:/usr/bin'})
    command     'make install'
    not_if      'which varnishd'
end

directories = %w(
    /etc/varnish
    /var/log/varnish
    /var/lib/varnish
)

directories.each do |d|
    directory d do
        user   'root'
        group  'root'
        mode   0755
        action :create
    end
end
