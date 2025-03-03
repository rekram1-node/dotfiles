# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

## ---------git----------
alias gp="git pull"
alias gpp="git push"
alias gs="git switch"
alias gsc="git switch -C"
alias gc="git commit -m"
alias gca="git add . && git commit -m"
alias gclean="git reset --hard && git clean -fd"
alias dev="gs dev && gp"
alias main='
  cd "$(git rev-parse --show-toplevel)" &&
  if git show-ref --quiet refs/heads/main; then
    gs main
  elif git show-ref --quiet refs/heads/master; then
    gs master
  else
    echo >&2 "Neither main nor master branch exists."
    exit 1
  fi

  gp
'


## ----------squashing------------
alias how-to-squash='echo "# Reset the current branch to the commit just before the last 12:
git reset --hard HEAD~12
# HEAD@{1} is where the branch was just before the previous command.
# This command sets the state of the index to be as it would just
# after a merge from that commit:
git merge --squash HEAD@{1}

# Commit those squashed changes.  The commit message will be helpfully
# prepopulated with the commit messages of all the squashed commits:
git commit"'




source <(fzf --zsh)
