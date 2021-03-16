#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}


rust_version_manager(){

if [ -d "temp-folder" ]
then 
    echo -e "HI" 2> /dev/null > /dev/null
else
    mkdir -p temp-folder
fi

if [ -z "$RUST_VERSION" ] ; then
    echo -e "==============================="
    echo -e "Rut version can be latest , 1.10.0-rc , nightly , beta , custom"
    read -p "Rust: " RUST_VERSION_SELECT
    echo -e "==============================="
case $RUST_VERSION_SELECT in
latest)
  echo -e "==============================="
  echo -e "Rust 1.16.0"
  RUST_VERSION="1.16.0"
  echo -e "==============================="
;;
1.10.0-rc)
  echo -e "==============================="
  echo -e "Rust 1.10.0-rc"
  RUST_VERSION="1.10.0-rc"
  echo -e "==============================="
;;
nightly)
  echo -e "==============================="
  echo -e "Rust nightly"
  RUST_VERSION="nightly"
  echo -e "==============================="
;;
beta)
  echo -e "==============================="
  echo -e "Rust beta"
  RUST_VERSION="beta"
  echo -e "==============================="
;;
custom)
  echo -e "==============================="
  echo -e "Custom Rust version"
  read -p "Rust version: " RUST_VERSION
  echo -e "Using Rust $RUST_VERSION"
  echo -e "==============================="
;;
*)
  echo -e "hi" 2> /dev/null > /dev/null
;;
esac
fi

export TMPDIR="$HOME/temp-folder"
curl https://raw.githubusercontent.com/sdepold/rsvm/master/install.sh | sh
[[ -s /home/container/.rsvm/rsvm.sh ]] && . /home/container/.rsvm/rsvm.sh
sleep 3s
echo -e "==============================="
echo -e "Available Rust versions: $(rsvm ls-remote)"
echo -e "==============================="
sleep 3s
rsvm install ${RUST_VERSION}
rsvm use ${RUST_VERSION}
}


backup_file(){    

if [ -e "backup.me" ]
then 
    echo -e "==============================="
    echo -e "Make sure you have enough Disk Storage"
    echo -e "==============================="
    sleep 5s
    zip -r "backup-$(date +"%Y-%m-%d %H-%M-%S").zip" *
    echo -e "==============================="
    echo -e "Backup Finished"
    echo -e "Download Backup Archive from File Manager or SFTP"
    echo -e "==============================="
    sleep 5s
    rm -rf backup.me
    exit
fi
}

startup(){
    output "==============================="
    output "| RAM: $SERVER_MEMORY MB"
    output "| IP: $SERVER_IP:$SERVER_PORT"
    output "| Server UUID: $(hostname)"
    output "==============================="
    output ""


    output "==============================="
    output "| Create backup.me file to backup server"
    output "| Don't forget to backup server regularly"
    output "==============================="
    output ""
    
    output "==============================="
    output "| Starting...."
    output "| Don't forget to configure server type at variables"
    output "==============================="
    output ""

}

#Execution
startup
backup_file

rust_version_manager
${STARTUP_CMD}