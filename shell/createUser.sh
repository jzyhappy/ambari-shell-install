#create user
groupadd $USER
useradd -g $USER -d /home/$USER $USER
#set password
echo $PASSWORD | passwd --stdin $USER
#set sudo
cp /etc/sudoers /etc/sudoers_bak
echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
