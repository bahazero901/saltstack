kubernetes:
  master:
    firewall:
      api_server: 6443
      etcd_server: 2379-2380
      kubelet_api: 10250
      kube_scheduler: 10251
      kube_controller: 10252
      kubelet_api_ro: 10255

  worker:
    firewall:
      kubelet_api: 10250
      kubelet_api_ro: 10255
      nodeport_services: 30000-32767
