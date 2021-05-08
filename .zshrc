# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/emerick/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="lambda-mod"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

#export DEFAULT_USER="architecture"

source $ZSH/oh-my-zsh.sh

prompt_context() {}

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Upload credentials
source /esev/.environment.sh

# LOCAL IP to browser-sync
alias serve="browser-sync start -s -f . --no-notify --host $LOCAL_IP --port 9000"
alias idea="/usr/bin/idea/bin/idea.sh"
alias apx="apx-cli"
alias ecs="ecs-cli"
alias ecsi="ecs-cli --directory directory.work-02.ether.igrupobbva --key $BBVA_KEY --cert $BBVA_CRT --insecure --refresh --verbose 3"
alias nv="nvim"

#Functions to improve develop & conformt
vxjfunction(){
   mvn archetype:generate -DgroupId=io.esev.com -DartifactId=$1 -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
}

vxjsfunction(){
   curl https://start.spring.io/starter.zip -d dependencies=web -d javaVersion=8  -o $1.zip
   unzip $1.zip -d $1
   cd $1
}

mkdircd(){
   mkdir $1 && cd $1
}

archTheme(){
   if [[ $1 = "w" ]]; then 
      cp /home/emerick/.config/nvim/init.white.vim /home/emerick/.config/nvim/init.vim
      cp /home/emerick/.config/alacritty/alacritty.white.yml /home/emerick/.config/alacritty/alacritty.yml
      cp /home/emerick/.config/picom/picom.white.conf /home/emerick/.config/picom/picom.conf
   else
      cp /home/emerick/.config/nvim/init.dark.vim /home/emerick/.config/nvim/init.vim
      cp /home/emerick/.config/alacritty/alacritty.dark.yml /home/emerick/.config/alacritty/alacritty.yml
      cp /home/emerick/.config/picom/picom.dark.conf /home/emerick/.config/picom/picom.conf
   fi
}

bwsTheme(){
   if [[ $1 = "w" ]]; then 
      cp /home/emerick/.config/vimb/style.white.css /home/emerick/.config/vimb/style.css
      cp /home/emerick/.config/vimb/home/styles/homepage.white.css /home/emerick/.config/vimb/home/styles/homepage.css
   else
      cp /home/emerick/.config/vimb/style.dark.css /home/emerick/.config/vimb/style.css
      cp /home/emerick/.config/vimb/home/styles/homepage.dark.css /home/emerick/.config/vimb/home/styles/homepage.css
   fi
}

alias vxm="vxjfunction"
alias vxs="vxjsfunction"
alias vboot="./mvnw spring-boot:run"
alias mcd="mkdircd"
alias bwsth="bwsTheme"
alias archtheme="archTheme"
alias myip="echo $LOCAL_IP"

alias gpum="git push -u origin master"
alias gpuo="git push -u origin "
alias gpo="git push origin "
alias gta="git tag -a "

alias dp="docker ps "
alias dpa="docker ps -a"
alias di="docker images"
alias dsp="docker stop "
alias dst="docker start "
alias drmi="docker rmi -f "
alias drm="docker rm -f "

neofetch

complete -C '/usr/local/bin/aws_completer' aws

