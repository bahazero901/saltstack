#!/bin/bash

#create neutron user
openstack user create --domain default --password password neutron

#add admin role to neutron
openstack role add --project service --user neutron admin

#create neutron service
openstack service create --name neutron \
  --description "OpenStack Networking" network

#creating Neworking service API endpoints
openstack endpoint create --region RegionOne \
  network public http://controller:9696

openstack endpoint create --region RegionOne \
  network internal http://controller:9696

openstack endpoint create --region RegionOne \
  network admin http://controller:9696

