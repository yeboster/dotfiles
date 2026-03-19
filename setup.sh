#!/bin/zsh
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "==> Installing Homebrew dependencies"
brew install coreutils curl git neovim fzf ripgrep fd autojump direnv gpg gh mise pinentry-mac

echo "==> Installing Oh My Zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "==> Installing Powerlevel10k"
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

echo "==> Installing zsh plugins"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

echo "==> Creating symlinks"

# Zsh
ln -sf "$DOTFILES/zsh/zshrc" ~/.zshrc
ln -sf "$DOTFILES/zsh/p10k.zsh" ~/.p10k.zsh

# Git
ln -sf "$DOTFILES/git/gitconfig" ~/.gitconfig
mkdir -p ~/.config/git
ln -sf "$DOTFILES/git/ignore" ~/.config/git/ignore

# Neovim (LazyVim)
rm -rf ~/.config/nvim
ln -sf "$DOTFILES/nvim" ~/.config/nvim

# EditorConfig
ln -sf "$DOTFILES/editorconfig" ~/.editorconfig

# mise
mkdir -p ~/.config/mise
ln -sf "$DOTFILES/mise/config.toml" ~/.config/mise/config.toml

# GPG agent
echo "==> Configuring GPG agent"
mkdir -p ~/.gnupg
cat > ~/.gnupg/gpg-agent.conf << 'GPGAGENT'
pinentry-program /opt/homebrew/bin/pinentry-mac
allow-loopback-pinentry
default-cache-ttl 28800
max-cache-ttl 28800
GPGAGENT
cat > ~/.gnupg/gpg.conf << 'GPGCONF'
use-agent
pinentry-mode loopback
GPGCONF
gpgconf --kill gpg-agent 2>/dev/null || true

echo "==> Done!"
echo "Open nvim to let LazyVim install plugins automatically."
echo "Run 'p10k configure' if you want to reconfigure the prompt."
