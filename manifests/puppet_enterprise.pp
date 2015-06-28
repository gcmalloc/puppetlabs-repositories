class puppetlabs_repositories::puppet_enterprise {

  $pe_version = '2.5'
  case $osfamily {
    /(RedHat|Suse)/: {
    case $operatingsystem {
      /(CentOS|SLES)/: {
          $dist = $operatingsystem ? {
            'SLES'  => 'sles',
            default   => 'el',
          }

          yumrepo { 'pe-main':
              baseurl   => "http://neptune.puppetlabs.lan/${pe_version}/repos/${dist}-${os_maj_version}-${architecture}",
              enabled   => '1',
              gpgcheck  => '0',
              descr     => "Puppet Labs Products ${os_version} - ${::architecture}",
          }

          yumrepo { 'pe-SRPMS':
              baseurl   => "http://neptune.puppetlabs.lan/${pe_version}/repos/${dist}-${os_maj_version}-srpms",
              enabled   => '1',
              gpgcheck  => '0',
              descr     => "Puppet Labs Products ${os_version} - ${::architecture}",
          }
        }
        default: {
          notice('Error: $operatingsystem is not a supported platform')
        }
      }
    }


    'Debian': {
      apt::key { "puppetlabs":
        key        => '4BD6EC30',
        key_source => 'http://neptune.puppetlabs.lan/debian/pubkey.gpg',
      }

      apt::source { 'pe-main':
          location   => 'http://neptune.puppetlabs.lan/debian',
          repos      => "${pe_version} ${lsbdistcodename}",
          release    => '',
      }
    }
  }
}
