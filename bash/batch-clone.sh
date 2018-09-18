#!/bin/bash

# ssh://git@g.hz.netease.com:22222/youdata/colorbox.git ssh://git@g.hz.netease.com:22222/youdata/backend.git
for repo in "$@"
do
  git clone $repo
done