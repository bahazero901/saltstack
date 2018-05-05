Master node(s)
TCP	Inbound	6443*	Kubernetes API server
TCP	Inbound	2379-2380	etcd server client API
TCP	Inbound	10250	Kubelet API
TCP	Inbound	10251	kube-scheduler
TCP	Inbound	10252	kube-controller-manager
TCP	Inbound	10255	Read-only Kubelet API
Worker node(s)
Protocol	Direction	Port Range	Purpose
TCP	Inbound	10250	Kubelet API
TCP	Inbound	10255	Read-only Kubelet API
TCP	Inbound	30000-32767	NodePort Services**
