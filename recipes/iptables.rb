# Cookbook Name:: casserole
# Recipe:: firewall
#
# Copyright 2012, Arif Khokar, Joshua Rush, and Kyle Morgan
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#Open ports
iptables_rule "open_cassandra_ports" do
    source "iptables/open_cassandra_ports.erb"
    variables(
        :iptables_chain => "FWR",
        :ports => node["cassandra"]["open_ports"]
    )
end

# vim:et:fdm=marker:sts=4:sw=4:ts=4:
