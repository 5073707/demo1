aws ec2 run-instances --image-id <ami-0fc5d935ebf8bc3bc>  \
--count 1 --instance-type <t3.micro> \
 --key-name <2023_Instance> \
--security-group-ids <aws_default_vpc.default.id> \
--subnet-id <subnet-0ee29553d89f6b26c>
