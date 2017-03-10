# Setup dotfiles on Uberspace

#### STEP 1: Login as root user

#### STEP 2: Creating your admins user account and add it to the sudoers group

If you already created an user account for the admin, skip this step.
Otherwise create your admins user account:

    adduser <SERVER_USERNAME>
    passwd <SERVER_USERNAME>
    gpasswd wheel -a <SERVER_USERNAME>

#### STEP 3: Install the most important tools

    dnf remove vim-minimal
    dnf install git vim fish sudo

#### STEP 4: Login to your admins user account

    su - <SERVER_USERNAME>

#### STEP 5: Clone the dotfiles from these reporitory

    git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
    ~/.homesick/repos/homeshick/bin/homeshick clone mirhec/dotfiles.fedora

#### STEP 6: Setup fish as login shell

    sudo lchsh -i <SERVER_USERNAME>
        New Shell [/bin/bash]: /usr/bin/fish

#### STEP 7: Configure git

    git config --global user.name "<FIRST_NAME> <LAST_NAME>"
    git config --global user.email "<EMAIL_ADDRESS>"
        
        
#### STEP 8: Install docker
    sudo dnf -y install dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf makecache fast
    sudo dnf install docker-ce docker-compose
    sudo systemctl start docker
    sudo systemctl enable docker

#### STEP 9: Install nginx
    sudo dnf install nginx

#### Then log out and log in again to apply the changes
