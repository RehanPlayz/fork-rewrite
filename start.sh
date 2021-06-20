#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

go_env(){
  # Goenv
  
if [ -d "temp-folder" ]
then 
    echo -e "HI" 2> /dev/null > /dev/null
else
    mkdir -p temp-folder
fi
  
if [ -z "$GOLANG_VERSION" ] ; then
    echo -e "==============================="
    echo -e "Golang version can be 1.12.1 , 1.13.1 , 1.14.1 , 1.15.1 , custom"
    read -p "Golang: " GOLANG_VERSION_SELECT
    echo -e "==============================="
case $GOLANG_VERSION_SELECT in
1.12.1)
  echo -e "==============================="
  echo -e "Golang 1.12.1"
  GOLANG_VERSION="1.12.1"
  echo -e "==============================="
;;
1.13.1)
  echo -e "==============================="
  echo -e "Golang 1.13.1"
  GOLANG_VERSION="1.13.1"
  echo -e "==============================="
;;
1.14.1)
  echo -e "==============================="
  echo -e "Golang 1.14.1"
  GOLANG_VERSION="1.14.1"
  echo -e "==============================="
;;
1.15.1)
  echo -e "==============================="
  echo -e "Golang 3.8.7"
  GOLANG_VERSION="3.8.7"
  echo -e "==============================="  
;;
custom)
  echo -e "==============================="
  echo -e "Custom Golang version"
  read -p "Golang version: " GOLANG_VERSION
  echo -e "Using Golang $GOLANG_VERSION"
  echo -e "==============================="
;;
*)
  echo -e "hi" 2> /dev/null > /dev/null
;;
esac
fi

git clone https://github.com/syndbg/goenv.git ~/.goenv 2> /dev/null > /dev/null
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
eval "$(goenv init -)" 
export GOPATH="$HOME/go" >> ~/.bash_profile
export TMPDIR="$HOME/temp-folder"
     sleep 5s
     echo -e "==============================="
     echo -e "Available Golang versions: $(goenv install --list)"
     echo -e "==============================="
     sleep 5s
     echo -e "Using Golang ${GOLANG_VERSION}"
     goenv install "${GOLANG_VERSION}" -s
     goenv global "${GOLANG_VERSION}"
     rm -rf temp-folder/go-build*
}

py_env(){
  # Pyenv

if [ -d "temp-folder" ]
then 
    echo -e "HI" 2> /dev/null > /dev/null
else
    mkdir -p temp-folder
fi

if [ -z "$PYTHON_VERSION" ] ; then
    echo -e "==============================="
    echo -e "Python version can be 3.5.10 , 3.6.12 , 3.7.9 , 3.8.7 , 3.9.1 , custom"
    read -p "Python: " PYTHON_VERSION_SELECT
    echo -e "==============================="
case $PYTHON_VERSION_SELECT in
3.5.10)
  echo -e "==============================="
  echo -e "Python 3.5.10"
  PYTHON_VERSION="3.5.10"
  echo -e "==============================="
;;
3.6.12)
  echo -e "==============================="
  echo -e "Python 3.6.12"
  PYTHON_VERSION="3.6.12"
  echo -e "==============================="
;;
3.7.9)
  echo -e "==============================="
  echo -e "Python 3.7.9"
  PYTHON_VERSION="3.7.9"
  echo -e "==============================="
;;
3.8.7)
  echo -e "==============================="
  echo -e "Python 3.8.7"
  PYTHON_VERSION="3.8.7"
  echo -e "==============================="  
;;
3.9.1)
  echo -e "==============================="
  echo -e "Python 3.9.1"
  PYTHON_VERSION="3.9.1"
  echo -e "==============================="
;;
custom)
  echo -e "==============================="
  echo -e "Custom python version"
  read -p "Python version: " PYTHON_VERSION
  echo -e "Using python $PYTHON_VERSION"
  echo -e "==============================="
;;
*)
  echo -e "hi" 2> /dev/null > /dev/null
;;
esac
fi

git clone https://github.com/pyenv/pyenv.git ~/.pyenv 2> /dev/null > /dev/null
export PYENV_ROOT="$HOME/.pyenv"
PATH="/home/container/.pyenv/bin:$PATH"
eval "$(pyenv init -)" 2> /dev/null > /dev/null
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv 2> /dev/null > /dev/null
eval "$(pyenv virtualenv-init -)" 2> /dev/null > /dev/null
export TMPDIR="$HOME/temp-folder"
     sleep 5s
     echo -e "==============================="
     echo -e "To run pip install command use pyenv exec pip install"
     echo -e "==============================="
     sleep 5s
     echo -e "Using Python ${PYTHON_VERSION}"
     pyenv install "${PYTHON_VERSION}" -s
     pyenv global "${PYTHON_VERSION}"
     rm -rf temp-folder/python-build*
}

jabba_java(){
# Jabba

if [ -d "temp-folder" ]
then 
    echo -e "HI" 2> /dev/null > /dev/null
else
    mkdir -p temp-folder
fi

if [ -z "$JAVA_VERSION" ] ; then
    echo -e "==============================="
    echo -e "Java version can be java8 , java11 , latest , custom"
    read -p "Java: " JAVA_VERSION_SELECT
    echo -e "==============================="
case $JAVA_VERSION_SELECT in
java8)
  echo -e "==============================="
  echo -e "Java 8"
  JAVA_VERSION="adopt@1.8-0"
  echo -e "==============================="
;;
java11)
  echo -e "==============================="
  echo -e "Java 11"
  JAVA_VERSION="adopt@1.11-0"
  echo -e "==============================="
;;
latest)
  echo -e "==============================="
  echo -e "Java 15"
  JAVA_VERSION="adopt@1.15-0"
  echo -e "==============================="
;;
custom)
  echo -e "==============================="
  echo -e "Custom java version"
  read -p "Java version: " JAVA_VERSION
  echo -e "Using java $JAVA_VERSION"
  echo -e "==============================="
;;
*)
  echo -e "hi" 2> /dev/null > /dev/null
;;
esac
fi

curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | JABBA_VERSION=0.11.2 bash && . ~/.jabba/jabba.sh 2> /dev/null > /dev/null
[ -s "$JABBA_HOME/jabba.sh" ] && source "$JABBA_HOME/jabba.sh" 2> /dev/null > /dev/null
export TMPDIR="$HOME/temp-folder"
     sleep 5s
     echo -e "==============================="
     echo -e "Available Java versions: $(jabba ls-remote)"
     echo -e "==============================="
     sleep 5s
     jabba install "${JAVA_VERSION}"
     jabba use "${JAVA_VERSION}"
     jabba alias default "${JAVA_VERSION}"
     echo -e "==============================="
     java -version
     echo -e "==============================="
}

nvm_nodejs(){
# NVM

if [ -e ".nvmrc" ]
then 
    echo -e "HI" 2> /dev/null > /dev/null
else
    touch .nvmrc
fi

if [ -d ".nvm" ]
then 
    echo -e "HI" 2> /dev/null > /dev/null
else
    mkdir -p .nvm
fi

if [ -d ".npm-global" ]
then 
    echo -e "HI" 2> /dev/null > /dev/null
else
    mkdir -p .npm-global
fi

if [ -d ".npm-global/lib" ]
then 
    echo -e "HI" 2> /dev/null > /dev/null
else
    mkdir -p .npm-global/lib
fi

if [ -d "temp-folder" ]
then 
    echo -e "HI" 2> /dev/null > /dev/null
else
    mkdir -p temp-folder
fi

if [ -z "$NODEJS_VERSION" ] ; then
    echo -e "==============================="
    echo -e "NodeJS version can be nodejs8 , nodejs10 , nodejs12 , nodejs14 , nodejs15 , custom"
    read -p "NodeJS: " NODEJS_VERSION_SELECT
    echo -e "==============================="
case $NODEJS_VERSION_SELECT in
nodejs8)
  echo -e "==============================="
  echo -e "NodeJS 8"
  NODEJS_VERSION="8"
  echo -e "==============================="
;;
nodejs10)
  echo -e "==============================="
  echo -e "NodeJS 10"
  NODEJS_VERSION="10"
  echo -e "==============================="
;;
nodejs12)
  echo -e "==============================="
  echo -e "NodeJS 12"
  NODEJS_VERSION="12"
  echo -e "==============================="
;;
nodejs14)
  echo -e "==============================="
  echo -e "NodeJS 14"
  NODEJS_VERSION="14"
  echo -e "==============================="  
;;
nodejs15)
  echo -e "==============================="
  echo -e "NodeJS 15"
  NODEJS_VERSION="15"
  echo -e "==============================="
;;
custom)
  echo -e "==============================="
  echo -e "Custom NodeJS version"
  read -p "NodeJS version: " NODEJS_VERSION
  echo -e "Using NodeJS $NODEJS_VERSION"
  echo -e "==============================="
;;
*)
  echo -e "hi" 2> /dev/null > /dev/null
;;
esac
fi

curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | NVM_DIR=/home/container/.nvm bash 2> /dev/null > /dev/null
NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules 
export NVM_DIR="/home/container/.nvm" 2> /dev/null > /dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm 2> /dev/null > /dev/null
     sleep 3s
     echo -e "==============================="
     echo -e "Available NodeJS versions: $(nvm ls-remote)"
     echo -e "==============================="
     sleep 2s
     echo -e "==============================="
     echo -e "Installing NodeJS ${NODEJS_VERSION}" 
     nvm install "${NODEJS_VERSION}"
     nvm alias default "${NODEJS_VERSION}"
     echo -e "==============================="
     sleep 2s
     echo -e "==============================="
     echo -e "Configuring Global packages location"
     npm config set prefix '~/.npm-global'
     export PATH=~/.npm-global/bin:$PATH
     echo -e "==============================="
     sleep 2s
     echo -e "==============================="
     echo -e "Upgrading NPM to latest version"
     npm install -g npm@latest
     echo -e "==============================="
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

bot_startup(){

case $SERVER_TYPE in
python)
  py_env
  ${STARTUP_CMD}
;;
nodejs)
  nvm_nodejs
  ${STARTUP_CMD}
;;
java)
  jabba_java
  ${STARTUP_CMD}

;;
golang)
  go_env
  ${STARTUP_CMD}
;;
rust)
  rust_version_manager
  ${STARTUP_CMD}
;;
*)
  echo -e "hi" 2> /dev/null > /dev/null
;;
esac    

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
bot_startup
