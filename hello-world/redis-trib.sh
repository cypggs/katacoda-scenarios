redis-trib.rb create --replicas 1 \
`dig +short redis-0.redis-headless.default.svc.cluster.local`:6379 \
`dig +short redis-1.redis-headless.default.svc.cluster.local`:6379 \
`dig +short redis-2.redis-headless.default.svc.cluster.local`:6379 \
`dig +short redis-3.redis-headless.default.svc.cluster.local`:6379 \
`dig +short redis-4.redis-headless.default.svc.cluster.local`:6379 \
`dig +short redis-5.redis-headless.default.svc.cluster.local`:6379
