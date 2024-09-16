#!/usr/bin/env bash
export VM_USER_PASSWD=''
#python manage-vm.py create \
#python test.py --service-account-key /home/librarian/.config/nebius-cloud/credentials/nbs-github-sa.json --id dp76rn62oun6jjorscja
python manage-vm.py create \
    --github-repo-owner ydb-platform \
    --github-repo nbs \
    --service-account-key /home/librarian/.config/nebius-cloud/credentials/nbs-github-sa.json \
    --name test-librarian \
    --folder-id bjeuq5o166dq4ukv3eec \
    --zone-id eu-north1-c --cpu 60 --ram 420 --disk-size 1023 --disk-type network-ssd-nonreplicated \
    --subnet-id f8uh0ml4rhb45nde9p75 --image-id arlqleknq7vlevdi7oa0 --labels test=1 --apply