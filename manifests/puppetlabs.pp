class puppetlabs_repositories::puppetlabs {

  case $osfamily {
    RedHat: {

      case $operatingsystem {
        'fedora': {
          $baseurlOS  = 'fedora'
          $os_version = $os_maj_version ? {
            '15'    => 'f15',
            '16'    => 'f16',
            '17'    => 'f17',
            default => undef,
          }
        }
        default: {
          $baseurlOS  = 'el'
          $os_version = $os_maj_version
        }
     }

      yumrepo { 'puppetlabs-products':
          baseurl   => "http://yum.puppetlabs.com/${baseurlOS}/${os_version}/products/${::architecture}",
          enabled   => '1',
          gpgcheck  => '1',
          gpgkey    => 'http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs',
          descr     => "Puppet Labs Products ${os_version} - ${::architecture}",
      }

      yumrepo { 'puppetlabs-deps':
          baseurl   => "http://yum.puppetlabs.com/${baseurlOS}/${os_version}/dependencies/${::architecture}",
          enabled   => '1',
          gpgcheck  => '1',
          gpgkey    => 'http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs',
          descr     => "Puppet Labs Dependencies ${os_version} - ${::architecture}",
      }

      yumrepo { 'puppetlabs-products-source':
          baseurl         => "http://yum.puppetlabs.com/${baseurlOS}/${os_version}/products/SRPMS",
          failovermethod  => 'priority',
          enabled         => '0',
          gpgcheck        => '1',
          gpgkey          => 'http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs',
          descr           => "Puppet Labs Products ${os_version} - ${::architecture} - Source",
      }

      yumrepo { 'puppetlabs-deps-source':
          baseurl   => "http://yum.puppetlabs.com/${baseurlOS}/${os_version}/dependencies/SRPMS",
          enabled   => '0',
          gpgcheck  => '1',
          gpgkey    => 'http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs',
          descr     => "Puppet Labs Source Dependencies ${os_version} - Source",
      }
    }

    Debian: {
      apt::source { 'puppetlabs-products':
          location   => 'http://apt.puppetlabs.com',
          repos      => 'main',
          key        => '4BD6EC30',
          key_server => 'pgp.mit.edu',
      }

      apt::source { 'puppetlabs-devel':
          location   => 'http://apt.puppetlabs.com',
          repos      => 'devel',
          key        => '4BD6EC30',
          key_server => 'pgp.mit.edu',
      }
    }

    default: {
      notice("Error: $::operatingsystem is not a supported platform.")
    }
  }
}
