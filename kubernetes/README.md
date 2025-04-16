# Kubernetes
## Kubernetesとは
Kubernetes（k8s）は、コンテナ化されたアプリケーションのデプロイ、スケーリング、管理を自動化するためのオープンソースのプラットフォームです。Googleが開発し、Cloud Native Computing Foundation（CNCF）が管理しています。
Kubernetesは、コンテナオーケストレーションの標準として広く採用されており、マイクロサービスアーキテクチャを採用したアプリケーションの管理に特に適しています。

## Kubernetesの特徴
- **自己修復機能**: 障害が発生したコンテナを自動的に再起動、再スケジュール、または置き換えます。
- **サービスディスカバリとロードバランシング**: コンテナ間の通信を容易にし、トラフィックを分散します。
- **自動スケーリング**: トラフィックの変動に応じて、コンテナの数を自動的に増減します。
- **ストレージオーケストレーション**: ローカルストレージ、クラウドストレージ、ネットワークストレージなど、さまざまなストレージシステムを統合します。
- **宣言的な構成**: YAMLファイルを使用して、アプリケーションの状態を定義し、Kubernetesがその状態を維持します。
- **ロールアウトとロールバック**: アプリケーションの新しいバージョンをデプロイし、問題が発生した場合は簡単に以前のバージョンに戻すことができます。
- **IaC（Infrastructure as Code）**: YAMLファイルを使用して、インフラストラクチャをコードとして管理します。これにより、バージョン管理や自動化が容易になります。

### クラウドサービスとの差別化
コンテナを管理するためのクラウドサービス（例: AWS ECS、Google Cloud Run、Azure Container Instances）とKubernetesの違いは、以下の点にあります。
- **オープンソース**: Kubernetesはオープンソースであり、さまざまなクラウドプロバイダーやオンプレミス環境で実行できます。これにより、ベンダーロックインを回避できます。
- **柔軟性**: Kubernetesは、さまざまなコンテナランタイム（Docker、containerdなど）やストレージソリューションと統合できます。これにより、特定のニーズに合わせたカスタマイズが可能です。

### Kubernetesのデメリット
- **学習コスト**: Kubernetesは非常に多機能であり、初めて使用する際には学習曲線が急です。特に、YAMLファイルの記述やリソースの管理方法を理解する必要があります。
- **運用コスト**: Kubernetesは複雑なシステムであり、運用やトラブルシューティングには専門的な知識が必要です。特に、クラスタの監視やメンテナンスが重要です。
- **お値段**: Kubernetesを自分で運用する場合、インフラストラクチャのコストがかかります。特に、複数のノードを使用する場合は、クラウドプロバイダーの料金が発生します。

## Kubernetesのアーキテクチャ
Kubernetesは、以下の主要なコンポーネントで構成されています。

## FYI
- https://news.mynavi.jp/techplus/article/techp4358/

### マスターコンポーネント
- **APIサーバー**: Kubernetesのすべての操作はAPIサーバーを介して行われます。クライアントからのリクエストを受け取り、他のコンポーネントと通信します。
- **スケジューラー**: 新しいポッドをどのノードに配置するかを決定します。リソースの使用状況やポリシーに基づいて最適なノードを選択します。
- **コントローラーマネージャー**: クラスタの状態を監視し、必要に応じてリソースを作成、更新、削除します。例えば、レプリケーションコントローラーやノードコントローラーなどがあります。
- **etcd**: Kubernetesの状態を保存する分散キー・バリューストアです。クラスタの設定や状態情報を永続的に保存します。
- **Cloud Controller Manager**: クラウドプロバイダーとの統合を管理します。クラウドサービスのAPIと連携し、Kubernetesのリソースをクラウド環境に適応させます。
- **Scheduler**: 新しいポッドをどのノードに配置するかを決定します。リソースの使用状況やポリシーに基づいて最適なノードを選択します。

### ワーカーノードコンポーネント
- **kubelet**: 各ノードで実行されるエージェントで、ポッドの状態を監視し、APIサーバーと通信します。ポッドのライフサイクルを管理します。
- **kube-proxy**: ノード上で実行されるネットワークプロキシで、サービスのロードバランシングを提供します。クライアントからのリクエストを適切なポッドにルーティングします。
- **コンテナランタイム**: Dockerやcontainerdなど、コンテナを実行するためのソフトウェアです。Kubernetesは、さまざまなコンテナランタイムをサポートしています。

## Kubernetesのリソース
Kubernetesは、さまざまなリソースを使用してアプリケーションを管理します。以下は、主要なリソースの概要です。

### Pod(ポッド)
Kubernetesの最小単位であり、1つ以上のコンテナを含む論理的なホストです。
Pod内のコンテナは、同じネットワーク名前空間を共有し、相互に通信できます。
アプリケーションのデプロイメントやスケーリングの基本単位として使用されます。
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
    containers:
        - name: my-container
          image: nginx
          ports:
            - containerPort: 80
          env:  
            - name: MY_ENV_VAR
              value: "Hello, Kubernetes!"
          volumeMounts:
            - name: my-volume
              mountPath: /data
        - name: my-sidecar
          image: busybox
          command: ["sh", "-c", "while true; do echo hello; sleep 10; done"]
          volumeMounts:
            - name: my-volume
              mountPath: /data
    volumes:
          - name: my-volume
            emptyDir: {}  
```

### Service(サービス)
Podの集合に対する永続的なIPアドレスとDNS名を提供します。
Podのライフサイクルに依存せず、安定したエンドポイントを提供します。
Podのロードバランシングやサービスディスカバリを実現します。

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: ClusterIP
  selector:
    app: my-app
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080
```

typeによって、以下の4つのサービスタイプがあります。
- **ClusterIP**: クラスタ内でのみアクセス可能なIPアドレスを提供します。デフォルトのタイプです。
- **NodePort**: 各ノードのIPアドレスと指定したポートでアクセス可能なサービスを提供します。外部からのアクセスが可能です。
- **LoadBalancer**: クラウドプロバイダーのロードバランサーを使用して、外部からアクセス可能なIPアドレスを提供します。
- **ExternalName**: 外部のDNS名を使用して、サービスを参照します。Kubernetesのリソースではなく、外部のリソースを指すために使用されます。

### Deployment(デプロイメント)
Podのレプリカを管理し、アプリケーションのバージョン管理やロールアウト、ロールバックを行います。
Deploymentを使用することで、アプリケーションの状態を宣言的に定義し、Kubernetesがその状態を維持します。

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: nginx
          image: nginx:1.25
          ports:
            - containerPort: 80
```

### ReplicaSet(レプリカセット)
ReplicaSetは、指定された数のPodのレプリカを維持するためのリソースです。
DeploymentはReplicaSetを使用して、Podの数を管理します。
Podのスケーリングや障害時の自動復旧を実現します。

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: my-replicaset
spec:
    replicas: 3
    selector:
        matchLabels:
        app: my-app
    template:
        metadata:
        labels:
            app: my-app
        spec:
        containers:
            - name: nginx
              image: nginx:1.25
              ports:
                - containerPort: 80
```

## Command
### kubectl
k8sのほとんどの操作を行う

#### get
- `kubectl get <リソースタイプ>`: リソースの一覧を表示します。

example:
```bash
  kubectl get pods
```

#### describe
- `kubectl describe <リソースタイプ> <リソース名>`: リソースの詳細情報を表示します。

example:
```bash
  kubectl describe pod my-pod
```

#### apply
- `kubectl apply -f <YAMLファイル>`: YAMLファイルを使用してリソースを作成または更新します。
```bash
  kubectl apply -f my-deployment.yaml
```

##### FYI
EOF使うとちょい楽です。
```bash
  kubectl apply -f - <<EOF
> apiVersion: v1
> kind: Service
> metadata:
>   name: my-service
> spec:
>   type: ClusterIP
>   selector:
>     app: my-app
>   ports:
>     - port: 80
>       targetPort: 80
>       nodePort: 30080
> EOF
```

#### delete
- `kubectl delete <リソースタイプ> <リソース名>`: 指定したリソースを削除します。

```bash
  kubectl delete pod my-pod
```

#### logs
- `kubectl logs <ポッド名>`: 指定したポッドのログを表示します。

```bash
  kubectl logs my-pod
```

#### exec
- `kubectl exec -it <ポッド名> -- <コマンド>`: 指定したポッド内でコマンドを実行します。

```bash
  kubectl exec -it my-pod -- /bin/sh
```

#### edit/patch
- `kubectl edit <リソースタイプ> <リソース名>`: リソースを直接編集します。エディタが開き、YAML形式で編集できます。
```bash
  kubectl edit deployment my-deployment
```

- `kubectl patch <リソースタイプ> <リソース名> --type=<パッチタイプ> -p '<パッチ内容>'`: リソースを部分的に更新します。`--type`には`strategic`、`json`、`merge`などが指定できます。

```bash
  kubectl patch deployment my-deployment -p '{"spec":{"replicas":2}}'
```