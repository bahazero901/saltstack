#!/bin/bash

#create nova user
openstack user create --domain default --password {{ nova_password }} nova

#add admin role to nova
openstack role add --project service --user nova admin

#create openstack service
openstack service create --name nova \
  --description "OpenStack Compute" compute

#compute endpoints
openstack endpoint create --region RegionOne \
  compute public http://controller:8774/v2.1

openstack endpoint create --region RegionOne \
  compute internal http://controller:8774/v2.1

openstack endpoint create --region RegionOne \
  compute admin http://controller:8774/v2.1

#placement service user
openstack user create --domain default --password-prompt placement

#dd the Placement user to the service project with the admin role
openstack role add --project service --user placement admin

#Create the Placement API entry in the service catalog
openstack service create --name placement --description "Placement API" placement

#Create the Placement API service endpoints:
openstack endpoint create --region RegionOne placement public http://controller:8778

openstack endpoint create --region RegionOne placement internal http://controller:8778

openstack endpoint create --region RegionOne placement admin http://controller:8778