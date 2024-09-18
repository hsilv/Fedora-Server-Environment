# Fedora Server Environment
This is a template for a Fedora Server environment, using different technologies to implement the DevOps culture.

# Steps
## 1. Build the Server image
```
docker build -t fedora-server .
```

## 2. Run the container
### Interactive
```
docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /var/run/docker.sock:/var/run/docker.sock -it fedora-server
```
### Non-Interactive
```
docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /var/run/docker.sock:/var/run/docker.sock fedora-server
```