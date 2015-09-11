	# Make ls use colors
	export CLICOLOR=1
	alias ls='ls -Fa'
	alias ll='ls -la'
	#alias sublime='/Applications/Sublime\ Text\ 2.app/Contents/MacOS/Sublime\ Text\ 2'
	alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
	alias urldecode='python -c "import sys, urllib as ul; print ul.u nquote_plus(sys.argv[1])"'
	
	# define colors
	C_DEFAULT="\[\033[m\]"
	C_WHITE="\[\033[1m\]"
	C_BLACK="\[\033[30m\]"
	C_RED="\[\033[31m\]"
	C_GREEN="\[\033[32m\]"
	C_YELLOW="\[\033[33m\]"
	C_BLUE="\[\033[34m\]"
	C_PURPLE="\[\033[35m\]"
	C_CYAN="\[\033[36m\]"
	C_LIGHTGRAY="\[\033[37m\]"
	C_DARKGRAY="\[\033[1;30m\]"
	C_LIGHTRED="\[\033[1;31m\]"
	C_LIGHTGREEN="\[\033[1;32m\]"
	C_LIGHTYELLOW="\[\033[1;33m\]"
	C_LIGHTBLUE="\[\033[1;34m\]"
	C_LIGHTPURPLE="\[\033[1;35m\]"
	C_LIGHTCYAN="\[\033[1;36m\]"
	C_BG_BLACK="\[\033[40m\]"
	C_BG_RED="\[\033[41m\]"
	C_BG_GREEN="\[\033[42m\]"
	C_BG_YELLOW="\[\033[43m\]"
	C_BG_BLUE="\[\033[44m\]"
	C_BG_PURPLE="\[\033[45m\]"
	C_BG_CYAN="\[\033[46m\]"
	C_BG_LIGHTGRAY="\[\033[47m\]"
	
	# set your prompt
	export PS1="$C_CYAN\u$C_GREEN@\h $C_BLUE\d \$(date +%I:%M:%S%P)\e\n$C_PURPLE\w $ $C_YELLOW"
	PATH=$PATH:/usr/local/sbin   	#:/Applications/NetBeans/glassfish-4.0/bin
	#export PGHOST=localhost
