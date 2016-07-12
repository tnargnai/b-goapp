#
# Cookbook Name:: b-goapp
# Recipe:: default
#


if platform_family?('rhel')

  yum_repository 'epel' do
    description 'Extra Packages for Enterprise Linux'
    mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch'
    gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
    action :create
  end

  # Install
  include_recipe 'golang'
  # Install packages
  include_recipe 'golang::packages'
  # Set up App
  include_recipe 'b-goapp::webapp'
end

if platform_family?('debian')
  # Apt
  include_recipe 'apt'
  # Install
  include_recipe 'golang'
  # Install packages
  include_recipe 'golang::packages'
  # Set up App
  include_recipe 'b-goapp::webapp'
end
