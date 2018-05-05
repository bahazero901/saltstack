#turn off swap

#kubeadm init --pod-network-cidr=10.244.0.0/16

#for a single master only node run the following command to run containers on master
#kubectl taint nodes --all node-role.kubernetes.io/master-
#by default no caontainers are scheduled on the master


#The cluster created here has a single master, with a single etcd database running on it. This means that if the master fails, your cluster may lose data and may need to be recreated from scratch. Adding HA support (multiple etcd servers, multiple API servers, etc) to kubeadm is still a work-in-progress.
#
#Workaround: regularly back up etcd. The etcd data directory configured by kubeadm is at /var/lib/etcd on the master.
#

