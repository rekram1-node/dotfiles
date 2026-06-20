---
name: manage-dotfiles
description: Manage and sync dotfiles with chezmoi. Use when asked about chezmoi, dotfiles, syncing current config files, applying managed state, committing dotfiles, or pushing the dotfiles repository.
---

# Manage Dotfiles

Use chezmoi deliberately: determine the requested sync direction, protect secrets, change only intended files, and verify both chezmoi and Git state.

## Local Setup

- Destination directory: `~`
- Chezmoi source directory: `~/.local/share/chezmoi`
- Remote: `git@github.com:rekram1-node/dotfiles.git`
- The remote repository is public.
- Chezmoi has `autoCommit` and `autoPush` enabled with an interactive commit-message prompt. In a non-interactive session, `chezmoi add` can update and stage the source file but then fail when it cannot open `/dev/tty`. Inspect the result instead of assuming the add failed entirely.
- When pushing this repository from OpenCode, use `git push --no-verify`.

## Establish Direction

Do not treat `chezmoi apply` and `chezmoi add` as interchangeable.

- To make home files match the managed source, use `chezmoi apply` after reviewing `chezmoi diff`.
- To save the current home-file state into chezmoi, use `chezmoi add <destination-path>` or make the equivalent minimal source-tree edit.
- To stop managing a local file while preserving it in the home directory, remove only its source entry from `~/.local/share/chezmoi`; do not delete the destination file.
- If direction is ambiguous or files conflict, ask one short question before changing anything.

## Required Workflow

1. Inspect `chezmoi status`, `chezmoi diff`, and Git status in the source repository.
2. Identify unrelated or pre-existing changes and leave them untouched unless the user explicitly asks to include them.
3. Check the remote visibility before adding machine details or sensitive configuration.
4. Review every intended diff for secrets before staging. Search for tokens, passwords, API keys, auth secrets, private keys, and credentials.
5. Never commit a plaintext secret to the public dotfiles repository. Prefer leaving the containing file unmanaged or use a password-manager-backed chezmoi template when requested.
6. Keep portable paths such as `$HOME/...` instead of hard-coded `/Users/<name>/...` paths unless the machine-specific path is intentional.
7. Validate affected formats and shell syntax before committing. For zsh files, use `zsh -n <file>`.
8. Before committing, inspect `git status`, staged and unstaged diffs, and recent commit messages. Stage only intended files.
9. Commit only when explicitly requested. Use a concise message consistent with repository history.
10. Push only when explicitly requested, using `git push --no-verify` for this repository.
11. Finish by confirming `chezmoi status` is empty for managed files and Git matches its upstream branch.

## Status Interpretation

Chezmoi status describes differences between source state and destination state. A listed file is not automatically a change that should be applied or added. Inspect its diff first and decide which side is authoritative.

For deletions, distinguish carefully between:

- A destination file intentionally removed and needing removal from the source.
- A source-managed file missing from the destination and needing `chezmoi apply`.
- A local-only file that should remain present but become unmanaged.

## Safety Rules

- Never run a blanket `chezmoi apply` merely to clear status.
- Never mirror all home files into source without reviewing the resulting commit.
- Never expose a secret because a repository happens to be called "dotfiles."
- Never revert unrelated worktree changes.
- Avoid destructive Git commands and force pushes.
- If a secret was committed previously, stop and recommend rotation plus history cleanup rather than merely deleting it in a new commit.
