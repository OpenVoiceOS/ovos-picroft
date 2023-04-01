export TERM=xterm-xfree86

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
