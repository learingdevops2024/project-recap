echo "Install mysql server"
echo -e "\e[31m Installmysql server\e[0m"
dnf install mysql-server -y
echo $?
echo "system start mysqld"
echo -e "\e[31m start mysqld\e[0m"
systemctl enable mysqld
systemctl start mysqld
echo $?
echo "set password"
echo -e "\e[31m set password\e[0m"

mysql_secure_installation --set-root-pass ExpenseApp@1
echo $?