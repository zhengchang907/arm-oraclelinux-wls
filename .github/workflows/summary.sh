
#!/bin/bash

latest_workflow=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/zhengchang907/arm-oraclelinux-wls/actions/runs?per_page=1&page=1)
echo $latest_workflow

latest_workflow_id=$(echo $latest_workflow | jq '.workflow_runs[0].id')
echo $latest_workflow_id

workflow_jobs=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/zhengchang907/arm-oraclelinux-wls/actions/runs/$latest_workflow_id/jobs)
echo $workflow_jobs

critical_job_num=$(echo $workflow_jobs | jq '.jobs | map(select(.name|test("^deploy."))) | length')
echo $critical_job_num

succeed_critical_job_num=$(echo $workflow_jobs | jq '.jobs | map(select(.conclusion=="success") | select(.name|test("^deploy."))) | length')
echo $succeed_critical_job_num

echo $(( $critical_job_num - $succeed_critical_job_num ))
if (( $(( $critical_job_num - $succeed_critical_job_num )) >= 2 ))
then 
    echo "failed, fire Teams event"
else
    echo "succeed"
fi

exit 1
