#
# Author:: Thijs Houtenbos <thoutenbos@schubergphilis.com>
# Cookbook:: acme_server
# Recipe:: default
#
# Copyright 2015 Schuberg Philis
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

file 'hosts' do
  path '/etc/hosts'
  atomic_update false
  content "127.0.0.1\tlocalhost boulder boulder-rabbitmq boulder-mysql"
  only_if { platform? 'centos' }
end

chef_gem 'chef-rewind'
require 'chef/rewind'

include_recipe 'letsencrypt-boulder-server'

# awaiting https://github.com/customink-webops/hostsfile/pull/78
rewind hostsfile_entry: '127.0.0.1' do
  action :nothing
end
