
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



### AWS Console `EC2_INSTANCE_CONNECT` Ip range search example.
```bash
## 2021-10-01 16:21 (UTC+8)
curl -s https://ip-ranges.amazonaws.com/ip-ranges.json | jq -r '.prefixes[] | select(.service=="EC2_INSTANCE_CONNECT") | select(.region=="ap-northeast-1") | .ip_prefix' 
3.112.23.0/29
```


### Reset Iam User Password.
```bash
aws iam update-login-profile --user-name <Iam User Name> --no-password-reset-required --password <Password for this User>
```

### Using AWS CLI pagination options
> ref: [docs](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-pagination.html)

> ref: [issue](https://stackoverflow.com/questions/68030178/why-oh-my-zsh-require-manually-click-q-after-some-aws-cli)

How to use the AWS_PAGER environment variable

```bash
# In your .bashrc or .zshrc

## disable aws pager
export AWS_PAGER=""

```


# AWS Profile selector tools
require: [gum](https://github.com/charmbracelet/gum)

create `$HOME/.bin/awsset` file.
```bash
# if not create
mkdir $HOME/.bin
touch $HOME/.bin/awsset

# define code
echo '
#!/bin/sh

PATH=${PATH}:${HOME}/go/bin

TEMP_FILE="/tmp/temp-profile-list.txt"
if [ -s ${TEMP_FILE} ];then
else
   echo create ${TEMP_FILE}
   unset AWS_PROFILE && aws configure list-profiles > ${TEMP_FILE}
fi
AWS_PROFILE_LIST=$(cat $HOME/.aws/temp-profile-list.txt)
PROFILE=$(cat ${TEMP_FILE} | gum choose)

export AWS_PROFILE=${PROFILE}
' > $HOME/.bin/awsset

# add alias in to your .zshrc or .bashrc
awsset='source /Users/neil/.bin/awsset'

```
