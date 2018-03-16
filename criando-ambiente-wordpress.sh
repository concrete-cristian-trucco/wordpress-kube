#!/bin/bash
#Execute o seguinte comando para excluir o seu segredo:

#echo "removendo secret mysql exemplo"
#kubectl delete secret mysql-pass

#Execute os seguintes comandos para excluir todas as implantações e serviços:

#sleep 2

#echo "removendo deployment e service Mysql exemplo"
#kubectl delete deployment -l app=wordpress
#kubectl delete service -l app=wordpress


#echo "excluir o PersistentVolumeClaims"

#kubectl delete pvc -l app=wordpress

echo "Gravar o nome do Serviço"
read -p "Digite o Nome do Secrete - depois aperte <Enter> para finalizar : "  YOUR_PASSWORD
kubectl create secret generic mysql-pass --from-literal=password="value=$YOUR_PASSWORD" #1&> /dev/null 2&> /dev/null

kubectl create -f deploy-wordpress-mysql.yaml

echo "verificando serviços"
kubectl get svc,pods,deploy
