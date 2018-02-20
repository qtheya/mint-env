#!/bin/bash

apt-get -y update
apt-get -y dist-upgrade

apt-add-repository -y ppa:ansible/ansible ppa:webupd8team/terminix ppa:neovim-ppa/stable ppa:atareao/telegram 
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
add-apt-repository -y "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main"
add-apt-repository -y "deb https://packagecloud.io/slacktechnologies/slack/debian/ jessie main"
add-apt-repository -y "deb [arch=amd64] https://repo.skype.com/deb stable main"

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 

apt-get -y update

apt-get -y install docker-ce ansible tilix code google-chrome-stable neovim slack fonts-inconsolata telegram

fc-cache -fv

cat <<EOF >> /etc/vim/vimrc
set nu
set ls=2
set scrolloff=5
syntax enable
set nocompatible
set autoindent
set tabstop=3
set cursorline
hi CursorLine ctermbg=235
hi Comment ctermfg=darkcyan
set showmatch
set hlsearch
set incsearch
set ignorecase
set expandtab
set paste
EOF


cat <<EOF >> /etc/profile
export GOPATH=~/go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
#export EC2_INI_PATH=/etc/ansible/ec2.ini
EOF

sed -i 's/\[defaults]/&\n callback_whitelist = timer, mail, profile_tasks/' /etc/ansible/ansible.cfg
sed -i 's/\[defaults]/&\n nocows = 1/' /etc/ansible/ansible.cfg
