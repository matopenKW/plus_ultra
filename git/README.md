# 0205git、Github勉強会

## git概要
### gitとは
+ リーナス・トーバルズが作りました。 
+ バージョン管理システム
    + CVS、SVN
### gitの特徴
+ ローカルリポジトリ、リモートリポジトリ
    + [サル先生のGit入門　〜履歴を管理するリポジトリ](https://backlog.com/ja/git-tutorial/intro/02/)
    + clone
+ 主なコマンド
    + push,pull,commit

### Githubとは
+ [Github](https://github.co.jp/)

## Git操作
### 基本コマンドを覚えよう（ローカル編）
+ clone
    + ```git clone [url]```
+ branch
    + ```git branch -a```
    + ```git branch [ブランチ名] [親ブランチ]```
    + ```git branch -vv```
    + ```git branch -d [ブランチ名]```

+ checkout
    + ```git checkout -b [ブランチ名] ```

+ add / reset
    + ```git add -a```
    + ```gti reset```
+ commit
    + ```git commit```
    + ```git commit -m "[message]"```
#### 番外編　SSH接続について
+ Githubにpushするためにssh接続できる様にしよう
+ Macの場合
```
$ cd ~/.ssh

$ ssh-keygen -t rsa
```
+ Windowsの場合
```
$ mkdir ~/.ssh
$ cd ~/.ssh
$ ssh-keygen -t rsa -C '[mailaddress]'
```

+ git configを設定
    + git config user.email
    + git config user.name

### 基本コマンドを覚えよう（リモート編）
+ push
    + ```git push HEAD```
    + ```git push [ブランチ名]```

+ fetch
    + ```git fetch```

+ marge
    + ```git marge```

+ pull
    + ```git pull```

### プルリクエスト 
+ プルリクエストとは
    + [サル先生のGit入門　〜プルリクエストとは？](https://backlog.com/ja/git-tutorial/pull-request/01/)
+ プルリクエストを出してみよう

### 競合、コンクリフト
+ コンクリフトとは
+ ファイルを競合させてみよう
+ マージコミット
    + VSCodeのエディタは楽ちん

### Github困った時の対処方
+ マージミスした！前回のコミットを取り消したい！！
    + Githubの性質上、一度あげた内容を取り消すという事はしません。→ではどうするか。
    + revertコミットをしよう
    + ```git revert [commit id]```
+ よく競合が起こる…
    + 定期的にPullする様にする
    + ブランチでの修正箇所を少なくし、プルリクエストをこまめに出す
+ あげてはいけない秘匿情報のファイルをあげてしまった！
    + .gitignoreで秘匿ファイルは除外する
    + 既にあげてしまったファイルの管理対象からはずそう
        + ```git rm --cached [file name]```
+ 間違えてmainブランチにpushしてしまった！
    + 本来は権限で管理を行い、特定のブランチへのpushは防ぐもの
    + 権限管理がどうしても難しい場合はhooksを使おう！
        + ただし、git hooks はEclipceでGitを使用する場合は使用できない
+ 指定のリビジョンに戻したい…
    + rebase コマンドを使おう
        + ```git rebase [commit id]```
    + ※但し、全体への影響が大変大きいです。使うときは用法要領守る事（ってか、慣れないうちは基本的に使わない事）
+ コミットメッセージの変更方法
    + 時間の都合上エディタ上でやります。

### おまけ
#### github Actions