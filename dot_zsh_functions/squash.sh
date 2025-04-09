squash() {
  # Prompt for the number of commits to squash
  echo -n "Enter the number of commits to squash (~n): "
  read num_commits

  # Validate input
  if ! [[ "$num_commits" =~ ^[0-9]+$ ]]; then
    echo "Invalid input. Please enter a positive number."
    return 1
  fi

  # Prompt for the commit message
  echo -n "Enter the commit message: "
  read commit_message

  # Confirm the actions
  echo "You are about to squash the last $num_commits commits."
  echo -n "Do you want to proceed? (y/n): "
  read confirm

  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    # Perform the squash
    echo "Resetting to HEAD~$num_commits..."
    git reset --hard HEAD~"$num_commits"

    echo "Merging with squash..."
    git merge --squash HEAD@{1}

    echo "Creating a new commit..."
    git commit -m "$commit_message"

    echo "Squash completed successfully!"
  else
    echo "Operation canceled."
  fi
}
