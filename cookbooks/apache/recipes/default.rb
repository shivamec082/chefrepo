#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2017, Capgemini
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"

package 'apache2' do
  
  action :install 

end

cookbook_file 'usr/share/apache/www/html.index' do

source 'index.html'

end









service 'apache2' do

 action  [:start,:enable]

end

