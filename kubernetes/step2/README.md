# Step1
#### Create Deployment & Service
```bash
  kubectl apply -f deployment.yaml
```

#### IP確認
```bash
  kubectl get service
```
#### 疎通確認用の Pod を作成します。
```bash
  kubectl run <pod name> --rm -it --image=appropriate/curl --restart=Never -- sh
```

#### curl
```bash
  curl -v <service ip>:<port>
```

```bash
  curl -v <service name>
```
