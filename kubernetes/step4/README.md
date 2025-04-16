# Step1
#### Create Deployment & Service
```bash
  kubectl apply -f deployment.yaml
```

#### Port確認
```bash
  kubectl get svc -n ingress-nginx
```

#### curl
Localのブラウザで疎通確認
```bash
  curl -v <external ip>:<ingress port>/<path>
```