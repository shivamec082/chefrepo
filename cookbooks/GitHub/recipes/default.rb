#
# Cookbook Name:: GitHub
# Recipe:: default
#
# Copyright 2017, Capgemini
#
# All rights reserved - Do Not Redistribute
# 
application '/opt/github' do
  git 'https://github.com/shivamec082/javacode'
  bundle_install do
    deployment true
  end
  end


cookbook_file "/usr/share/GitHub/www/index.html" do
  source "index.html"
end
