#!/usr/bin/env python3

import json
import boto3
from datetime import datetime

def serialize(obj):
    
    if isinstance(obj, datetime):
        return obj.isoformat()
    raise TypeError(f"Type {obj.__class__.__name__} not serializable")

def get_inventory():
    ec2 = boto3.client('ec2', region_name='us-east-2')  
    response = ec2.describe_instances(Filters=[{'Name': 'tag:Role', 'Values': ['webserver']}])
    
    inventory = {
        'all': {
            'hosts': [],
            'vars': {}
        },
        '_meta': {
            'hostvars': {}
        }
    }
    
    ssh_key_file = 'ansible-worker.pem'  # Update to your SSH key file
    ssh_user = 'ubuntu'  # Update to your SSH user
    
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            public_dns = instance.get('PublicDnsName', instance['InstanceId'])
            inventory['all']['hosts'].append(public_dns)
            inventory['_meta']['hostvars'][public_dns] = {
                'ansible_host': instance.get('PublicIpAddress', instance['InstanceId']),
                'ansible_ssh_private_key_file': ssh_key_file,
                'ansible_user': ssh_user
            }

    return inventory

if __name__ == '__main__':
    try:
        print(json.dumps(get_inventory(), default=serialize, indent=2))
    except TypeError as e:
        print(f"Error serializing data: {e}")
