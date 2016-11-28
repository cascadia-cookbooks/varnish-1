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
