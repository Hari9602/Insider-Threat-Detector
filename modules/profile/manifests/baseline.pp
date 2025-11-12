class profile::baseline {

  # Ensure packages/services used by baseline exist
  package { 'openssh-server':
    ensure => installed,
  }

  service { 'sshd':
    name      => $facts['os']['family'] ? {
      'Debian' => 'ssh',
      default  => 'sshd',
    },
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/ssh/sshd_config'],
  }

  # Enforce sshd_config from baseline
  file { '/etc/ssh/sshd_config':
    ensure   => file,
    owner    => 'root',
    group    => 'root',
    mode     => '0600',
    source   => 'puppet:///modules/profile/sshd_config.baseline',
    replace  => true,
    checksum => 'sha256',
    show_diff => false,
  }

  # Enforce /etc/passwd from baseline (lab only; adjust for production)
  file { '/etc/passwd':
    ensure   => file,
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
    source   => 'puppet:///modules/profile/passwd.baseline',
    replace  => true,
    checksum => 'sha256',
    show_diff => false,
  }

  # Enforce critical executable
  file { '/usr/local/bin/critical_bin':
    ensure   => file,
    owner    => 'root',
    group    => 'root',
    mode     => '0755',
    source   => 'puppet:///modules/profile/critical_bin',
    replace  => true,
    checksum => 'sha256',
    show_diff => false,
  }

}
