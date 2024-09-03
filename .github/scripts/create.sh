export ORG=
export TEAM=
export REPO_OWNER=ydb-platform
export REPO=nbs
export SERVICE_ACCOUNT_KEY=/home/librarian/.config/nebius-cloud/credentials/nbs-github-sa.json
export VM_NAME=test-librarian
#export VM_NAME=test-librarian-good
export VM_FOLDER=bjeuq5o166dq4ukv3eec
export VM_ZONE=eu-north1-c
export VM_CPU=60
export VM_MEMORY=420
export VM_DISK_SIZE=1023
export VM_DISK_TYPE=network-ssd-nonreplicated
export VM_SUBNET=f8uh0ml4rhb45nde9p75
export VM_IMAGE=arl3u8glibt86iqm7u2f
#export VM_IMAGE=arlebod4m0bn5gao7psc
export VM_LABELS="test=1"
export VM_USER_PASSWD='$6$n1rZOG7oY5BI.LCv$IeHVpzHRbj.7qtgSYD7BnS/o9O.nQO6Bc.lK1RjeySsDnUiTiEVy.65YyrUTzanm.OL7VvrEkbIIsth.R6qbZ.'
set -x
python manage-vm.py create ${ORG} ${TEAM} \
    --github-repo-owner "${REPO_OWNER}" \
    --github-repo "${REPO}" \
    --service-account-key "${SERVICE_ACCOUNT_KEY}" \
    --name "${VM_NAME}" \
    --folder-id "${VM_FOLDER}" \
    --zone-id "${VM_ZONE}" \
    --cpu "${VM_CPU}" --ram "${VM_MEMORY}" --disk-size "${VM_DISK_SIZE}" \
    --disk-type "${VM_DISK_TYPE}" \
    --subnet-id "${VM_SUBNET}" \
    --image-id "$VM_IMAGE" \
    --labels "$VM_LABELS" \
    --apply
