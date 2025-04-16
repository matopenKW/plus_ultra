# Step1
#### Create Pod
```bash
  kubectl apply -f pod.yaml
```
#### IP確認
```bash
  kubectl get pod -o wide | grep <pod name>
```
#### 疎通確認用の Pod を作成します。
```bash
  kubectl run hoge --rm -it --image=appropriate/curl --restart=Never -- sh
```

#### curl
```bash
  curl -v <pod ip>:<port>
```