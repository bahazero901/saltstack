#!/bin/bash

export OS_USERNAME=admin
{{ salt['pillar.get']('rabbitmq:user') }}
export OS_PASSWORD={{ salt['pillar.get']('keystone:openstack:password') }}
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://controller:35357/v3
export OS_IDENTITY_API_VERSION=3

#creates a service project
openstack project create --domain default --description "Service Project" service

#creates a demo project
openstack project create --domain default --description "Demo Project" demo

#creates demo user
openstack user create --domain default --password-prompt demo

#create role user
openstack role create user

#add user role to demo project
openstack role add --project demo --user demo user


