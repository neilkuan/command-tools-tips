
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



#### Instance MetadataOptions
https://blog.neilkuan.net/posts/2022-08-17-why-aws-sdk-js-v2-get-sts-assume-role-token-so-slow-in-k8s-node/
```bash
aws ec2 describe-instances --instance-id i-xxxxxx | jq '.Reservations[].Instances[].MetadataOptions'

aws ec2 modify-instance-metadata-options --instance-id i-xxxxxx --http-put-response-hop-limit 4 
```


#### Revoke Security Group Ingress via SecurityGroupRules Example
```bash
echo "revoke webUat sg-0d2ad0e70a9c89507 ingress"
aws ec2 describe-security-group-rules \
   --filter Name="group-id",Values="sg-xxxxxxxxxxx" --query 'SecurityGroupRules[?CidrIpv4!=`1.2.3.4/32`] | [?CidrIpv4!=`4.5.6.7/32`] | [?CidrIpv4!=`0.0.0.0/0`].SecurityGroupRuleId' --output text \
  | xargs -n 1  aws ec2 revoke-security-group-ingress --group-id sg-xxxxxxxxxxx  --security-group-rule-ids || echo "Not need to revoke ingress"

```


#### Retag Image not need docker cli
```bash

REPO_NAME=repo
TAG=latest
NEW_TAG_NAME=new-tag

MY_MANIFEST=$(aws ecr batch-get-image --repository-name "$REPO_NAME" \
--image-ids imageTag="$TAG"  --query 'images[].imageManifest' --output text)

aws ecr put-image --repository-name "$REPO_NAME" --image-tag "$NEW_TAG_NAME" --image-manifest "$MY_MANIFEST" 
```
