### Roteiro a ser usado na sprint

#### Exemplo usando o Traefik no Minikube.


    cd /Users/cristiantrucco/wordpress-kube


### Setup do Traefik

```console

   kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-rbac.yaml\n
   kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-deployment.yaml\n
   kubectl --namespace=kube-system get pods\n

```

#### Dashboard do Ingress

	  http://192.168.99.100:30950/dashboard/#/


### Rodar script para automátiza setup do Wordpress

#### Criar os certificados com Openssl.

    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=wordpresstrucco.com"	


#### Criar o secrets que usará os certificados criados.

  	kubectl create secret tls secret-wordpress --key tls.key --cert tls.crt	


#### Criar o Ingress do Wordpress


  	kubectl apply -f wordpress-ingress.yaml


```

 apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    ingress.kubernetes.io/rewrite-target: /
    ingress.kubernetes.io/ssl-redirect: "true"
  name: my-wordpress-ingress
spec:
  tls:
  - hosts:
    - wordpresstrucco.com
    secretName: secret-wordpress
  rules:
  - host: wordpresstrucco.com
    http:
      paths:
      - path: /
        backend:
          serviceName: wordpress
          servicePort: 80

```

### Verificando o objeto criado

```
kubectl get ing
```
```console
NAME                   HOSTS                 ADDRESS          PORTS     AGE
my-wordpress-ingress   wordpresstrucco.com   192.168.99.100   80, 443   53m

```
