autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

# Git Branch Naming
zstyle ':vcs_info:git:*' formats '%b '

# Build The Prompt
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

# PATH Customisations
#export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# Alias'
alias ll='ls -la'
alias sa='source ~/.zshrc;echo "Reloaded ~/.zshrc"'
alias dev='cd ~/develop;'
alias c='cd'

# Plugin: Auto Suggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=black,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(completion)
bindkey '^ ' autosuggest-accept # Use Ctrl + Space to accept suggestion
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Plugin: Syntax Highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Plugin: Z
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z/zsh-z.plugin.zsh

# Plugins
plugins=( git zsh-autosuggestions zsh-syntax-highlighting zsh-z )
