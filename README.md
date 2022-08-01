# Severの終了方法
起動しているプロセスを探して停止してください。  
プロセスの例
```
python3 server.py
```

# RAMディスクを使ったストリームデータ保存
SDカードの寿命を気にするなら/etc/fsstabにRAMディスクを作成した記述を書いてシンボリックリンクでwww下にstreamディレクトリとしてリンクを張ります。  

##例  
```
tmpfs   /tmp/stream     tmpfs   defaults,size=16m       0       0
```

##シンボリックリンク
```
cd www
ln -s /tmp/stream/ stream 
```