#!/bin/bash
if [ ! -d janus/slimv ];then
  hg clone https://bitbucket.org/sjl/slimv janus/slimv
fi
cd janus/slimv
hg pull
hg update sjl-custom
