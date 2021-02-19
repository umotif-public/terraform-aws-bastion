#!/bin/bash -xe

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

if [[ -z "${HOSTED_ZONE_ID}" ]]
then
  echo "Hosted Zone ID is not provided. Route53 record for bastion host/s will not be created."
else
  INSTANCE_ID=$(curl --silent http://169.254.169.254/latest/meta-data/instance-id)
  REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's|[a-z]$||')

  ASG_NAME=$(aws --region $${REGION} ec2 describe-tags --filters "Name=resource-id,Values=$${INSTANCE_ID}" --query 'Tags[?Key==`aws:autoscaling:groupName`].Value' --output text)

  HOSTED_ZONE_NAME=$(aws --region $${REGION} route53 get-hosted-zone --id ${HOSTED_ZONE_ID} --query 'HostedZone.Name' --output text)
  ROUTE53_NAME="${NAME_PREFIX}-bastion.$${HOSTED_ZONE_NAME}"

  PUBLIC_IPS=""
  for INSTANCE_ID in $(aws --region $${REGION} autoscaling describe-auto-scaling-groups --auto-scaling-group-names $${ASG_NAME} --query 'AutoScalingGroups[].Instances[].InstanceId' --output text)
	do
		INSTANCE_PUBLIC_IP=$(aws --region $${REGION} ec2 describe-instances --instance-ids $${INSTANCE_ID} --query "Reservations[*].Instances[*].PublicIpAddress" --output text)
		PUBLIC_IPS="$${PUBLIC_IPS:+$${PUBLIC_IPS},}{\"Value\":\"$${INSTANCE_PUBLIC_IP}\"}"
	done

  JSON='{"Changes":[{"Action":"UPSERT","ResourceRecordSet":{"Name":"'"$${ROUTE53_NAME}"'","Type":"A","TTL":300,"ResourceRecords":['"$${PUBLIC_IPS}"']}}]}'

  aws --region $${REGION} route53 change-resource-record-sets \
    --hosted-zone-id ${HOSTED_ZONE_ID} \
    --change-batch $${JSON}
fi

sudo yum update -y
