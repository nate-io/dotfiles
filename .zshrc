# sub profile name for <USERNAME>
# resources:
#   https://robertcooper.me/post/elegant-development-experience-with-zsh-and-hyper-terminal
#   https://tjay.dev/howto-my-terminal-shell-setup-hyper-js-zsh-starship/

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

eval "$(starship init zsh)"
source /Users/<USERNAME>/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /Users/<USERNAME>/.zsh/completion.zsh

# Load completion config
source $HOME/.zsh/completion.zsh

# Initialize the completion system
autoload -Uz compinit

# Cache completion if nothing changed - faster startup time
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# command history 
source /Users/<USERNAME>/.zsh/history.zsh

# default open to repos dir
cd ~/repos

source /Users/<USERNAME>/.zsh/aliases.zsh

# add typora command to cli
alias typora="open -a typora"

# Override auto-title when static titles are desired ($ title My new title)
title() { export TITLE_OVERRIDDEN=1; echo -en "\e]0;$*\a"}
# Turn off static titles ($ autotitle)
autotitle() { export TITLE_OVERRIDDEN=0 }; autotitle
# Condition checking if title is overridden
overridden() { [[ $TITLE_OVERRIDDEN == 1 ]]; }
# Echo asterisk if git state is dirty
gitDirty() { [[ $(git status 2> /dev/null | grep -o '\w\+' | tail -n1) != ("clean"|"") ]] && echo "*" }

# Show cwd when shell prompts for input.
tabtitle_precmd() {
   if overridden; then return; fi
   pwd=$(pwd) # Store full path as variable
   cwd=${pwd##*/} # Extract current working dir only
   print -Pn "\e]0;$cwd$(gitDirty)\a" # Replace with $pwd to show full path
}
[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions tabtitle_precmd)

# Prepend command (w/o arguments) to cwd while waiting for command to complete.
tabtitle_preexec() {
   if overridden; then return; fi
   printf "\033]0;%s\a" "${1%% *} | $cwd$(gitDirty)" # Omit construct from $1 to show args
}
[[ -z $preexec_functions ]] && preexec_functions=()
preexec_functions=($preexec_functions tabtitle_preexec)

# store venv's in project directory & use this to activate
alias activate-env='source venv/bin/activate'

# django 'root' alias
alias dj='python manage.py'

alias k='kubectl'