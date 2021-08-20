## minikube use local image.
```
# Start minikube
minikube start

# Set docker env
eval $(minikube docker-env)             # unix shells
minikube docker-env | Invoke-Expression # PowerShell

# Build image
docker build -t foo:0.0.1 .

# Run in minikube
kubectl run hello-foo --image=foo:0.0.1 --image-pull-policy=Never

# Check that it's running
kubectl get pods
```
