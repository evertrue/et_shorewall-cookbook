#
# Cookbook Name:: et_shorewall
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

%w{
  shorewall
  make
}.each do |pkg|
  package pkg
end

cookbook_file '/etc/default/shorewall' do
  source 'default'
  owner 'root'
  group 'root'
  mode '0644'
end

execute 'shorewall_make' do
  cwd node['et_shorewall']['conf_dir']
  command 'make'
  action :nothing
  notifies :start, 'service[shorewall]'
end

%w{
  interfaces
  masq
  policy
  routestopped
  rules
  zones
}.each do |conf_file|

  template "#{node['et_shorewall']['conf_dir']}/#{conf_file}" do
    owner 'root'
    group 'root'
    mode '0644'
    source "#{conf_file}.erb"
    notifies :run, 'execute[shorewall_make]'
  end

end

service 'shorewall' do
  supports status: true, restart: true
  action [:enable]
end
