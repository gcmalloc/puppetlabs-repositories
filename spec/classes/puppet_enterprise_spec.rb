require 'spec_helper'

describe 'repositories::puppet_enterprise', :type => 'class' do

  pe_version = '2.5'

  context "On an EL OS" do
     dist       = 'el'
     let(:facts) {{
      :operatingsystem => 'CentOS',
      :osfamily        => 'RedHat',
      :os_maj_version  => '6',
      :architecture    => 'i386',
     }}

    it {
      should contain_yumrepo('pe-main').with(
         'baseurl'  => "http://neptune.puppetlabs.lan/#{pe_version}/repos/#{dist}-#{facts[:os_maj_version]}-#{facts[:architecture]}",
	 'enabled'  => '1',
         'gpgcheck' => '0'
      )
      should contain_yumrepo('pe-SRPMS').with(
         'baseurl'  => "http://neptune.puppetlabs.lan/#{pe_version}/repos/#{dist}-#{facts[:os_maj_version]}-srpms",
 	 'enabled'  => '1',
         'gpgcheck' => '0'
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
      should contain_apt__key('puppetlabs').with(
	'key'        => '4BD6EC30',
        'key_source' => 'http://neptune.puppetlabs.lan/debian/pubkey.gpg'
      )
      
      should contain_apt__source('pe-main').with(
	'location'   => 'http://neptune.puppetlabs.lan/debian',
        'repos'      => "#{pe_version} #{facts[:lsbdistcodename]}",
        'release'    => ''  
      )
    }
  end
end
