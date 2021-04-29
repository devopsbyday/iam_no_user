#!/usr/bin/env bash
ROOT="$(git rev-parse --show-toplevel)"
source ${ROOT}/env/$1

if [ ${ORG} = "main" ]; then
    ORG_ACCOUNT_ID="360464095367"
else
    ORG_ACCOUNT_ID="005402609678"
fi

echo "Deploying CodeBuild Role"

aws cloudformation deploy \
  --template-file ${ROOT}/guard-duty-monitoring-integration/stacks/Ops-Mon-BuildRole.yaml \
  --stack-name "${CLOUD_TEAM_IDENTIFIER}-guardduty-to-mom-build-role" \
  --parameter-override \
  CloudTeamIdentifier="${CLOUD_TEAM_IDENTIFIER}" \
  ArtefactBucketPrefix="${ARTEFACT_BUCKET_PREFIX}" \
  --capabilities CAPABILITY_NAMED_IAM \
  --profile "${MGMT_ACC_PROFILE}" \
  --region "eu-west-2" \
  --tags \
  ServiceCode="${SERVICE_CODE}" \
  ServiceName="${SERVICE_NAME}" \
  ServiceOwner="${SERVICE_OWNER}"
