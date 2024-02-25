# Dockerでいい感じのphp-fpm環境を整えるやつ

## EC2インスタンス内でビルド

インスタンス起動時に`ec2-userdata.bash`をユーザーデータとして実行しておく

ログイン後に以下のようにコマンドを実行しDockerHubにpushする
```sh
$ tmux
$ git clone https://github.com/gofer/docker-php-fpm
$ cd docker-php-fpm
$ git checkout <<branch_name/tag_name>>
$ pip3 install --no-user -t vendor -r requirements.txt
$ python3 make.py <<user>> <<base>> <<branch_name/tag_name>>
$ sh build.sh
$ sh push.sh
```

### 現在サポートしている`<<base>>`
- `debian`
- `alpine`
