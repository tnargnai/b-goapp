#
# Cookbook Name:: b-goapp
# Recipe:: webapp
#

# Webapp user
user node['b-goapp']['webapp']['user'] do
  comment 'User to run webapp'
  shell '/bin/bash'
end

# Create directories
directory "/opt/webapp/latest" do
  owner node['b-goapp']['webapp']['user']
  group node['b-goapp']['webapp']['group']
  mode 00755
  recursive true
  action :create
end

if platform_family?('rhel')
  # Create init
  cookbook_file '/etc/init.d/webapp' do
    source 'init/rhel-webapp-init'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

if platform_family?('debian')
  # Create init
  cookbook_file '/etc/init/webapp.conf' do
    source 'init/deb-webapp.conf'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end
end

# Set service
service "webapp" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable ]
end

# # Create bin and start / restart webapp
# remote_file '/opt/webapp/latest/webapp' do
#   source node['b-goapp']['bin']
#   owner 'webapp'
#   group 'webapp'
#   mode '0755'
#   action :create
#   notifies :restart, "service[webapp]"
# end
