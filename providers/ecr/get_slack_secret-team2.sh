
#!/bin/sh

kubectl get secret ecr-slack-token-team2 -o yaml -n ecr > slack-token-secret-team2.yaml
ECR_REPO=`echo $(awk '{if(NR==3) print $2}' slack-token-secret-team2.yaml) | base64 --decode`
SLACK_TOKEN=`echo $(awk '{if(NR==4) print $2}' slack-token-secret-team2.yaml) | base64 --decode`

sed -i '' "s|<ECR_REPO>|$ECR_REPO|g" variables.tf
sed -i '' "s|<SLACK_TOKEN>|$SLACK_TOKEN|g" variables.tf
