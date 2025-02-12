# golang overview

## Golangとは
(By Github copilot)  
Golangは、Googleが開発したプログラミング言語です。  
Golangは、C言語のような低レベル言語のパフォーマンスと、Pythonのような高レベル言語の使いやすさを兼ね備えています。  
Golangは、並行処理をサポートしており、Webアプリケーションやマイクロサービスなどの開発に適しています。  

## Golangの特徴
#### 静的型付け言語
```golang
var i int = 1
i = "hello" // コンパイルエラー
```

#### コンパイル言語
インタプリタ言語と違い、コンパイルが必要

```bash
// コンパイル
$ go build main.go

// buildしたファイルを実行
// バイナリファイルが生成される
$ ./main

// コンパイルと実行
$ go run main.go
```

buildしたファイルはシングルバイナリで依存関係を含めてバイナリファイルを生成する

##### 何が嬉しいのか
- dockerが流行っている今、どれでもDeployできるというのは大きなメリット
  - dockerとの相性が良い
- マルチステージングビルドが容易
  - ex) buildしたバイナリファイルをalpineイメージにコピーする

#### ガベージコレクション
メモリ管理を自動で行う

#### 並行処理をサポート
goroutineという軽量スレッド

- 軽量スレッドとは、OSのスレッドよりも軽量で数千〜数百万のgoroutineを同時に実行できる（CPU、メモリ次第）
```golang
func main() {
    go func() {
        fmt.Println("goroutine")
    }()
    fmt.Println("main")
}

```

#### パッケージ管理ツールが標準で提供されている
go mod  
javascriptのnpmやpythonのpipに相当

#### ドキュメント
https://golang.org/doc/

#### テストが容易
```golang
func add(a, b int) int {
    return a + b
}

func TestAdd(t *testing.T) {
    if add(1, 2) != 3 {
        t.Error("1 + 2 should be 3")
    }
}
```

## マルチプラットフォーム
Windows, macOS, LinuxなどのOSで動作する
```bash
// go version go1.23.3 darwin/arm64
 % go tool dist list
aix/ppc64
android/386
android/amd64
android/arm
android/arm64
darwin/amd64
darwin/arm64
dragonfly/amd64
freebsd/386
freebsd/amd64
freebsd/arm
freebsd/arm64
freebsd/riscv64
illumos/amd64
ios/amd64
ios/arm64
js/wasm
linux/386
linux/amd64
linux/arm
linux/arm64
linux/loong64
linux/mips
linux/mips64
linux/mips64le
linux/mipsle
linux/ppc64
linux/ppc64le
linux/riscv64
linux/s390x
netbsd/386
netbsd/amd64
netbsd/arm
netbsd/arm64
openbsd/386
openbsd/amd64
openbsd/arm
openbsd/arm64
openbsd/ppc64
openbsd/riscv64
plan9/386
plan9/amd64
plan9/arm
solaris/amd64
wasip1/wasm
windows/386
windows/amd64
windows/arm
windows/arm64

```

## 他言語との比較
### panic/recover
- panic: プログラムを停止させる
- JavaのRuntimeExceptionと似たようなもの
- recover: panicを捕捉する -> try-catchに近い

```golang
func main() {
	// defer -> 関数の最後に実行される
    defer func() {
        if err := recover(); err != nil {
            fmt.Println("recovered", err)
        }
    }()
    panic("panic")
}
```

### ポインタ
C言語と同じようにポインタを扱うことができる  
ポインタはメモリアドレスを格納する変数のこと

```golang

func main() {
    var i int = 1
    var p *int = &i
    fmt.Println(*p) // 1
}
```
- 他のポインタ、参照型との違いは？
  - Javaの参照型は、メモリアドレスを直接操作することができない
  - Cのポインタほど、メモリアドレスを直接操作することができない（俗にいうポイント算術）

### private/public
- public: 先頭大文字で始まる変数、関数
- private: 先頭小文字で始まる変数、関数

```golang
// 大文字で始まるので、public
func PublicFunc() { // <- 他のパッケージから呼び出せる
    fmt.Println("public")
}

// 小文字で始まるので、private
func privateFunc() { // <- private functionは他のパッケージから呼び出せない
    fmt.Println("private")
}

type PublicStruct struct { // <- 他のパッケージから呼び出せる
    Name string <- 他のパッケージから呼び出せる
}

type privateStruct struct { // <- 他のパッケージから呼び出せない
    name string // <- 他のパッケージから呼び出せない
}

```


### オブジェクト指向との関係
- オブジェクト指向言語ではない
- インターフェースを使って、オブジェクト指向の特徴を実現する
  - ポリモーフィズム
- カプセル化は可能
  - プライベート変数、メソッドを定義することができる
  - だけど、あまりやらない。 <- オブジェクト指向言語ではないため
- 継承はできない
  - インターフェースはあるのでDIは可能

## まとめ
- 実行速度が速い
- 並行処理が得意
- マルチプラットフォーム

## 私の思うGoの良いところ
- 書きやすい
- 無駄が少ない
- ある程度の書き方はアーキテクチャで強制することができる
- テストがしやすい