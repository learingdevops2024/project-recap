source common.sh

mysql_password=$1
app_dir=/usr/share/nginx/html
component=frontend


# if password not provided then we will exit.

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
id expence &>>$LOG
if [ $? -ne 0 ]; then
  useradd expence &>>$LOG
  fi
  check_status $?

Print_Task_Heading "copy backend.service file"
cp backend.service /etc/systemd/system/backend.service file &>>$LOG
check_status $?

App_preReq

Print_Task_Heading "dependencies"
cd /app &>>$LOG
npm install &>>$LOG
check_status $?


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
mysql -h mysql-dev.babysanthoshi.com -uroot -p${mysql_password} < /app/schema/backend.sql &>>/tmp/expence.log
check_status $?