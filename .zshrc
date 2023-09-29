# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Complementando comandos
alias ls='ls --color=always'
alias ll='exa --icons --color=always'
alias batcat='batcat --theme Dracula'
alias zat='zathura'
# alias vim='nvim'
#alias less='less -R'

# Criando apelido para o python (babel)
alias python='/usr/bin/python3'

export EDITOR='nvim'
export VISUAL='nvim'
export NVIMRC="$HOME/.config/nvim/init.lua"
export COLORMODE=light
# export TERMINAL ="kitty"
# export VISUAL="nvim"
# export SUDO_EDITOR="nvim"
# export READER="zathura"
# export BROWSER ="firefox"

export PATH="$HOME/.local/bin:$PATH"

source ~/.powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
