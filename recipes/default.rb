#
# Cookbook Name:: b-goapp
# Recipe:: default
#

# Apt
include_recipe 'apt'
# Install
include_recipe 'golang'
# Install packages
include_recipe 'golang::packages'
# Set up App
include_recipe 'b-goapp::webapp'
