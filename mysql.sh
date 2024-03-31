source common.sh
mysql_password=$1
if [ -z "${mysql_password}" ]; then
  echo Input  Password Missing
  exit 1
fi

Print_Task_Heading "Install mysql server"
dnf install mysql-server -y &>>$LOG
check_status $?

Print_Task_Heading "system start mysql"
systemctl enable mysqld &>>$LOG
systemctl start mysqld &>>$LOG
check_status $?

 Print_Task_Heading "set password"
mysql_secure_installation --set-root-pass ${mysql_password} &>>$LOG
check_status $?