#!/bin/sh
if [ ! -f /config/config.yaml ]; then
    cp /Proxmox-load-balancer/config.yaml /config/config.yaml
fi

python /Proxmox-load-balancer/plb.py