# Step1
#### Create Deployment & Service
```bash
  kubectl apply -f deployment.yaml
```

#### ReplicaSetを引き上げる
```bash
  kubectl scale deployment <deployment name> --replicas=3
```
または
```bash
  kubectl patch deployment <deployment name> -p '{"spec":{"replicas":3}}'
```

#### curl
Localのブラウザで疎通確認
```bash
  curl -v <external ip>:<service node port>
```