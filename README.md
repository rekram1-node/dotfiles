# Dotfiles

Using the tool chezmoi this will easily allow me to sync my developer environment between devices

## Installation

```zsh
brew install chezmoi
chezmoi init --apply rekram1-node
```

## Edit dotfiles

Go to the chezmoi directory
```zshrc
chezmoi cd
```

Edit file in question
```zsh
chezmoi edit ~/.zshrc
```

## Add file or dir to tracking
```zsh
chezmoi add ~/.config/zed
```

## Sync with remote
```zsh
chezmoi update
```
