# AGENTS.md — Dotfiles

Personal dotfiles for macOS. Manages shell (Zsh), Git, Neovim (LazyVim), mise, and EditorConfig.

## Repository Structure

```
.
├── setup.sh          # Bootstrap script — installs deps, creates symlinks
├── zsh/
│   ├── zshrc         # Main Zsh config (sourced as ~/.zshrc)
│   └── p10k.zsh      # Powerlevel10k prompt config
├── git/
│   ├── gitconfig     # Git global config
│   └── ignore        # Global gitignore (used as excludesfile)
├── nvim/             # Neovim config (symlinked to ~/.config/nvim)
│   ├── init.lua      # Bootstraps lazy.nvim
│   ├── lazyvim.json  # LazyVim distribution spec
│   └── lua/
│       ├── config/   # LazyVim config stubs (lazy, options, keymaps, autocmds)
│       └── plugins/  # Custom plugin definitions (monokai, copy-file-path, vim-rails, vim-projectionist)
├── mise/
│   └── config.toml   # mise (runtime manager) config
└── editorconfig      # EditorConfig (symlinked to ~/.editorconfig)
```

## Setup / Bootstrap

```bash
./setup.sh
```

- Installs Homebrew deps: `coreutils curl git neovim fzf ripgrep fd autojump direnv gpg gh mise pinentry-mac`
- Installs Oh My Zsh, Powerlevel10k theme, zsh-autosuggestions, zsh-syntax-highlighting
- Creates symlinks for all components (zsh → ~/.zshrc, nvim → ~/.config/nvim, etc.)
- Configures GPG agent with pinentry-mac and long TTL (400 days cached)

## Post-Setup Steps

1. Open `nvim` to let LazyVim install plugins automatically
2. Run `p10k configure` to customize the prompt appearance

## Key Configuration Details

### GPG Signing
- Git commits are GPG-signed by default (`gpgsign = true` in gitconfig)
- Signing key: `C1FC973CB9495973`
- Uses `pinentry-mac` (GUI) for passphrase entry — works in terminal and GUI apps
- GPG agent cache TTL is set to ~400 days (34560000 seconds)
- If pinentry fails: `gpgconf --kill gpg-agent`

### Editor
- `EDITOR=nvim` globally
- Neovim uses LazyVim distribution with custom plugins added in `lua/plugins/plugins.lua`

### Shell Environment
- Zsh with Oh My Zsh + Powerlevel10k instant prompt
- Plugins: git, docker, docker-compose, autojump, kubectl, bundler
- mise activated in zsh for runtime version management
- direnv hook enabled
- SOPS age key at `~/.config/sops/age/keys.txt`
- iTerm2 shell integration sourced if present

### mise
- Config at `~/.config/mise/config.toml` (idiomatic version files enabled for Ruby)
- mise is activated in zshrc via `eval "$(mise activate zsh)"`

### Git Credentials
- Uses `gh auth git-credential` for GitHub HTTPS (no password prompting)
- Default branch: `main`, push.autoSetupRemote: true

## Custom Neovim Plugins

| Plugin | Purpose |
|--------|---------|
| `tanvirtin/monokai.nvim` | Monokai colorscheme |
| `h3pei/copy-file-path.nvim` | Copy file path helper |
| `tpope/vim-rails` | Rails support |
| `tpope/vim-projectionist` | Project-wide alternate file definitions |

## Conventions

- This is a **dotfiles repo** — no build/test/run cycle. Changes take effect immediately via symlinked configs.
- `setup.sh` is idempotent — safe to re-run.
- Neovim config follows LazyVim patterns: plugins defined in `lua/plugins/plugins.lua`, config stubs in `lua/config/`.
- `lazy = false` for custom plugins — they load at startup, not lazily.
