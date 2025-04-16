# Step1
#### Create Deployment & Service
```bash
  kubectl apply -f deployment.yaml
```

#### IP確認
```bash
  kubectl get service
```

#### curl
Localのブラウザで疎通確認
```bash
  curl -v <external ip>:<service node port>
```