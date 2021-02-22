#!/bin/bash

run_id="$1"
webhook="$2"

workflow_jobs=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/zhengchang907/arm-oraclelinux-wls/actions/runs/${run_id}/jobs)
critical_job_num=$(echo $workflow_jobs | jq '.jobs | map(select(.name|test("^deploy."))) | length')
echo "$critical_job_num"
succeed_critical_job_num=$(echo $workflow_jobs | jq '.jobs | map(select(.conclusion=="success") | select(.name|test("^deploy."))) | length')
echo "$succeed_critical_job_num"
failed_job_num="$(($critical_job_num-$succeed_critical_job_num))"
echo $failed_job_num
if (($failed_job_num >= 2));then
    echo "too many jobs failed, send notification to Teams"
    curl ${webhook} \
    -H 'Content-Type: application/json' \
    --data-binary @- << EOF
    {
    "@context":"http://schema.org/extensions",
    "@type":"MessageCard",
    "text":"$failed_job_num jobs failed in arm-oraclelinux-wls workflow, please take a look at: https://github.com/zhengchang907/arm-oraclelinux-wls/actions/runs/${run_id}"
    }
EOF
fi
exit 0
