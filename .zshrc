# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/vinay/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

function prompt_fir_dir() {
  emulate -L zsh
  local split_path=(${(s:/:)${(%):-%~}//\%/%%})
  (( $#split_path )) || split_path+=/
  if (( $#split_path == 1)); then
    p9k_prompt_segment -s SOLO -b 160 -f 255 -t $split_path
    return
  fi
  p9k_prompt_segment -s FIRST -b 209 -f 255 -t $split_path[1]
  shift split_path
  while (( $#split_path > 1 )); do
    p9k_prompt_segment -s EVEN -b 202 -f 255 -t $split_path[1]
    shift split_path
    (( $#split_path > 1 )) || break
    p9k_prompt_segment -s ODD -b 209 -f 255 -t $split_path[1]
    shift split_path
  done
  p9k_prompt_segment -s LAST -b 160 -f 255 -t $split_path[1]
}

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon fir_dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs newline status command_execution_time load ram root_indicator battery time)

export LS_COLORS=$(ls_colors_generator)

run_ls() {
        ls-i --color=auto -w $(tput cols) "$@"
}

run_dir() {
        dir-i --color=auto -w $(tput cols) "$@"
}

run_vdir() {
        vdir-i --color=auto -w $(tput cols) "$@"
}

alias lsb="run_ls"
alias dir="run_dir"
alias vdir="run_vdir"
alias temp="osx-cpu-temp"
plugins=(git vi-mode zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

bindkey \;j vi-cmd-mode 

alias ls="lsb"
alias g++="g++ --std=c++14"
alias c="clear"
alias swap="hidutil property --set '{\"UserKeyMapping\":[{\"HIDKeyboardModifierMappingSrc\":0x700000039,\"HIDKeyboardModifierMappingDst\":0x70000002A},{\"HIDKeyboardModifierMappingSrc\":0x70000002A,\"HIDKeyboardModifierMappingDst\":0x700000039}]}'"
alias unswap="hidutil property --set '{\"UserKeyMapping\":[]}'"
alias vimgolf="/usr/local/lib/ruby/gems/2.5.0/gems/vimgolf-0.4.8/bin/vimgolf"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/ruby@2.5/bin:$PATH"
export PATH=$HOME/.gem/ruby/2.5.0/bin:$PATH
export PATH="/usr/local/opt/python@3.7/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
