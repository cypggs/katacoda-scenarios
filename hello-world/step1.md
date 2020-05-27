>*author:cypggs  
mail:qcypggs@qq.com
github:https://github.com/cypggs/katacoda-scenarios
describe:学习k8s实验室
belief:计算机科学毕竟是一门实践性的科学，动手实操才是学习的捷径！*

![Pandao editor.md](https://pandao.github.io/editor.md/images/logos/editormd-logo-180x180.png "Pandao editor.md")
[http://www.mdeditor.com/](http://www.mdeditor.com/)


## Task

### 检查 Kubernetes 集群

使用前，检查 Kubernetes 集群状态：`kubectl cluster-info`{{execute}}

### 部署[kuboard](https://kuboard.cn/ "kuboard")（一个类似k8s Dashboard但是远强大于它的工具）
`kubectl apply -f https://kuboard.cn/install-script/kuboard.yaml
`{{execute}}
部署监控相关的(可选)
`kubectl apply -f https://addons.kuboard.cn/metrics-server/0.3.6/metrics-server.yaml
`{{execute}}

稍等片刻就会部署完成

### 获取k8s token用于登陆kuboard平台
`echo $(kubectl -n kube-system get secret $(kubectl -n kube-system get secret | grep kuboard-user | awk '{print $1}') -o go-template='{{.data.token}}' | base64 -d)
`{{execute}}

### 访问页面：(国内需要翻墙)
右边点击终端添加，选择 **SELECT PORT TO VIEW ON HOST 1**，打开后输入32567端口，会自动跳转到kuboard界面输入上面的token就可以登陆


### 添加k8s快捷命令，加快输入效率
`cat >>  ~/.bashrc << EOF
alias kg='kubectl get'
alias kc='kubectl apply -f'
alias ke='kubectl exec -it'
alias kd='kubectl describe pods'
alias kl='kubectl logs -f'
alias ktmp='kubectl run -i --tty --image busybox dns-test --restart=Never --rm /bin/sh'
EOF
source ~/.bashrc`{{execute}}

如获取pods状态
`kg pods -A`{{execute}}
`kg svc -A`{{execute}}
`kg ing -A`{{execute}}

### ubuntu安装nfs
`apt update && apt install nfs-kernel-server -y`{{execute}}

### 配置nfs

`cat >> /etc/exports << EOF
/root/nfs_root/ *(insecure,rw,sync,no_root_squash)
EOF`{{execute}}

### 启动nfs
`mkdir -p /root/nfs_root/
systemctl restart nfs-kernel-server
systemctl status nfs-kernel-server`{{execute}}

### 验证nfs
`exportfs -r
exportfs
showmount -e localhost`{{execute}}

安装和创建
https://kuboard.cn/learning/k8s-intermediate/persistent/nfs.html#%E5%9C%A8kuboard%E4%B8%AD%E5%88%9B%E5%BB%BA-nfs-%E5%AD%98%E5%82%A8%E7%B1%BB

### 安装监控
`kubectl -n kube-system create secret generic etcd-certs --from-file=/etc/kubernetes/pki/etcd/server.crt --from-file=/etc/kubernetes/pki/etcd/server.key`{{execute}}

### 安装helm
`snap install helm --classic`{{execute}}
`export PATH=/snap/bin:$PATH`{{execute}}
`helm version`{{execute}}

### 使用helm
安装源
`helm repo add stable https://kubernetes-charts.storage.googleapis.com`{{execute}}
更新
`helm repo update`{{execute}}
显示可以安装的包
`helm search repo stable`{{execute}}
安装个wordpress博客试试
`helm install stable/wordpress --generate-name`{{execute}}

### helm安装skywalking
#https://github.com/apache/skywalking-kubernetes/
git clone https://github.com/apache/skywalking-kubernetes.git
cd skywalking-kubernetes/chart
helm repo add elastic https://helm.elastic.co
helm dep up skywalking
helm install sky skywalking 

