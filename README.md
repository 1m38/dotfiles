自分的dotfiles設定まとめ  
参考: http://qiita.com/himinato/items/7f5461814e8ed8916870

# init
```
git clone git@bitbucket.org:fs_lt34/dotfiles.git ~/dotfiles
sh dotfiles/link.sh
```

## ssh-agentに文句を言われた場合
  .sshフォルダのパーミッションを700に
  秘密鍵ファイルのパーミッションを600に
  dotfiles/sshconfig のパーミッションを700に