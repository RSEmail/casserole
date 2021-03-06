#
# Cookbook Name:: casserole
# Recipe:: default
#
# Copyright 2012, Jonathan Hartman
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

include_recipe "java"
include_recipe "#{@cookbook_name}::repos"
include_recipe "#{@cookbook_name}::packages"
include_recipe "#{@cookbook_name}::configs"

([node["cassandra"]["name"]] + node["cassandra"]["extra_services"]).each do |s| 
    service s do
        supports :restart => true, :status => true
        action [:enable, :start]
    end 
end

# vim:et:fdm=marker:sts=4:sw=4:ts=4:
