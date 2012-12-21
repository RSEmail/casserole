#!/bin/bash
#
# Script to set up Chef on a Travis CI node, build a basic set of configs,
# and do a run with Minitest-Chef-Handler
#

build_solo_rb() {
    echo "file_cache_path \"/tmp\"" > /tmp/solo.rb
    p1=`dirname \`pwd\``
    p2=/tmp/berkshelf
    echo "cookbook_path [\"$p1\", \"$p2\"]" >> /tmp/solo.rb
    echo "role_path nil" >> /tmp/solo.rb
    echo "log_level :info" >> /tmp/solo.rb
    echo "encrypted_data_bag_secret \"/tmp/encrypted_data_bag_secret\"" >> /tmp/solo.rb
    echo "data_bag_path \"`pwd`/test/data_bags\"" >> /tmp/solo.rb
    echo "http_proxy nil" >> /tmp/solo.rb
    echo "http_proxy_user nil" >> /tmp/solo.rb
    echo "http_proxy_pass nil" >> /tmp/solo.rb
    echo "https_proxy nil" >> /tmp/solo.rb
    echo "https_proxy_user nil" >> /tmp/solo.rb
    echo "https_proxy_pass nil" >> /tmp/solo.rb
    echo "no_proxy nil" >> /tmp/solo.rb
}

build_dna_json() {
    echo "{\"run_list\":[\"recipe[minitest-handler]\"," > /tmp/dna.json
    echo "\"recipe[casserole]\"]," >> /tmp/dna.json
    echo "\"cassandra\":{" >> /tmp/dna.json
    echo "    \"clustered\":true," >> /tmp/dna.json
    echo "    \"data_bag\":\"cassandra_clusters\"," >> /tmp/dna.json
    echo "    \"cluster_name\":\"cluster1\"," >> /tmp/dna.json
    echo "    \"node_id\":\"cassandra1.dc1.example.com\"}}" >> /tmp/dna.json
}

resolve_deps() {
    echo "cookbook \"minitest-handler\"" >> Berksfile
    echo "Using GEMPATH: $GEM_PATH for berks install..."
    $GEM_PATH/bin/berks install --path /tmp/berkshelf
}

build_solo_rb
build_dna_json
resolve_deps

chef-solo -l debug -c /tmp/solo.rb -j /tmp/dna.json
