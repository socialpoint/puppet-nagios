class nagios::apache (
  $vhost_name = 'nagios',
  $servername = undef,
  $serveraliases = undef,
  $port = '80',
  $priority = undef,
  $docroot = $nagios::params::nagios_htdocs_dir,
  $custom_fragment = undef,
  $html_dir = $nagios::params::html_dir,
  $apache_user = $nagios::params::apache_user,
  $apache_service = $nagios::params::apache_service,
  $htpasswd_file = $nagios::params::htpasswd_file,
  $nagios_stylesheets_dir = $nagios::params::nagios_stylesheets_dir,
  $nagios_htdocs_dir = $nagios::params::nagios_htdocs_dir,
  $nagios_cgi_dir = $nagios::params::nagios_cgi_dir,
  $only_vhost = false,
) inherits nagios::params {

  $aliases = [
    {
      alias => '/stylesheets',
      path  => $nagios_stylesheets_dir,
    },
    {
      alias => "${html_dir}/stylesheets",
      path  => $nagios_stylesheets_dir,
    },
    {
      alias => "/nagios/stylesheets",
      path  => $nagios_stylesheets_dir,
    },
    {
      alias => '/nagios',
      path  => $nagios_htdocs_dir,
    },
    {
      alias => $html_dir,
      path  => $nagios_htdocs_dir,
    },
  ]

  $scriptaliases = [
    {
      alias => "/cgi-bin${html_dir}",
      path  => $nagios_cgi_dir,
    },
    {
      alias => "${html_dir}/cgi-bin",
      path  => $nagios_cgi_dir,
    }
  ]

  $directories = [
    {
      path           => "(${nagios_htdocs_dir}|${nagios_cgi_dir}|${nagios_stylesheets_dir})",
      provider       => 'directorymatch',
      options        => 'FollowSymLinks',
      directoryindex => 'index.php index.html',
      allowoverride  => 'AuthConfig',
      order          => 'Allow,Deny',
      allow          => 'From All',
      auth_name      => 'Nagios Access',
      auth_type      => 'Basic',
      auth_user_file => $htpasswd_file,
      auth_require   => 'valid-user',
    },
    {
      path    => $nagios_htdocs_dir,
      options => '+ExecCGI',
    }
  ]

  if !$only_vhost {
    class { '::apache':
      mpm_module          => 'prefork',
      default_mods        => true,
      default_vhost       => false,
      default_confd_files => false,
    }

    include ::apache::mod::dir
    include ::apache::mod::php

  }

  # XXX: As we do not manage the apache user trough puppet we need to add it
  # to group nagios using this hacky way...
  exec { 'apache_user nagios membership':
    command => "usermod -aG nagios ${apache_user}",
    path    => [ '/usr/sbin', '/usr/bin', '/sbin', '/bin' ],
    unless  => "grep -q 'nagios\\S*${apache_user}' /etc/group",
    require => Class['::apache'],
    notify  => Service[$apache_service],
  }

  ::apache::vhost { $vhost_name:
    servername      => $servername,
    serveraliases   => $serveraliases,
    port            => $port,
    priority        => $priority,
    docroot         => $docroot,
    aliases         => $aliases,
    scriptaliases   => $scriptaliases,
    directories     => $directories,
    custom_fragment => $custom_fragment,
  }

}
