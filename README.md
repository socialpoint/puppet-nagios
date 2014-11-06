#Puppet Nagios

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What puppet-nagios affects](#what-puppet-nagios-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppet-nagios](#beginning-with-puppet-nagios)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)

##Overview

The Nagios module allows you to configure a Nagios server and setup monitorization basics to all your monitored servers.

##Module Description

Nagios is the de facto monitorization standard but its configuration can be complex to setup. This module aims to easily configure a Nagios server using puppet and setup the basics in all your monitored servers.

With this module it's possible to configure every aspect of Nagios (resources, nrpe, service checks) and setup exported resources in your monitored hosts.

##Setup

###What puppet-nagios affects

* Nagios configuration files and directories.
* Nrpe configuration files and directories

###Setup Requirements

If you want to configure service and host checks in each one of your monitored hosts, you need exported resources activated in your puppet master either with puppetdb or the deprecated activerecord.

###Beginning with puppet-nagios

####Nagios server

To install Nagios server with the default parameters:

```puppet
class { 'nagios': }
```

The defaults are based on the default Nagios installation but they can be overwritten:

```puppet
class { 'nagios':
  default_contactgroups => {
    'sysadmins'     => {
      'alias'   => 'System Administrators',
      'members' => 'bob',
    }
  }
}
```

By default puppet-nagios does not configure Apache. You can configure it yourself or use the class ``nagios::apache`` to do it for you:

```puppet
class { '::nagios::apache': }
```

Nagios server is not complete without all the required Nagios plugins installed. To do so:

```puppet
class { 'nagios::plugins': }
```

####Monitored hosts

On the monitored hosts it's necessary to install nrpe so they can be monitored remotelly. Nrpe will also require the installation of the Nagios plugins

```puppet
class { 'nagios::nrpe': }
class { 'nagios::plugins': }
```

##Usage

Once the basics have been configured, it's time to start adding checks in the monitored hosts. This module provides some defined resources to make it easier to add new checks:

```puppet
nagios::resource::host { $::fqdn:
  exported  => true,
  host_name => $::fqdn,
  alias     => $::hostname,
  address   => $::ipaddress,
  use       => 'generic-host',
  notes     => "<table><tr><th>OS</th><td>${::operatingsystem} ${::operatingsystemrelease}</td></tr><tr><th>CPU</th><td>${::physicalprocessorcount} x ${::processor0}</td></tr><tr><th>Architecture</th><td>${::architecture}</td></tr><tr><th>Kernel</th><td>${::kernelrelease}</td></tr><tr><th>Memory</th><td>${::memorysize}</td></tr><tr><th>Swap</th><td>${::swapsize}</td></tr></table>",
}

nagios::resource::service { "${::fqdn}-load":
  host_name             => $::fqdn,
  use                   => 'generic-service',
  check_command         => 'check_load -w 10,5,3 -c 15,10,5',
  service_description   => 'load',
  exported              => true,
  nrpe                  => true,
}
```

##Reference

###List of classes

* nagios
* nagios::server
* nagios::plugins
* nagios::nrpe
* nagios::apache
* nagios::params

###List of defined resources

* nagios::resource
* nagios::resource::host
* nagios::resource::service
* nagios::resource::contactgroup
* nagios::resource::timeperiod
* nagios::resource::contact
* nagios::resource_hash::command
* nagios::resource_hash::contactgroup
* nagios::resource_hash::contact
* nagios::resource_hash::hostdependency
* nagios::resource_hash::hostescalation
* nagios::resource_hash::hostextinfo
* nagios::resource_hash::hostgroup
* nagios::resource_hash::host
* nagios::resource_hash::servicedependency
* nagios::resource_hash::serviceescalation
* nagios::resource_hash::serviceextinfo
* nagios::resource_hash::servicegroup
* nagios::resource_hash::service
* nagios::resource_hash::timeperiod

##Limitations

Although a big effort has been done to make the module easily exported to other OS, it currently only supports Ubuntu 14.04.

##Development

We know there is still much room for improvement so feel free to use Github's pull request system to send us your changes to the module.

We'd love to see support for other operating systems other than Ubuntu
