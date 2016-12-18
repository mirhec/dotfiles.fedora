# Setup dotfiles on Uberspace

#### STEP 1: Login to your server

#### STEP 2: Clone the dotfiles from these reporitory

```bash
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
~/.homesick/repos/homeshick/bin/homeshick clone mirhec/dotfiles.uberspace
source ~/.bashrc
```

#### STEP 3: Install Linuxbrew and fish
```bash
git clone https://github.com/Linuxbrew/brew.git ~/.linuxbrew

# symlinks to gcc in order to make brew install able to compile from source
ln -s /package/host/localhost/gcc-4.9/bin/gcc ~/.linuxbrew/bin/gcc-4.9
ln -s /package/host/localhost/gcc-4.9/bin/g++ ~/.linuxbrew/bin/g++-4.9

# install fish with brew
brew install fish
```

#### Then log out and log in again to apply the changes
