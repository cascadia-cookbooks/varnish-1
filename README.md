# varnish Cookbook
This cookbook will install and configure Varnish, a high-performance HTTP accelerator.

### Platforms
* ubuntu/xenial64
* ubuntu/trusty64
* centos/7
* centos/6
* debian/jessie64
* debian/wheezy64

### Chef
- Chef '>= 12.5'

## Attributes
* `default['varnish']['frontend']['ip'] = '127.0.0.1'` The interface Varnish will bind to.  This will usually be your public IP address.
* `default['varnish']['frontend']['port'] = '80'` The port Varnish will listen on.
* `default['varnish']['backend']['ip'] = '127.0.0.1'` The IP address of your content server.
* `default['varnish']['backend']['port'] = '8080'` The port of your content server.
* `default['varnish']['admin']['ip'] = '127.0.0.1'` The interface Varnish admin will bind to.
* `default['varnish']['admin']['port'] = '6082'` The port Varnish admin will listen on.
* `default['varnish']['version'] = '4.1.3'` Changes the version to install. You shouldn't need to change this.
* `default['varnish']['cache']['file'] = '...'` The file Varnish will save data to. You shouldn't need to change this.
* `default['varnish']['cache']['size'] = '200M'` The size limit of the Varnish cache file. Increase to save more data. Use a string in bytes, optionally using k / M / G / T suffix.
* `default['varnish']['purge'] = { '192.168.0.0' => '/24' }` A list of addresses to allow purging Varnish cache. This should be an array of keys. If a network doesnt have a netmask, leave it empty.

## Usage
Including the `cop_varnish` cookbook in the run_list ensures that varnish
service will be installed.

```ruby
name 'varnish'
description 'installs and configures varnish'

override_attributes(
    ...
    'varnish' => {
        'frontend' => {
            'ip'   => '192.168.0.666',
            'port' => 80,
        },
        'backend' => {
            'ip'   => '127.0.0.1',
            'port' => 666
        },
        'cache' => {
            'size' => '2G'
        },
        'purge' => {
            'localhost'   => '',
            '192.168.0.0' => '/16',
        }
    },
    ...
)

run_list(
    'recipe[cop_varnish::default]'
)
```

## Testing
* http://kitchen.ci
* http://serverspec.org

Testing is handled with ServerSpec, via Test Kitchen, which uses Vagrant to spin up VMs.

ServerSpec and Test Kitchen are bundled in the ChefDK package.

### Dependencies
```bash
$ brew cask install chefdk
```

### Running
Get a listing of your instances with:

```bash
$ kitchen list
```

Run Chef on an instance, in this case ubuntu-1404, with:

```bash
$ kitchen converge ubuntu-1404
```

Destroy all instances with:

```bash
$ kitchen destroy
```

Run through and test all the instances in serial by running:

```bash
$ kitchen test
```

## Notes
* The `Berksfile.lock` file has been purposely omitted, as we don't care about upstream dependencies.
