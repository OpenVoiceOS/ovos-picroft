export TERM=xterm-xfree86
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

case :$PATH: in
  */home/ovos/.local/bin:*) ;;
  *) PATH=/home/ovos/.local/bin:$PATH ;;
esac

if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
