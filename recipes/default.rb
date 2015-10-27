#
# Cookbook Name:: chef-pw_mofa
# Recipe:: default
#
# Copyright (C) 2015 Christoph Lukas
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe 'pw_chefdk'

bash 'install mofa' do
  user node['pw_mofa']['user']
  cwd node['pw_mofa']['userhome']
  code <<-EOC
  export HOME=#{node['pw_mofa']['userhome']}
  eval "$(chef shell-init bash)"
  chef gem install mofa -v #{node['pw_mofa']['version']}
  EOC
  not_if "test -f #{node['pw_mofa']['userhome']}/.chefdk/gem/ruby/2.1.0/gems/mofa-#{node['pw_mofa']['version']}/Gemfile"
end

directory "#{node['pw_mofa']['userhome']}/.mofa" do
  owner node['pw_mofa']['user']
  group node['pw_mofa']['group']
  mode '755'
end

cookbook_file 'mofa-config.yml' do
  path "#{node['pw_mofa']['userhome']}/.mofa/config.yml"
  owner node['pw_mofa']['user']
  group node['pw_mofa']['group']
  mode '644'
end
