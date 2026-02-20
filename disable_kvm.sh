#!/bin/bash

echo "blacklist kvm_amd
blacklist kvm" | sudo tee /etc/modprobe.d/blacklist_kvm.conf
