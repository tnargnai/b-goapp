#
# Cookbook Name:: b-goapp
# Recipe:: webapp
#

# Webapp user
user 'webapp' do
  comment 'User to run webapp'
  shell '/bin/bash'
end

# Create directories
directory "/opt/webapp/latest" do
  owner "webapp"
  group "webapp"
  mode 00755
  recursive true
  action :create
end

# Create init
cookbook_file '/etc/init/webapp.conf' do
  source 'init/webapp.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# Set service
service "webapp" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable ]
end

# Create bin and start / restart webapp
# cookbook_file '/opt/webapp/latest/web' do
#   source 'bin/web'
#   owner 'webapp'
#   group 'webapp'
#   mode '0755'
#   action :create
#   notifies :restart, "service[webapp]"
# end

remote_file '/opt/webapp/latest/web' do
  source node['b-goapp']['bin']
  owner 'webapp'
  group 'webapp'
  mode '0755'
  action :create
  notifies :restart, "service[webapp]"
end
