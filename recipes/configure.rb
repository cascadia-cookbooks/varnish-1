#
# Cookbook Name:: cop_varnish
# Recipe:: configure
# Author:: Copious Inc. <engineering@copiousinc.com>
#

require 'securerandom'

secret = node['varnish']['secret'] || SecureRandom.uuid

file '/etc/varnish/secret' do
    user    'root'
    group   'root'
    mode    0600
    content secret
    action  :create_if_missing
end

templates = {
    '/etc/varnish/varnish.params' => 'varnish.params.erb',
    '/etc/varnish/default.vcl'    => 'default.vcl.erb',
}

templates.each do |f,t|
    template f do
        cookbook 'cop_varnish'
        source   t
        group    'root'
        owner    'root'
        mode     0644
        backup   5
        action   :create
        notifies :restart, 'service[varnish]', :delayed
    end
end

# Select varnish service configuration template by platform
template_source = value_for_platform(
    %w(centos redhat) => {
        'default' => 'varnish.service.systemd.erb'
    },
    'debian' => {
        'default' => 'varnish.service.systemd.erb'
    },
    'ubuntu' => {
        '14.04' => 'varnish.service.legacy.erb',
        'default' => 'varnish.service.systemd.erb'
    }
)

# Select varnish service configuration destination by platform
template_destination = value_for_platform(
    %w(centos redhat) => {
        'default' => '/etc/sysconfig/varnish'
    },
    'debian' => {
        'default' => '/etc/systemd/system/varnish.service.d/customexec.conf'
    },
    'ubuntu' => {
        '14.04' => '/etc/default/varnish',
        'default' => '/etc/systemd/system/varnish.service.d/customexec.conf'
    }
)

# Create parent directory for template
if node['platform_family'] == 'debian' && node['platform_version'] != '14.04'
    directory '/etc/systemd/system/varnish.service.d/' do
        owner 'root'
        group 'root'
        mode  0755
    end
end

# Create template for varnish sevice configuration
template template_destination do
    cookbook 'cop_varnish'
    source   template_source
    group    'root'
    owner    'root'
    mode     0644
    action   :create
    notifies :run, 'execute[reload systemctl]', :immediately
    notifies :restart, 'service[varnish]', :delayed
end

# Reload systemctl daemon
execute 'reload systemctl' do
    command 'systemctl daemon-reload'
    action  :nothing
    not_if node['platform_version'] == '14.04'
end

cookbook_file '/etc/logrotate.d/varnish' do
    cookbook 'cop_varnish'
    source   'logrotate'
    owner    'root'
    group    'root'
    mode     0755
    action   :create
end

service 'varnish' do
    action [:enable, :start]
end
