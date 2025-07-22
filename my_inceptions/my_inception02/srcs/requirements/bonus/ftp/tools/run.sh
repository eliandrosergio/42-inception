#!/bin/bash

service vsftpd start

# Adicione o USUÁRIO, altere sua senha e declare-o como dono da pasta wordpress e de todas as subpastas

adduser $FTP_USER --disabled-password

echo "$FTP_USER:$FTP_PWD" | /usr/sbin/chpasswd &> /dev/null
echo "$FTP_USER" | tee -a /etc/vsftpd.userlist &> /dev/null

mkdir /home/$FTP_USER/ftp

chown nobody:nogroup /home/$FTP_USER/ftp
chmod a-w /home/$FTP_USER/ftp

mkdir /home/$FTP_USER/ftp/files

chown $FTP_USER:$FTP_USER /home/$FTP_USER/ftp/files

sed -i -r "s/#write_enable=YES/write_enable=YES/1" /etc/vsftpd.conf
sed -i -r "s/#chroot_local_user=YES/chroot_local_user=YES/1" /etc/vsftpd.conf

echo "
local_enable=YES
allow_writeable_chroot=YES
pasv_enable=YES
local_root=/home/elian/ftp
pasv_min_port=40000
pasv_max_port=40005
userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf

service vsftpd stop

/usr/sbin/vsftpd
