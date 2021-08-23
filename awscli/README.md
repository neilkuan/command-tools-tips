
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
