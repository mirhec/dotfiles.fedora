# Setup dotfiles on Fedora

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
    sudo dnf install docker-ce
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo gpasswd -a <SERVER_USERNAME> docker
    sudo systemctl restart docker
    newgrp docker

#### STEP 9: Install docker-compose
    sudo curl -L --fail https://github.com/docker/compose/releases/download/1.16.1/run.sh -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

#### STEP 10: Install ssh key to log in without password
    # on your Mac / Linux host run
    ssh-copy-id [youruser]@[yourfedorahost]

#### STEP 11: Create backup scripts

    sudo dnf install gnupg duplicity duply

Then create a new S3-bucket and leave all the presets as is. Then create a new IAM user and attatch this custom policy:

    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": ["s3:ListBucket" ],
          "Resource": "arn:aws:s3:::my_bucket"
        },
        {
          "Effect": "Allow",
          "Action": [ "s3:PutObject", "s3:GetObject", "s3:DeleteObject"],
          "Resource": "arn:aws:s3:::my_bucket/*"
        }
      ]
    }

Then create a duply profile with `duply backup_profile create` and change the contents of `~/.duply/backup_profile/conf` to

    SOURCE=/var/www

    TARGET='s3://s3-eu-central-1.amazonaws.com/your-bucket'
    export AWS_ACCESS_KEY_ID='<your aws key id>'
    export AWS_SECRET_ACCESS_KEY='<your aws secret access key>'

    # Uncomment if you prefere the more secure public/private key encryption
    GPG_PW=`<your password>`

Then save the keys in keyring:

    keyring set 'duplicity backup_profile' AWS_ACCESS_KEY_ID
    keyring set 'duplicity backup_profile' AWS_SECRET_ACCESS_KEY
    keyring set 'duplicity backup_profile' PASSPHRASE

Now test the backups with

    duply backup_profile backup

Create cron entry with
    
    sudo crontab -e
    # then add the following to make a new backup on each sunday at 2AM
    0 2 * * 7 env HOME=/home/<SERVER_USERNAME> duply backup_profile backup

#### Then log out and log in again to apply the changes
