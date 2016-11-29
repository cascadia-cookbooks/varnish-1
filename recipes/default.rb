#
# Cookbook Name:: cop_varnish
# Recipe:: default
# Author:: Copious Inc. <engineering@copiousinc.com>
#
# The MIT License (MIT)
#
# Copyright (c) 2016 Copious Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

case node['platform']
when 'ubuntu', 'debian'
    # TODO: remove apt dependency
    apt_repository 'varnish-cache' do
        uri          'https://repo.varnish-cache.org/ubuntu/'
        distribution node['lsb']['codename']
        components   ['varnish-4.1']
        key          'https://repo.varnish-cache.org/GPG-key.txt'
    end

    include_recipe 'apt::default'
when 'centos', 'rhel'
    package 'epel-release' do
        action :install
    end
end

package 'varnish' do
    action  :upgrade
    version node['varnish']['version']
end
