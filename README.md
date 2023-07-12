
# Proxmox Load Balancer

The Proxmox Load Balancer Pro script is designed to automatically load balance the RAM of the Proxmox cluster (or part of the cluster). This script does not use CPU load balancing for a variety of reasons. The algorithm of this script remains largely faithful to the original, found at [https://github.com/cvk98/Proxmox-memory-balancer](https://github.com/cvk98/Proxmox-memory-balancer).

Please consider leaving a star if you find this script useful. Your feedback and feature requests are always welcome.

This application can be deployed as a Docker container for easy management and scaling. You can find the source code for the script on https://github.com/upchui/proxmox-load-balancer and the Docker images are available on https://hub.docker.com/r/thealhu/proxmox-load-balancer.

## Features

-   VM and node exclusion list.
-   Optional disabling of LXC migration.
-   Load spread range setting.
-   Significantly redesigned VM selection algorithm.
-   Continuous operation with periodic sleep (configurable).
-   Automated deployment via ansible to all cluster nodes using HA.

## Permissions

Most likely, the script does not need a root PVE account. You can create a separate account with the necessary permissions (untested). However, this script only uses one POST method for VM/LXC migration, so it should not harm your cluster.

## Recommendations

-   A shared storage is required for the migration mechanism to work correctly. This can be CEPH or any other distributed storage, or a storage system connected to all Proxmox nodes.
-   The recommended value for "deviation" is 4% for a cluster of similar size and composition.
-   Don't set the "deviation" value to 0, as this will result in permanent VM migration with the slightest change in VM["mem"]. The recommended minimum value is 1% for large clusters and 3-5% for medium and small clusters.
-   The script requires constant access to the Proxmox host.


# Run the Docker container

### docker-compose (recommended)

```yaml
---
version: '3'
services:
  proxmox-load-balancer:
    image: thealhu/proxmox-load-balancer:latest
    container_name: proxmox-load-balancer
    restart: always
    volumes:
      - ./config:/config
```

### docker cli 

```bash
docker run -d \
	--restart always \
	--name proxmox-load-balancer \
	-v "$(pwd)/config:/config" \
	thealhu/proxmox-load-balancer:latest
```


## Contribution

If you have a feature request, found a bug, or want to contribute to the code, please feel free to raise an issue or submit a pull request. Your feedback and contributions are highly appreciated!
