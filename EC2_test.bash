#!/bin/bash
yum -y update
yum -y upgrade
curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
bash mariadb_repo_setup --os-type=rhel --os-version=7 --mariadb-server-version=10.6
yum install wget MariaDB-server MariaDB-client -y 
systemctl enable --now mariadb
systemctl start mariadb
rm -rf mariadb_repo_setup
wget https://aws-tc-largeobjects.s3.us-west-2.amazonaws.com/CUR-TF-100-RESTRT-1/268-lab-DF-database-table-operations/s3/world.sql -P /home/ec2-user/
mkdir /home/ec2-user/logs/
touch /home/ec2-user/logs/create-db.log
#mysql --user=root --verbose < /home/ec2-user/world.sql > /home/ec2-user/logs/create-db.log
script -q -c 'mariadb-secure-installation' <<EOF

y
y
re:St@rt!9
re:St@rt!9
y
y
y
y
EOF
## Install AWS CLI v2
yum remove awscli -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install -b
export PATH=/usr/local/bin:$PATH
rm -rf awscliv2.zip typescript aws
touch ~/.ssh/config
echo "Host *" > ~/.ssh/config
echo "    ServerAliveInterval 60" >> ~/.ssh/config
chmod 600 ~/.ssh/config
yum update -y aws-cfn-bootstrap
/opt/aws/bin/cfn-init -v --stack c67396a1319383l3449849t1w101318406047 --resource CommandHost --configsets IncreaseSessionMgrTimeout --region us-west-2
/opt/aws/bin/cfn-signal -e $? --stack c67396a1319383l3449849t1w101318406047 --resource CommandHost --region us-west-2