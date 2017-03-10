# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export VISUAL='vim'

PATH="$HOME/.homesick/repos/homeshick/bin:$PATH"

# # Autostart workaround for windows
# fish -l
# exit
