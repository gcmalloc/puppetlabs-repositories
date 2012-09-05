# This is a simple fact to get the Major version of an OS.
# Originally written by Mike stahnke for puppet-module-epel

Facter.add(:os_maj_version) do
  v = Facter.value(:operatingsystemrelease)
  setcode do
    v.split('.')[0].strip
  end
end
