# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/sundbp/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
SPACESHIP_TIME_SHOW=true
SPACESHIP_DIR_COLOR="32"
SPACESHIP_GIT_BRANCH_COLOR="136"
SPACESHIP_TIME_COLOR="30"
SPACESHIP_GIT_STATUS_COLOR="197"
ZSH_THEME="spaceship"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew bundler chruby lein docker npm sudo tmuxinator)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

. /usr/local/etc/profile.d/z.sh

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

export CLICOLOR=1

# node.js stuff
if [ -f ~/.nvm/nvm.sh ]; then
    source ~/.nvm/nvm.sh
fi

# http proxy stuff
export NO_PROXY=localhost,127.0.0.1
export no_proxy=$NO_PROXY

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

if [[ `uname` == "Darwin" ]];then
   export MANPATH=/usr/local/share/man:$MANPATH
   export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
   source "`brew --prefix`/etc/grc.bashrc"
fi

# stray UBUNTU_MENUPROXY
unset UBUNTU_MENUPROXY

# turn off XON/XOFF
if [ -f /bin/stty ];then
    stty -ixon
fi

# path related bits at the end here
if [ -d ~/.rbenv ];then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

if [ -d ~/bin ];then
    export PATH="$PATH:$HOME/bin"
fi

export PATH="./b:$PATH"

export LANG=en_US.UTF-8
export LANGUAGE="en_US:en"

GPG_TTY=$(tty)
export GPG_TTY

export BOOT_JVM_OPTIONS="-client -XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xmx2g -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled"

# direnv
_direnv_hook() {
    local previous_exit_status=$?;
    eval "$(direnv export bash)";
    return $previous_exit_status;
};
if ! [[ "$PROMPT_COMMAND" =~ _direnv_hook ]]; then
    PROMPT_COMMAND="_direnv_hook;$PROMPT_COMMAND";
fi

# google-cloud-sdk
if [[ `uname` == "Darwin" ]];then
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
fi

export LESS="-R"

source "/Users/sundbp/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
    export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Auto-completion
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

_fzf_compgen_path() {
    ag -g "" "$1"
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
