default['varnish']['packages'] = %w(varnish)

case node['platform']
when 'ubuntu', 'debian'
    default['varnish']['version'] = '4.1.3-*'
when 'centos', 'rhel'
    default['varnish']['version'] = '4.0.3-*'
end
