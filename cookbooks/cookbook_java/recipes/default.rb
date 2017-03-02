
# Cookbook Name:: cookbook_java
# Recipe:: default
#
# Copyright 2017,Capgemini 
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
package 'default-jdk' do
  action :install
end
 

cookbook_file "/usr/share/default-jdk/www/index.html" do
  source "index.html"
  mode "0644"
end















