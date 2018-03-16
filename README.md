# wordpress-kube

Exemplo de aplicação wordpress com mysql no cluster Kubernetes.

##### Exemplo Wordpress

Referencia: https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/

## Crie um segredo para a senha do MySQL

	kubectl create secret generic mysql-pass --from-literal=password=YOUR_PASSWORD

### Nota: Substitua YOUR_PASSWORDpela senha que deseja aplicar.


Verifique se o Secret existe executando o seguinte comando:

	kubectl get secrets

### Implante o MySQL: a partir do mysql-deployment.yamlarquivo:

	kubectl create -f mysql-deployment.yaml

### Verifique se um PersistentVolume foi provisionado dinamicamente:

	kubectl get pvc	

	kubectl get pods

### Implantar o WordPress:

  kubectl create -f wordpress-deployment.yaml

  kubectl get pvc

### Nota: pode demorar até alguns minutos para que os PVs sejam provisionados e vinculados.

Verifique se o Serviço está executando executando o seguinte comando:


    kubectl get services wordpress

### Nota: o Minikube só pode expor serviços através NodePort. 

O EXTERNAL-IPsempre é <pending>.

Pegar o Serviço pelo Minikube:

    minikube service wordpress --url




