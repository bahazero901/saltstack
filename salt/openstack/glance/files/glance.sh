#!/bin/bash

. adminrc.sh

#create glance user
openstack user create --domain default \
--password password glance

#add admin to glance and service role
openstack role add --project service --user glance admin

#glance service entity
openstack service create --name glance \
--description "OpenStack Image" image

#create image service API endpoint
openstack endpoint create --region RegionOne \
  image public http://controller:9292

openstack endpoint create --region RegionOne \
  image internal http://controller:9292

openstack endpoint create --region RegionOne \
  image admin http://controller:9292