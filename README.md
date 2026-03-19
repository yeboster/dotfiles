# Dotfiles

Personal dotfiles for macOS.

## Setup

```bash
./setup.sh
```

This installs:
- Homebrew dependencies (neovim, git, fzf, ripgrep, fd, autojump, direnv, gpg, gh, mise, pinentry-mac)
- Oh My Zsh + Powerlevel10k
- Zsh plugins (autosuggestions, syntax highlighting)
- Symlinks for zsh, git, nvim, mise, editorconfig

## What's Included

| Component | Path |
|-----------|------|
| Zsh | `zsh/zshrc`, `zsh/p10k.zsh` |
| Git | `git/gitconfig`, `git/ignore` |
| Neovim (LazyVim) | `nvim/` |
| mise | `mise/config.toml` |
| EditorConfig | `editorconfig` |

## GPG Signing

GPG is configured for GUI pinentry (`pinentry-mac`) for use with git commit signing in terminal and GUI apps (Neovim, etc.).

If you get pinentry errors, ensure the agent is running:
```bash
gpgconf --kill gpg-agent
```

## First Run

1. Run `./setup.sh`
2. Open `nvim` to let LazyVim install plugins
3. Run `p10k configure` to customize the prompt
