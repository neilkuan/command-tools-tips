
### For Loop list AWS ECR Repo.
```bash
for i in "backend" "frontend" "db"
do
   echo "list ${i}"
   aws ecr list-images --repository-name ${i} --region ap-northeast-1 --query ['imageIds'] --filter tagStatus="TAGGED" --output text | awk '{print $2}'|sort -rn | head -n 10
done

--- example output ---
list backend
0.0.1
0.0.2
0.0.3
  
list frontend
0.0.1
0.0.2
0.0.3
  
list db
0.0.1
0.0.2
```

### Query AWS ECR Specify Tag existed?
```bash
# hard code Tag
aws ecr list-images --repository-name  frontend --query 'imageIds[?imageTag==`1.0.0`].imageTag' --filter tagStatus="TAGGED"

# use environmental variables 
TAG=1.0.0 aws ecr list-images --repository-name  tn-frontend --query "imageIds[?imageTag==\`$TAG\`].imageTag" --filter tagStatus="TAGGED" --output text
```


### Check EKS Cluster Update
```bash
 CLSUTER=xxxxxx; aws eks describe-update --name $CLSUTER --update-id $(aws eks list-updates --name $CLSUTER --query 'updateIds[0]' --output text)
```
