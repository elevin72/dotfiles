alias add-alias="nvim + ~/.config/zsh/aliases.zsh 2> /dev/null"

#if cd'd into a file then just open it with vim
# cd () {
# 	if [ -f "$1" ]; then
# 		builtin cd "$(dirname "$1")" 
# 		nvim "$(basename "$1")"
# 	elif [ "$1" = "" ]; then
# 		builtin cd
# 	else
# 		builtin cd "$1" 
# 	fi
# }

spot () {
	if [ ! $(pgrep "spotifyd") ]; then
	  spotifyd
	fi

	spt
}

alias kport="kill $(ss -tlnp | awk '/server/{print $6}' | sed 's/^.*pid=\([0-9]*\).*$/\1/')"

# gcc -g -c file.c && objdump -d -Mintel -S file.o
asm () {
    basename="${1%.*}"
    echo "Output in ""${basename}.output"
    gcc -g -c $1 && objdump -d -Mintel -S "${basename}".o | tee "${basename}.output"
}

# enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
	  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	  # alias ls='ls --color=auto'
	  alias dir='dir --color=auto'
	  alias vdir='vdir --color=auto'
	  alias grep='grep --color=auto'
	  alias fgrep='fgrep --color=auto'
	  alias egrep='egrep --color=auto'
  fi

alias la="ls -a" 
alias ll="ls -l" 
alias v=nvim
alias vrc="nvim ~/.config/nvim/init.lua"
alias z=" devour zathura"
# alias sxiv="devour sxiv"
alias killzoom="killall zoom"
alias zrc="nvim ~/.config/zsh/.zshrc"
alias soz="source ~/.config/zsh/.zshrc"
alias wget="wget --hsts-file="$XDG_CACHE_HOME/wget-hsts""
# alias rm='echo "Use del (trash-cli) instead!\nDo \\\rm if you must."; false'
alias del='trash-put'
# Compile Run Rey Trace
alias crrt='mvn -q clean package && java -cp target/rey-trace-1.jar Main'
alias fonts='fc-list | cut -d ':' -f  2 | sort | fzf | xargs | xclip'
alias reytrace='java -jar ~/school/SE-Graphics-Project/rey-trace/target/rey-trace-1-jar-with-dependencies.jar'
alias py='python'
alias bcs='/home/eli/school/c-seminar/exercises/buildscipt.py'
alias topdf='libreoffice --headless --convert-to pdf'
