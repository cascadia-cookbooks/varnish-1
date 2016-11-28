# varnish Cookbook
This cookbook will install and configure varnish.

### Platforms
- Ubuntu, Debian
- CentOS, RHEL

### Chef
- Chef '>= 12.5'

## Attributes
You can set custom version via the `version` attribute.

`default['varnish']['version'] = 'version'`

## Usage
Including the `cop_varnish` cookbook in the run_list ensures that varnish
service will be installed.

```ruby
name 'varnish'
description 'this will install varnish'

override_attributes()

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

Files installed on CentOS/RHEL
```
[vagrant@default-centos-72 ~]$ rpm -ql varnish | egrep -v 'bin|share'
/etc/logrotate.d/varnish
/etc/varnish
/etc/varnish/default.vcl
/etc/varnish/varnish.params
/usr/lib/systemd/system/varnish.service
/usr/lib/systemd/system/varnishlog.service
/usr/lib/systemd/system/varnishncsa.service
/var/lib/varnish
/var/log/varnish
```

Files installed on Ubuntu/Debian
```
vagrant@default-ubuntu-1404:~$ dpkg-query -L varnish | egrep -v 'share|bin'
/.
/etc
/etc/init.d
/etc/init.d/varnishlog
/etc/init.d/varnishncsa
/etc/init.d/varnish
/etc/logrotate.d
/etc/logrotate.d/varnish
/etc/varnish
/etc/varnish/default.vcl
/etc/default
/etc/default/varnishlog
/etc/default/varnishncsa
/etc/default/varnish
/lib
/lib/systemd
/lib/systemd/system
/lib/systemd/system/varnish.service
/lib/systemd/system/varnishncsa.service
/lib/systemd/system/varnishlog.service
/var
/var/log
/var/log/varnish
/usr
/usr/lib
/usr/lib/varnish
/usr/lib/varnish/libvarnishcompat.so
/usr/lib/varnish/libvarnish.so
/usr/lib/varnish/libvgz.so
/usr/lib/varnish/vmods
/usr/lib/varnish/vmods/libvmod_directors.so
/usr/lib/varnish/vmods/libvmod_std.so
/usr/lib/varnish/libvcc.so
```
