This is your first step.

## Task

检查 Kubernetes 集群
使用前，检查 Kubernetes 集群状态：`kubectl cluster-info`{{execute}}

启动kuboard
`kubectl apply -f https://kuboard.cn/install-script/kuboard.yaml
kubectl apply -f https://addons.kuboard.cn/metrics-server/0.3.6/metrics-server.yaml
`{{execute}}

获取token
# 如果您参考 www.kuboard.cn 提供的文档安装 Kuberenetes，可在第一个 Master 节点上执行此命令
`echo $(kubectl -n kube-system get secret $(kubectl -n kube-system get secret | grep kuboard-user | awk '{print $1}') -o go-template='{{.data.token}}' | base64 -d)
`{{execute}}

访问：
http://任意一个Worker节点的IP地址:32567/

