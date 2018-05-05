export OS_USERNAME=admin
{{ salt['pillar.get']('rabbitmq:user') }}
export OS_PASSWORD={{ salt['pillar.get']('keystone:openstack:password') }}
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://controller:35357/v3
export OS_IDENTITY_API_VERSION=3

