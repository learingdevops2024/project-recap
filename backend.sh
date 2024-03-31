source common.sh

mysql_password=$1

# if password not provided then we will exit

if [ -z "${mysql_password}" ];then
  echo Input password missing
  exit 1
  fi

Print_Task_Heading "Install nodejs"
dnf module disable nodejs -y &>>$LOG
dnf module enable nodejs:20 -y &>>$LOG
dnf install nodejs -y  &>>$LOG
check_status $?


Print_Task_Heading "Add directory"
useradd expense  &>>$LOG
cp backend.service /etc/systemd/system/backend.service file &>>$LOG
rm -rf /app  &>>$LOG
mkdir /app  &>>$LOG
check_status $?

Print_Task_Heading "application code"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$LOG
cd /app  &>>$LOG
unzip /tmp/backend.zip &>>$LOG
check_status $?


Print_Task_Heading "dependencies"
cd /app &>>$LOG
npm install &>>$LOG
check_status $?
 cp vim /etc/systemd/system/backend.service

Print_Task_Heading "Load the service"
systemctl daemon-reload &>>$LOG
check_status $?

Print_Task_Heading "system start"
systemctl enable backend &>>$LOG
systemctl start backend &>>$LOG
check_status $?

Print_Task_Heading "Install mysql"
dnf install mysql -y &>>$LOG
check_status $?

Print_Task_Heading "Load Schema"
mysql -h 172.31.88.222 -uroot -p${mysql_password} < /app/schema/backend.sql &>>/tmp/expence.log
check_status $?