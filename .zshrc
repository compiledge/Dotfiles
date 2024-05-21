#
# ███████╗███████╗██╗  ██╗
# ╚══███╔╝██╔════╝██║  ██║
#   ███╔╝ ███████╗███████║
#  ███╔╝  ╚════██║██╔══██║
# ███████╗███████║██║  ██║
# ╚══════╝╚══════╝╚═╝  ╚═╝
#                        
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# History control
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Alias
alias ls='ls --color=always'
alias ll='exa --long --icons --color=always --git'
alias bat='batcat --theme Dracula'
alias zat='zathura'
alias apt-up='sudo apt update && sudo apt upgrade -y'

# Alias to pytho3
alias python='/usr/bin/python3'

# Environment variables
export EDITOR='nvim'
export VISUAL='nvim'
export NVIMRC="$HOME/.config/nvim/init.lua"
export COLORMODE=light
export MANPAGER='nvim +Man!'

export PATH="$HOME/.local/bin:$PATH"

# Plugins
source ~/.powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Zoxide
eval "$(zoxide init zsh)" # --cmd (alias to cd in recent versions)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
