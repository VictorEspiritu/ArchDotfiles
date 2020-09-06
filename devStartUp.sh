
# Install tig to view commits 
sudo pacman -S tig

# Install docker 
sudo pacman -S docker 

# condiguration docker and startup
sudo systemctl start docker.service
sudo docker info
sudo docker run -it --rm archlinux bash -c "echo hello world"

# add user a groups
sudo groupadd docker
sudo gpasswd -a emerick docker

# execute git without sudo
sudo chown -R emerick:emerick /path_to_projet/.git

# install java 
sudo pacman -S jdk8-openjdk
sudo pacman -S jdk-openjdk

# install util java to switch version
sudo pacman -S java-runtime-common
archlinux-java status
archlinux-java set java-8-openjdk

# configuration $JAVA_HOME
export JAVA_HOME=/usr/lib/jvm/default-runtime/     
export PATH=$PATH:$JAVA_HOME/bin

# Install Maven
sudo pacman -S maven 

# configuration MAVEN
export M2_HOME=/opt/maven/
export PATH=$PATH:$M2_HOME/bin

# install Intellij
# 1. donwload installer of official page
# 2. unzip:  rm ideaIC-2020.1.1.tar.gz
# 3. copy to folder app: sudo cp -d -r idea-IC-201.7223.91/* /usr/bin/idea
# 4. start from qtile "MOD + d"

# install vs code
sudo pacman -S code


# Command to check TLS certificate connection
 gnutls-cli www.my.webpage.to.test </dev/null

# Install Openssh to remote connection and ssh-keygem
sudo pacman -S openssh
sudo systemctl start  sshd.service # start daemon
ssh localhost # test remote connection



# Install browser-syn to desing web 
sudo npm i -g browser-sync

# Configuration alias in ~/.zshrc
export LOCAL_IP=`ip route get 8.8.8.8 | head -1 | cut -d' ' -f7`                                               
alias serve="browser-sync start -s -f . --no-notify --host $LOCAL_IP --port 9000"

# Encode base64
echo -n 'victor26:12345'| openssl base64 

