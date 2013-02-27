# Add Vagrant to PATH
PATH="$PATH:/opt/vagrant/bin"
export PATH

EDITOR=vim
export EDITOR

PS1="[\u@\h \W]$(__git_ps1)\$ "

pupcheck () {
  if [ "$#" -eq 1 ]; then
    pattern="$1"
  else
    pattern="*.pp"
  fi

  for x in `ls -1 $pattern 2>/dev/null`; do
    echo -ne '\E[37;44m'"VALIDATING $x...."
    tput sgr0

    if puppet parser validate $x;then
      echo -e '\E[30;32m'"\033[1mSuccessful\033[0m, Running puppet-lint"
      tput sgr0
      echo
      puppet-lint --no-80chars-check --with-filename $x
    else
      echo -e '\E[30;31m'"FAILED"
      tput sgr0
    fi
  done
}

