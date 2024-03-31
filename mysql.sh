source common.sh

Print_Task_Heading "Install mysql server"
dnf install mysql-server -y &>>$LOG
check_status $?

Print_Task_Heading "system start mysql"
systemctl enable mysqld &>>$LOG
systemctl start mysqld &>>$LOG
check_status $?

 Print_Task_Heading "set password"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOG
check_status $?