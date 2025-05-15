
# 换镜像源
tar -czf ~/atp.tar.xz /etc/apt/
curl -sSL https://linuxmirrors.cn/main.sh | bash
#sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
apt update

# 安装网络基础工具
apt install iputils-ping iproute2 dnsutils telnet net-tools xz-utils -y
# 安装常用工具
apt install vim git -y
# 安装 fastfetch
#sudo apt install fastfetch -y




# 配置 ssh 免密登录
echo "
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJRvnvF3SraJgZeMzU3D+wNwjpw2A+E4r0ZTbjEVLMjt andyf@Redmi-6800H" >> ~/.ssh/authorized_keys
ssh-keygen -t ed25519 -C "OneCloud-Blue" -f ~/.ssh/id_ed25519 -N ""
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

sudo sed -i 's/^#PasswordAuthentication yes$/PasswordAuthentication no/' /etc/ssh/sshd_config
service ssh restart



apt install zsh -y
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
chsh -s /bin/zsh




# 将别名追加到 .bash_alias 文件
SHELL_NAME=$(basename "$SHELL")
SHRC_FILE=.${SHELL_NAME}rc
ALIAS_FILE=.${SHELL_NAME}_aliases
touch "$ALIAS_FILE"
{
    echo "alias ll='ls -al'"
    echo "alias la='ls -A'"
    echo "alias l='ls -CF'"
    echo "alias grep='grep --color=auto'"
    echo "alias dps='docker ps -a --format \"容器ID：{{.ID}}\\n名称：{{.Names}}\\n镜像：{{.Image}}\\n状态：{{.Status}}\\n端口：{{.Ports}}\\n\"' "
    echo "alias kernel="uname -r | sed 's/[1-9]\+[0-9]*\.[0-9]\+\.[0-9]\+-//' | sed 's/[1-9]\+[0-9]*\.[0-9]*\-rc[0-9]\+-//'""
    echo "alias showip='ip -4 addr show scope global | grep inet | awk \"{print $2}\" | cut -d\"/\" -f1 | sed \"s/    inet //g\" | paste -s -d, -'"
} > "$ALIAS_FILE"

# 若 .bashrc 未包含 .bash_alias 则添加
if ! grep -qF "$ALIAS_FILE" ~/$SHRC_FILE; then
    echo "[ -f $ALIAS_FILE ] && . ~/$ALIAS_FILE" >> ~/$SHRC_FILE
fi



git config --global alias.bh branch
git config --global alias.ls status
git config --global alias.ck checkout
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global init.defaultBranch main
git config --global core.autocrlf input
git config --global core.quotepath false
git config --global push.autoSetupRemote true


# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://docker.hevc.cc/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://bocker.hevc.cc/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y


sudo tee /etc/docker/daemon.json <<EOF
{
    "registry-mirrors": ["https://docker.hevc.cc"],
    "ipv6": true,
    "fixed-cidr-v6": "fd00::/80"
}
EOF






# ln -s /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
# echo "Asia/Shanghai" > /etc/timezone
# timedatectl status

# 配置定时任务
mkdir -p ~/backup && chmod 644 ~/backup
0 0 * * * cd ~ && XZ_OPT=-1 tar -cJf "./backup/persistence-$(date +\%Y\%m\%d-\%H\%M\%S).tar.xz" persistence/


# rsync -avzP -e "C:\Users\AndyF\scoop\apps\cwrsync\6.4.2\bin\ssh.exe" root@oneb.l.hevc.cc:~/backup/ ./















