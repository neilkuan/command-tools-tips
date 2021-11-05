## Docker Create Network.
> Default use `docker0` Bridge.
```bash
## if not use --driver , default bridge.
docker network create hello --driver bridge
```


## Docker Inspect Get IPAddress.
```bash
docker inspect --format '{{.NetworkSettings.IPAddress}}' [one or more container_name or container_id...]

# example
docker run -d --name test1 nginx
docker run -d --name test2 nginx

# get ips
docker inspect --format '{{.NetworkSettings.IPAddress}}' test1 test2
172.17.0.2
172.17.0.3

```

## Docker Inspect Restart Policy.
```bash
docker inspect --format='{{.HostConfig.RestartPolicy}}' [one or more container_name or container_id...]

# example
docker run -d --name test1 nginx
docker run -d --restart always --name test2 nginx

# get ips
docker inspect --format '{{.HostConfig.RestartPolicy}}' test1 test2
{no 0}
{always 0}
```

## Docker Inspect PID.
```bash
docker inspect --format='{{.State.Pid}}' [one or more container_name or container_id...]

# example
docker run -d --name test1 nginx

# get ips
docker inspect --format '{{.State.Pid}}' test1 
3467
```

## Get ALL Image ID.
```bash
docker images | grep -v "REPOSITORY" | awk '{print $3}'
or
## use --format 
docker images --format "{{.ID}}"
```

## Remove None tag image.
## more https://www.hostinger.com/tutorials/docker-containers-images-and-volumes/.
```bash
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
```

### Container exit 0 and remove it.
```bash
[ `docker inspect test --format "{{json .State.ExitCode}}"` == 0 ] && docker rm test
```
