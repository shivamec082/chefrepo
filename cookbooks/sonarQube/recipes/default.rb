
# Cookbook Name:: sonarQube
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apt'



include_recipe 'cookbook_java'

# Install the latest version of SonarQube with default properties
# including H2 database (not recommended for production installation)
sonarqube_server 'sonar' do
  notifies :restart, 'service[sonar]'
end

# Create a Sonar service. This is required if you want Sonar to start.
service 'sonar' do
  action [:enable, :start]
  supports status: true, restart: true, reload: true
end





