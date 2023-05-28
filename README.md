# synology-make-px4_drv

> Compile px4_drv for Synology NAS

## 実行手順
### 1.Gitリポジトリの取得
```
sudo git clone https://github.com/collelog/synology-make-px4_drv.git
```

### 2.Dockerイメージのビルド
```
docker build -t collelog/syno-make-px4_drv -f [DSMバージョン]-[CPUパッケージアーチ].Dockerfile .
```
※SynologyNASのCPUパッケージアーチは[Synology KB](https://kb.synology.com/ja-jp/DSM/tutorial/What_kind_of_CPU_does_my_NAS_have)で確認してください。
イメージビルド時に指定されたCPU用のクロスコンパイルツールチェインを含む親Dockerイメージ:[collelog/dsmpkg-env](https://hub.docker.com/r/collelog/dsmpkg-env)をDockerHubからダウンロードします。

### 3.Dockerコンテナの実行
```
docker run --rm --name syno-make-px4_drv -v [出力先(ホスト側フルパス)]:/build_env/toolkit/results_file/px4_drv -i -d collelog/syno-make-px4_drv
```

## License
このソースコードは [MIT License](https://github.com/collelog/speedtest-exporter/blob/master/LICENSE) のもとでリリースします。
