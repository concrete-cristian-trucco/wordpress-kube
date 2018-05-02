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


### Criar Ingress para host: https://wordpresstrucco.com/

### Gerar os certificados.

    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=wordpresstrucco.com"
### Antes de criar o Ingress criar os secrets para o certificados.
    kubectl create secret tls secret-wordpress --key tls.key --cert tls.crt	

### Criar o Ingress

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    ingress.kubernetes.io/rewrite-target: /
    ingress.kubernetes.io/ssl-redirect: "false"
  name: my-service-ingress
spec:
  tls:
  - hosts:
    - trucco.com
    secretName: my-secret
  rules:
  - host: trucco.com
    http:
      paths:
      - path: /
        backend:
          serviceName: ingress-example-joomla
          servicePort: 80
```
˜
