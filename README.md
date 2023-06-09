# synology-make-px4_drv

> Synology NAS用のpx4_drvをコンパイルする

## 実行手順
### 1. rootユーザーに昇格する
```
sudo -i
```

### 2. Gitリポジトリを取得する
```
git clone https://github.com/collelog/synology-make-px4_drv.git
```

### 3. Dockerイメージをビルドする
```
docker build -t collelog/syno-make-px4_drv -f [DSMバージョン]-[CPUパッケージアーキテクチャ].Dockerfile .
```
※Synology NASのCPUパッケージアーキテクチャは[Synology KB](https://kb.synology.com/ja-jp/DSM/tutorial/What_kind_of_CPU_does_my_NAS_have)で確認してください。
イメージビルド時に指定されたCPU用のクロスコンパイルツールチェインを含む親Dockerイメージ:[collelog/dsmpkg-env](https://hub.docker.com/r/collelog/dsmpkg-env)がDockerHubからダウンロードされます。

### 4. Dockerコンテナを実行する
```
docker run --rm --name syno-make-px4_drv -v [出力先(ホスト側フルパス)]:/build_env/toolkit/results_file/px4_drv -i -d collelog/syno-make-px4_drv
```

### 5. 出力先に以下のファイルが格納される
```
it930x-firmware.bin
px4_drv.ko
```


## ライセンス
このソースコードは [MIT License](https://github.com/collelog/speedtest-exporter/blob/master/LICENSE) のもとでリリースされています。
