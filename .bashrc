
# 查看终端支持的颜色
# > tput colors
# 查看终端类型
# > echo $TERM

if [ "$TERM" == "xterm" ]; then
  export TERM=xterm-256color
fi
