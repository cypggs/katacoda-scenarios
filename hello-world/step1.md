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

访问：(must fangqiang maybe)
右边点击终端添加，选择第三个任意端口访问，打开后输入32567端口，会自动调整到类似连接（需fangqiang）
https://2886795294-32567-cykoria03.environments.katacoda.com/

添加k8s快捷命令
`cat >>  ~/.bashrc << EOF
alias kg='kubectl get'
alias kc='kubectl apply -f'
alias ke='kubectl exec -it'
alias kd='kubectl describe pods'
alias kl='kubectl logs -f'
alias ktmp='kubectl run -i --tty --image busybox dns-test --restart=Never --rm /bin/sh'
EOF
source ~/.bashrc`{{execute}}

获取pods状态
`kg pods -A`{{execute}}
`kg svc -A`{{execute}}
`kg ing -A`{{execute}}


