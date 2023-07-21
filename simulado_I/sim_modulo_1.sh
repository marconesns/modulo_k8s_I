#!/bin/bash

Q01images="nginx"
Q01name="nginx-pod"
Q02images="redis"
Q02name="curso"
Q03namespace=cka-0001
Q04file=/tmp/nodes.json
Q06deploy=dp-web-app
Q06images=marconesns/dogpic-service:0.1.0
Q07images=busybox
Q07name=static-pod
Q08name=recebiveis
Q08namespace=finance
Q09name=termination-demo
Q09namespace=blue
Q11file=/tmp/nodes_os_images.txt
Q12name=pv-analytics
Q12path=/pv/data-analytics

start(){
    if [ ! "$(kubectl get ns $Q08namespace 2> /dev/null)" ]
    then
        kubectl create ns $Q08namespace 2> /dev/null        
    fi

    if [ ! "$(kubectl get ns blue 2> /dev/null)" ]
    then
        kubectl create ns blue 2>&1 > /dev/null
        kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: termination-demo
  namespace: blue
spec:
  containers:
  - command:
    - sh
    - -c
    - echo The app is running! && sleep 3600
    image: busybox
    imagePullPolicy: IfNotPresent
    name: look-at-me-container
  initContainers:
  - name: termination-demo-container
    image: debian
  - command:
    - sh
    - -c
    - sleeeep 2;
    image: busybox
    imagePullPolicy: Always
    name: init-myservice
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
EOF
    fi
}

finish(){
    if [ "$(kubectl get ns "$Q08namespace" 2> /dev/null)" ]
    then
        kubectl delete ns "$Q08namespace"
    fi
     if [ "$(kubectl get ns blue 2> /dev/null)" ]
    then
        kubectl delete ns blue
    fi
    if [ "$(kubectl get pods "$Q01name" 2> /dev/null)" ]
    then
        kubectl delete pod "$Q01name" 2> /dev/null
    fi
    if [ "$(kubectl get pods "$Q02name" 2> /dev/null)" ]
    then
        kubectl delete pod "$Q02name" 2> /dev/null
    fi
    if [ "$(kubectl get ns "$Q03namespace" 2> /dev/null)" ]
    then
        kubectl delete ns "$Q03namespace" 2> /dev/null
    fi
    if [ -e "$Q04file" ]
    then
        rm -f "$Q04file" 2> /dev/null
    fi
    if [ "$(kubectl get svc "$Q02name"-service 2> /dev/null)" ]
    then
        kubectl delete svc "$Q02name"-service 2> /dev/null
    fi
    if [ "$(kubectl get deployment "$Q06deploy" 2> /dev/null)" ]
    then
        kubectl delete deployment "$Q06deploy" 2> /dev/null
    fi
    if [ "$(kubectl get svc "$Q06deploy"-service 2> /dev/null)" ]
    then
        kubectl delete svc "$Q06deploy"-service 2> /dev/null
    fi
    if [ -e "$Q11file" ]
    then
        rm -f "$Q11file" 2> /dev/null
    fi
    if [ "$(kubectl get pv "$Q12name" 2> /dev/null)" ]
    then
        kubectl delete pv "$Q12name" 2> /dev/null
    fi
}

verifica() {
Q01e=$(kubectl get pod $Q01name -n default 2> /dev/null)
Q01r=$(kubectl get pod $Q01name -n default -o jsonpath='{.status.phase}' 2> /dev/null)
Q01i=$(kubectl get pod $Q01name -n default -o jsonpath='{.spec.containers[*].image}' 2> /dev/null)
if [ -n "$Q01e" -a "$Q01r" = "Running" -a "$Q01i" = "$Q01images:alpine" ]
then
    echo -e "Questão 01    -   \e[1;32m Pass \e[0m"
else
    echo -e "Questão 01    -   \e[1;31m Fail \e[0m"
fi

Q02e=$(kubectl get pod $Q02name -n default 2> /dev/null)
Q02r=$(kubectl get pod $Q02name -n default -o jsonpath='{.status.phase}' 2> /dev/null)
Q02i=$(kubectl get pod $Q02name -n default -o jsonpath='{.spec.containers[*].image}' 2> /dev/null)
Q02l=$(kubectl get pod $Q02name -n default -o jsonpath='{.metadata.labels.tier}' 2> /dev/null)
if [ -n "$Q02e" -a "$Q02r" = "Running" -a "$Q02i" = "$Q02images:alpine" -a "$Q02l" = "msg" ]
then
    echo -e "Questão 02    -   \e[1;32m Pass \e[0m"
else
    echo -e "Questão 02    -   \e[1;31m Fail \e[0m"
fi

Q03e=$(kubectl get ns $Q03namespace 2> /dev/null)
if [ -n "$Q03e" ]
then
    echo -e "Questão 03    -   \e[1;32m Pass \e[0m"
else
    echo -e "Questão 03    -   \e[1;31m Fail \e[0m"
fi

if [ -e "$Q04file" ]
then
    FILETYPE=$(file $Q04file | grep "JSON data" 2> /dev/null)
    echo -e "Questão 04    -   \e[1;32m Pass \e[0m"
else
    echo -e "Questão 04    -   \e[1;31m Fail \e[0m"
fi    

Q05e=$(kubectl get svc $Q02name-service 2> /dev/null)
Q05p=$(kubectl get svc $Q02name-service -o jsonpath="{.spec.ports[*].port}" 2> /dev/null)
Q05s=$(kubectl get svc $Q02name-service -o jsonpath="{.spec.selector.tier}" 2> /dev/null)
Q05t=$(kubectl get svc $Q02name-service -o jsonpath="{.spec.type}" 2> /dev/null)
if [ -n "$Q05e" -a "$Q05p" = "6379" -a "$Q05t" = "ClusterIP" -a "$Q05s" = "msg" ]
then
    echo -e "Questão 05    -   \e[1;32m Pass \e[0m"
else
    echo -e "Questão 05    -   \e[1;31m Fail \e[0m"
fi

Q06e=$(kubectl get deployment $Q06deploy 2> /dev/null)
Q06i=$(kubectl get deployment $Q06deploy -o jsonpath="{.spec.template.spec.containers[*].image}" 2> /dev/null)
Q06r=$(kubectl get deployment $Q06deploy -o jsonpath="{.spec.replicas}" 2> /dev/null)
if [ -n "$Q06e" -a "$Q06i" = "$Q06images" -a "$Q06r" -eq 2 ]
then
    echo -e "Questão 06    -   \e[1;32m Pass \e[0m"
else
    echo -e "Questão 06    -   \e[1;31m Fail \e[0m"
fi

Q07e=$(kubectl get pod | grep $Q07name | cut -d " " -f1 2> /dev/null)
Q07c=$(kubectl get pod $Q07e -o jsonpath="{.spec.containers[*].command}" | grep sleep 2> /dev/null)
Q07i=$(kubectl get pod $Q07e -o jsonpath="{.spec.containers[*].image}" 2> /dev/null)
if [ -n $Q07e -a $Q07c = '["sleep","1000"]' -a $Q07i = "$Q07images" ]
then
    echo -e "Questão 07    -   \e[1;32m Pass \e[0m"
else
    echo -e "Questão 07    -   \e[1;31m Fail \e[0m"
fi  

Q08e=$(kubectl get pod $Q08name -n $Q08namespace 2> /dev/null)
Q08r=$(kubectl get pod $Q08name -n $Q08namespace -o jsonpath='{.status.phase}' 2> /dev/null)
Q08i=$(kubectl get pod $Q08name -n $Q08namespace -o jsonpath='{.spec.containers[*].image}' 2> /dev/null)
if [ -n "$Q08e" -a "$Q08r" = "Running" -a "$Q08i" = "$Q02images:alpine" ]
then
    echo -e "Questão 08    -   \e[1;32m Pass \e[0m"
else
    echo -e "Questão 08    -   \e[1;31m Fail \e[0m"
fi

Q09e=$(kubectl get pod $Q09name -n $Q09namespace 2> /dev/null)
Q09r=$(kubectl get pod $Q09name -n $Q09namespace -o jsonpath='{.status.phase}' 2> /dev/null)
if [ -n "$Q09e" -a "$Q09r" = "Running" ]
then
    echo -e "Questão 09    -   \e[1;32m Pass \e[0m"
else
    echo -e "Questão 09    -   \e[1;31m Fail \e[0m"
fi

Q10e=$(kubectl get svc $Q06deploy-service 2> /dev/null)
Q10p=$(kubectl get svc $Q06deploy-service -o jsonpath="{.spec.ports[*].port}" 2> /dev/null)
Q10np=$(kubectl get svc $Q06deploy-service -o jsonpath="{.spec.ports[*].nodePort}" 2> /dev/null)
Q10t=$(kubectl get svc $Q06deploy-service -o jsonpath="{.spec.type}" 2> /dev/null)
if [ -n "$Q10e" -a "$Q10p" = "8080" -a "$Q10np" = "30002" -a "$Q10t" = "NodePort" ]
then
    echo -e "Questão 10    -   \e[1;32m Pass \e[0m"
else
    echo -e "Questão 10    -   \e[1;31m Fail \e[0m"
fi

Q11e=$(grep Ubuntu $Q11file 2> /dev/null)
if [ -e "$Q11file" -a -n "$Q11e" ]
then
    echo -e "Questão 11    -   \e[1;32m Pass \e[0m"
else
    echo -e "Questão 11    -   \e[1;31m Fail \e[0m"
fi

Q12e=$(kubectl get pv $Q12name 2> /dev/null)
Q12c=$(kubectl get pv $Q12name -o jsonpath='{.spec.capacity.storage}' 2> /dev/null)
Q12p=$(kubectl get pv $Q12name -o jsonpath='{.spec.hostPath.path}' 2> /dev/null)
Q12a=$(kubectl get pv $Q12name -o jsonpath='{.spec.accessModes}' 2> /dev/null)
if [ -n "$Q12e" -a "$Q12c" = "100Mi" -a "$Q12p" = "$Q12path" -a "$Q12a" = '["ReadWriteMany"]' ]
then
    echo -e "Questão 12    -   \e[1;32m Pass \e[0m"
else
    echo -e "Questão 12    -   \e[1;31m Fail \e[0m"
fi
}

case $1 in
start)
    start;;
finish)
    finish;;    
verifica)
    verifica;;
*)
    echo "Digite $0 [start or finish]";;
esac    
