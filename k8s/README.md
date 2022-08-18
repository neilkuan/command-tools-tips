# Install kubectl plugin 
> ref: https://krew.sigs.k8s.io/docs/user-guide/setup/install/

## Bash or ZSH shells
```bash
# Make sure that git is installed.

# Run this command to download and install krew:

(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
# Add the $HOME/.krew/bin directory to your PATH environment variable. To do this, update your .bashrc or .zshrc file and append the following line:

# export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# and restart your shell.

# Run kubectl krew to check the installation.
```

## kubectl krew install dds
```bash
$ kubectl krew install dds
Updated the local copy of plugin index.
Installing plugin: dds
Installed plugin: dds
\
 | Use this plugin:
 | 	kubectl dds
 | Documentation:
 | 	https://github.com/aws-containers/kubectl-detector-for-docker-socket
 | Caveats:
 | \
 |  | * If your docker socket is mounted at a different path name it will not
 |  | be checked.
 | /
/
WARNING: You installed plugin "dds" from the krew-index plugin repository.
   These plugins are not audited for security by the Krew maintainers.
   Run them at your own risk.

```


## Patch finalizers to null to delete resource
```bash
kubectl patch pod/${pod_name} -p '{"metadata":{"finalizers":null}}'
```

## Force delete pod
```bash
export PN=${pod_name} ;kubectl delete pod $PN --force --grace-period 0
```

## kubectl debug
```bash
Examples:
  # Create an interactive debugging session in pod mypod and immediately attach to it.
  # (requires the EphemeralContainers feature to be enabled in the cluster)
  kubectl debug mypod -it --image=busybox
  
  # Create a debug container named debugger using a custom automated debugging image.
  # (requires the EphemeralContainers feature to be enabled in the cluster)
  kubectl debug --image=myproj/debug-tools -c debugger mypod
  
  # Create a copy of mypod adding a debug container and attach to it
  kubectl debug mypod -it --image=busybox --copy-to=my-debugger
  
  # Create a copy of mypod changing the command of mycontainer
  kubectl debug mypod -it --copy-to=my-debugger --container=mycontainer -- sh
  
  # Create a copy of mypod changing all container images to busybox
  kubectl debug mypod --copy-to=my-debugger --set-image=*=busybox
  
  # Create a copy of mypod adding a debug container and changing container images
  kubectl debug mypod -it --copy-to=my-debugger --image=debian --set-image=app=app:debug,sidecar=sidecar:debug
  
  # Create an interactive debugging session on a node and immediately attach to it.
  # The container will run in the host namespaces and the host's filesystem will be mounted at /host
  kubectl debug node/mynode -it --image=busybox
 
 
 ## In my use case debug node.
  kubectl debug node/${AKS_NODE_NAME} -it --image=mcr.microsoft.com/dotnet/runtime-deps:6.0

```

## Get all resource in every namespace in one line
```
kubectl get ns |grep -v "NAME" | awk '{ print $1 }' | xargs -n 1 kubectl get all -n
```
