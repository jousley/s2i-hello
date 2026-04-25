oc create ns jousley
oc project jousley
oc new-app https://github.com/jousley/s2i-hello.git --name=nginx-hello

sleep 5

oc expose svc nginx-hello

oc get route
