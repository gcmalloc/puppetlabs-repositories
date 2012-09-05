require 'spec_helper'

describe 'repositories::puppetlabs', :type => 'class' do

  context "On an EL or Fedora OS" do
     baseurlOS  = 'fedora'
     os_version = '16'
     let(:facts) {{
      :operatingsystem => 'fedora',
      :osfamily        => 'RedHat',
      :os_maj_version  => '16',
      :architecture    => 'i386',
     }}

    it {
      should contain_yumrepo('puppetlabs-products').with(
         'baseurl'  => "http://yum.puppetlabs.com/#{baseurlOS}/f#{facts[:os_maj_version]}/products/#{facts[:architecture]}",
         'enabled'  => "1",
         'gpgcheck' => "1",
         'gpgkey'   => "http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs",
         'descr'    => "Puppet Labs Products f#{os_version} - #{facts[:architecture]}"
      )
      should contain_yumrepo('puppetlabs-deps').with(
         'baseurl' => "http://yum.puppetlabs.com/#{baseurlOS}/f#{facts[:os_maj_version]}/dependencies/#{facts[:architecture]}",
         'enabled'  => "1",
         'gpgcheck' => "1",
         'gpgkey'   => "http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs",
         'descr'    => "Puppet Labs Dependencies f#{os_version} - #{facts[:architecture]}"
      )
    }

  end

  context "On a Debian OS" do

     let(:facts) {{
      :operatingsystem => 'Ubuntu',
      :osfamily        => 'Debian',
      :lsbdistcodename => 'lucid',
     }}

    it {
      should contain_apt__source('puppetlabs-products').with(
       'location'   => 'http://apt.puppetlabs.com', 
       'repos'      => 'main',
       'key'        => '4BD6EC30',
       'key_server' => 'pgp.mit.edu'
      )

      should contain_apt__source('puppetlabs-devel').with(
       'location'   => 'http://apt.puppetlabs.com',
       'repos'      => 'devel',
       'key'        => '4BD6EC30',
       'key_server' => 'pgp.mit.edu'
      )
    }

  end
end
