#!/bin/sh
chmod 0400 ./AmazonInstances.pem
echo "[$1]" >> ./inventory
rm -f ./ipaddress.txt ./ipaddress.txt
/root/.local/bin/aws ec2 describe-instances | grep PublicIpAddress | awk -F ":" '{print $2}' | sed -e 's/[",]//g' > ./ipaddress.txt
cat ./ipaddress.txt
cat ipaddress.txt | sed 's/^[ \t]*//;s/[ \t]*$//' >> ./inventory
#cat ./ipaddress1.txt
#tail -1 ./ipaddress1.txt >> ./inventory
#ipaddress1.txt >> ./inventory
cat ./inventory
ansible-playbook -i ./inventory site.yml --limit $1
