oc create ns jousley
oc project jousley
oc new-app https://github.com/jousley/s2i-hello.git --name=nginx-hello

sleep 5

oc patch service nginx-hello -n jousley --type='json' -p='[
  {
    "op": "replace",
    "path": "/spec/ports/0/port",
    "value": 80
  },
  {
    "op": "replace",
    "path": "/spec/ports/0/name",
    "value": "80-tcp"
  }
]'

oc expose svc nginx-hello

oc get route
