#!/bin/bash
#Execute o seguinte comando para excluir o seu segredo:

SERVICE="mysql-pass"
LABEL_APP="app=wordpress"
VERIFICA="kubectl get svc,pods,deploy,pvc $LABEL_APP"

echo "removendo secret mysql exemplo"
kubectl delete secret $SERVICE

#Execute os seguintes comandos para excluir todas as implantações e serviços:

sleep 2

echo "removendo deployment e service Mysql exemplo"
kubectl delete deployment -l $LABEL_APP
kubectl delete service -l $LABEL_APP


echo "excluir o PersistentVolumeClaims"

kubectl delete pvc -l $LABEL_APP

echo "verificando exclusao dos serviços e pods"

$VERIFICA
