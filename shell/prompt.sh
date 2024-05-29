# Define color variables
PURPLE='\[\e[35m\]'
ORANGE='\[\e[33m\]'
RED='\[\e[31m\]'
GREEN='\[\e[32m\]'
BLUE='\[\e[34m\]'
YELLOW='\[\e[93m\]'
CYAN='\[\e[36m\]'

# Define prompt colors
SYMBOL_COLOR=$PURPLE
DATA_COLOR=$CYAN
RESET_COLOR='\[\e[0m\]'

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

render_prompt() {
    if [[ ! -z "$(parse_git_branch)" ]]; then
        # If the current directory is a git repo adds the git branch to the prompt
        echo "${SYMBOL_COLOR}[${DATA_COLOR}\t${SYMBOL_COLOR}]--[${DATA_COLOR}\u@\h${SYMBOL_COLOR}]--[${DATA_COLOR}\w${SYMBOL_COLOR}]--[${DATA_COLOR}\$(parse_git_branch)${SYMBOL_COLOR}]-->${RESET_COLOR} "
    else
        echo "${SYMBOL_COLOR}[${DATA_COLOR}\t${SYMBOL_COLOR}]--[${DATA_COLOR}\u@\h${SYMBOL_COLOR}]--[${DATA_COLOR}\w${SYMBOL_COLOR}]-->${RESET_COLOR} "
    fi
}

set_prompt() {
    PS1=$(render_prompt)
}