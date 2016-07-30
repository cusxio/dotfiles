# Sourced after .zprofile.
# However .zprofile does not exist.
# Therefore, source after .zshenv.
# zshenv -> zshrc

source "${DOTFILES}/shell/init.sh"

# ZSH Options
# http://zsh.sourceforge.net/Doc/Release/Options.html
# "Options are primarily referred to by name.
# These names are case insensitive and underscores are ignored.
# For example, 'allexport' is equivalent to 'A__lleXP_ort'."

# Changing directories

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME

# Completion

setopt AUTO_LIST
setopt AUTO_MENU
setopt NO_COMPLETE_ALIASES
setopt LIST_PACKED

# Expansion and Globbing

setopt EXTENDED_GLOB

# History

setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt BANG_HIST

# Input/Output

setopt CORRECT

# ZLE

setopt NO_BEEP
setopt VI

# fpath and zsh manual

if [[ -d "${BREW_PREFIX}" ]]; then
	fpath=(
		"${BREW_PREFIX}/share/zsh/site-functions"
		$fpath
	)

	# https://github.com/Homebrew/homebrew-core/blob/master/Formula/zsh.rb
	# Use brew's zsh help files.
	if [[ -d "${BREW_PREFIX}/share/zsh/help" ]]; then
		unalias run-help
		autoload run-help
		HELPDIR="${BREW_PREFIX}/share/zsh/help"
	fi

fi

# FZF
# https://github.com/junegunn/fzf

[[ -f "${HOME}/.fzf.zsh" ]] && source "${HOME}/.fzf.zsh"

# fasd
# https://github.com/clvv/fasd

fasd_cache="${XDG_CACHE_HOME}/.fasd-init-cache"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# ZPLUG
# https://github.com/zplug/zplug

# zplug directory
export ZPLUG_HOME="${XDG_DATA_HOME}/zplug"
# This file is used to manage zsh plugins
# https://github.com/zplug/zplug#zplug_loadfile
export ZPLUG_LOADFILE="${ZDOTDIR}/zplug.zsh"

ZPLUG_INIT_FILE="${ZPLUG_HOME}/init.zsh"


__zplug_source() {
	if [[ -f "$ZPLUG_INIT_FILE" ]]; then
		source "$ZPLUG_INIT_FILE"
	fi
	export PATH="${ZPLUG_HOME}/bin:${PATH}"
}

__zplug_init() {
	if [[ ! -f "$ZPLUG_INIT_FILE" ]]; then
		rm -rf "$ZPLUG_HOME"
		git clone https://github.com/zplug/zplug.git "$ZPLUG_HOME" \
            && __zplug_source \
            && zplug update --self
	fi

	[[ -z "$ZPLUG_ROOT" ]] && __zplug_source

	command -v "zplug" &> /dev/null && {
		zplug check --verbose || zplug install
		zplug load
	}
}

__zplug_init

# Hooks
# nvm hooks based on .nvmrc

__nvm_auto_use() {
	[[ -f ".nvmrc" && -r ".nvmrc" ]] && nvm use
}

command -v "nvm" &> /dev/null && {
	add-zsh-hook chpwd __nvm_auto_use
}

# ZSH Completion System Configuration
# http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Completion-System-Configuration

if [[ "$0" == *"zsh" ]]; then
	zmodload -i zsh/complist
	zstyle ':completion:*' use-cache 1
	zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/.zcache"
	zstyle ':completion:*' menu select=2
	zstyle ':completion:*' group-name ''
	zstyle ':completion:*:messages' format '%d'
	zstyle ':completion:*:descriptions' format '%d'
	zstyle ':completion:*:options' verbose yes
	zstyle ':completion:*:values' verbose yes
	zstyle ':completion:*:options' prefix-needed yes
	zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    zstyle ':completion:*' keep-prefix
    zstyle ':completion:*' list-colors ''
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
fi
