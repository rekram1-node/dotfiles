rebase() {
  # Detect main branch name (main or master)
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

  # Get current branch name
  local current_branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)

  # Exit if already on main branch
  if [[ "$current_branch" == "$main_branch" ]]; then
    echo "Already on $main_branch, just pulling..."
    git pull
    return
  fi

  # Switch to main branch and pull latest changes
  git switch "$main_branch" && git pull || return

  # Switch back to original branch and rebase
  git switch "$current_branch" && git rebase "$main_branch"
}
