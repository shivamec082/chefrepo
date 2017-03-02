#
# Cookbook Name:: sonar
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'cookbook_java'

pkg_name = "sonar_#{node['sonarqube']['version']}_all.deb"

remote_file ::File.join(Chef::Config[:file_cache_path], pkg_name) do
  source "#{node['sonarqube']['pkg']['uri']}/#{pkg_name}"
  checksum node['sonarqube']['pkg']['checksum']
end

dpkg_package 'sonar' do
  source ::File.join(Chef::Config[:file_cache_path], pkg_name)
end

service 'sonar' do 
  action [:enable, :start]
end

archive_name = "#{node['sonarqube']['runner']['base_filename']}-#{node['sonarqube']['runner']['version']}.#{node['sonarqube']['runner']['archive_type']}"
download_uri = "#{node['sonarqube']['runner']['base_uri']}/#{node['sonarqube']['runner']['version']}/#{archive_name}"

package 'unzip'

remote_file ::File.join(Chef::Config['file_cache_path'], archive_name) do
  source download_uri
  checksum node['sonarqube']['runner']['checksum']
  notifies :install, 'package[unzip]', :immediately
  notifies :run, 'execute[unzip-runner]', :immediately
end

execute 'unzip-runner' do
  command "unzip -o #{::File.join(Chef::Config['file_cache_path'], archive_name)} -d #{node['sonarqube']['path']}"
  action :nothing
end
template ::File.join(node['sonarqube']['path'], "sonar-runner-#{node['sonarqube']['runner']['version']}", 'conf', 'sonar-runner.properties') do
  source 'sonar-runner.properties.erb'
  owner node['sonarqube']['system']['user']
  group node['sonarqube']['system']['group']
end
