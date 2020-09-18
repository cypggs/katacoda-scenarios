cat >>  ~/.bashrc << EOF
alias kg='kubectl get'
alias kc='kubectl apply -f'
alias ke='kubectl exec -it'
alias kd='kubectl describe'
alias kdp='kubectl describe pods'
alias kl='kubectl logs -f'
alias ktmp='kubectl run -i --tty --image busybox dns-test --restart=Never --rm /bin/sh'
EOF
source ~/.bashrc
