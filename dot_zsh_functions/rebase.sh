rebase() {
  local main_branch
  if git show-ref --verify --quiet refs/heads/dev; then
    main_branch="dev"
  elif git show-ref --verify --quiet refs/heads/master; then
    main_branch="master"
  elif git show-ref --verify --quiet refs/heads/main; then
    main_branch="main"
  else
    echo "No main, master, or dev branch found."
    exit 1
  fi

  local current_branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)

  if [[ "$current_branch" == "$main_branch" ]]; then
    echo "Already on $main_branch, just pulling..."
    git pull
    return
  fi

  git fetch origin && git rebase "$main_branch"
}
