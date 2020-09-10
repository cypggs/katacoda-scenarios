>author:cypggs  
>mail:qcypggs@qq.com
>github:https://github.com/cypggs/katacoda-scenarios
>describe:学习k8s实验室
>belief:计算机科学毕竟是一门实践性的科学，动手实操才是学习的捷径！

![Pandao editor.md](https://pandao.github.io/editor.md/images/logos/editormd-logo-180x180.png "Pandao editor.md")
[http://www.mdeditor.com/](http://www.mdeditor.com/)

### 检查 Kubernetes 集群

使用前，检查 Kubernetes 集群状态：`kubectl cluster-info`{{execute}}

### 部署[kuboard](https://kuboard.cn/ "kuboard")（一个类似k8s Dashboard但是远强大于它的工具）
`kubectl apply -f https://kuboard.cn/install-script/kuboard.yaml
`{{execute}}
部署监控相关的(可选)
`kubectl apply -f https://addons.kuboard.cn/metrics-server/0.3.6/metrics-server.yaml
`{{execute}}

稍等片刻就会部署完成^_^

### 获取k8s token用于登陆kuboard平台
`echo $(kubectl -n kube-system get secret $(kubectl -n kube-system get secret | grep kuboard-user | awk '{print $1}') -o go-template='{{.data.token}}' | base64 -d)
`{{execute}}

### 访问页面：(国内需要翻墙)
右边点击终端添加，选择 **SELECT PORT TO VIEW ON HOST 1**，打开后输入32567端口，会自动跳转到kuboard界面输入上面的token就可以登陆
or 访问
https://[[HOST_SUBDOMAIN]]-32567-[[KATACODA_HOST]].environments.katacoda.com/

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
### 让master也当node调度
`kubectl taint node controlplane node-role.kubernetes.io/master-`{{execute}}

### ubuntu安装nfs
`apt update && apt install nfs-kernel-server -y`{{execute}}

### 配置nfs

`cat >> /etc/exports << EOF
/data/nfs_client *(rw,sync,no_root_squash,no_subtree_check)
EOF`{{execute}}

### 启动nfs
`mkdir -p /data/nfs_client/
chmod -R 777 /data/nfs_client
/etc/init.d/rpcbind restart
/etc/init.d/nfs-kernel-server restart
systemctl status nfs-kernel-server`{{execute}}
`^C`{{execute ctrl-seq}}
### 验证nfs
`exportfs -r
exportfs
showmount -e localhost
mount -vvv -t nfs localhost:/data/nfs_client /mnt`{{execute}}

### 安装 storageclass
`HOST_IP=$(ifconfig ens3 |grep "inet addr"|cut -d: -f2|awk '{print $1}')`{{execute}}

`wget https://raw.githubusercontent.com/cypggs/katacoda-scenarios/master/StorageClass-nfs.yaml && sed "s/NFS_IP/${HOST_IP}/g" StorageClass-nfs.yaml |kubectl  apply -f - --record=true`{{execute}}

`sed -i "s/NFS_IP/${HOST_IP}/g" StorageClass-nfs.yaml`{{execute}}
###安装ocp-spring-cloud系统
`kubectl create ns ocp
kubectl apply -f https://raw.githubusercontent.com/cypggs/katacoda-scenarios/master/ocp.yaml`{{execute}}

### 安装reids-sts

`kubectl apply -f https://raw.githubusercontent.com/cypggs/katacoda-scenarios/master/redis-sts.yaml`{{execute}}
# 登陆其中一台reids
`kubectl exec -it redis-0 -- bash`{{execute}}
# 建立集群
`redis-trib.rb create --replicas 1 \
\`dig +short redis-0.redis-headless.default.svc.cluster.local\`:6379 \
\`dig +short redis-1.redis-headless.default.svc.cluster.local\`:6379 \
\`dig +short redis-2.redis-headless.default.svc.cluster.local\`:6379 \
\`dig +short redis-3.redis-headless.default.svc.cluster.local\`:6379 \
\`dig +short redis-4.redis-headless.default.svc.cluster.local\`:6379 \
\`dig +short redis-5.redis-headless.default.svc.cluster.local\`:6379`{{execute}}
安装和创建
https://kuboard.cn/learning/k8s-intermediate/persistent/nfs.html#%E5%9C%A8kuboard%E4%B8%AD%E5%88%9B%E5%BB%BA-nfs-%E5%AD%98%E5%82%A8%E7%B1%BB

### 安装监控
`kubectl -n kube-system create secret generic etcd-certs --from-file=/etc/kubernetes/pki/etcd/server.crt --from-file=/etc/kubernetes/pki/etcd/server.key`{{execute}}

### 安装helm3
`snap install helm --classic
export PATH=/snap/bin:$PATH
helm version
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo update
helm search repo stable`{{execute}}

安装个wordpress博客试试
`helm install stable/wordpress --generate-name`{{execute}}

### helm安装skywalking
#https://github.com/apache/skywalking-kubernetes/
`git clone https://github.com/apache/skywalking-kubernetes.git
cd skywalking-kubernetes/chart
helm repo add elastic https://helm.elastic.co
helm dep up skywalking
helm install sky skywalking`{{execute}}
###harbor
`helm repo add harbor https://helm.goharbor.io
helm install harbor harbor/harbor --set persistence.persistentVolumeClaim.registry.storageClass=nfs-client --set persistence.persistentVolumeClaim.chartmuseum.storageClass=nfs-client --set persistence.persistentVolumeClaim.jobservice.storageClass=nfs-client --set persistence.persistentVolumeClaim.database.storageClass=nfs-client --set persistence.persistentVolumeClaim.redis.storageClass=nfs-client --set persistence.persistentVolumeClaim.trivy.storageClass=nfs-client``{{execute}}
