#!/bin/bash

for i in drivers infrastructure lixeiras manager marketing owner profiles public security devel homes; do mkfs -t ext4 /dev/storage/$i; done
