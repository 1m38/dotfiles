# gxp3 をパスに追加
set -x PATH $HOME/gxp3 $PATH
set -x GXP_ON 1

# alias
alias e 'gxpc e'
alias ep 'gxpc ep'
alias ecd 'gxpc cd'
alias smask 'gxpc smask'
alias rmask 'gxpc rmask'
alias explore 'gxpc explore'
alias quit 'set -x GXP_ON; and gxpc quit'

# 手元と daemon のディレクトリを同時に変更
function scd
    gxpc cd $argv
    cd $argv
end

# from http://www.logos.ic.i.u-tokyo.ac.jp/~s1s5/program/shell_commands
# 前の gxp コマンドが成功/失敗したホストの一覧を出力
function ghosts
    
    if [ ""$argv == '-s' ]; then
        gxpc pushmask
        gxpc smask
        gxpc ping
        gxpc popmask
        gxpc ping > /dev/null
    else if [ ""$argv == '-f' ];then
        gxpc pushmask
        gxpc smask -
        gxpc ping
        gxpc popmask
        gxpc ping > /dev/null
    else
        echo "Unknown option $argv"
        echo "-s : "
        echo "-f : "
    end
end


# これより上は gxp3 の一般の設定
# .zshrc に書いておいてもよい

# ここから下は basil 用の設定
# T2K や InTrigger で使う場合には適宜変更
gxpc use ssh (hostname) basil
