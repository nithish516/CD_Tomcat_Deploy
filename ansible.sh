#!/bin/sh
chmod 0400 ./AmazonInstances.pem
echo "[$1]" >> ./inventory
/root/.local/bin/aws ec2 describe-instances | grep PublicIpAddress | awk -F ":" '{print $2}' | sed -e 's/[",]//g' > ./ipaddress.txt
cat ipaddress.txt | sed 's/^[ \t]*//;s/[ \t]*$//' >> ./ipaddress1.txt
tail -1 ipaddress1.txt >> ./inventory
ansible-playbook site.yml --limit $1