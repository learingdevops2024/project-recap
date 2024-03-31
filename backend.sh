source common.sh

mysql_password=$1

# if password not provided then we will exit

if [ -z "${mysql_password}" ];then
  echo Input password missing
  exit 1
  fi

Print_Task_Heading "Install nodejs"
echo -e "\e[31m Installnodejs server\e[0m"
dnf module disable nodejs -y &>>/tmp/expence.log
dnf module enable nodejs:20 -y &>>/tmp/expence.log
dnf install nodejs -y &>>/tmp/expence.log
check_status $?


Print_Task_Heading "Add directory"
echo -e "\e[32mAdd directory\e[0m"
useradd expense &>>/tmp/expence.log
cp backend.service /etc/systemd/system/backend.service file
rm -rf /app &>>/tmp/expence.log
mkdir /app &>>/tmp/expence.log
check_status $?

Print_Task_Heading "application code"
echo -e "\e[36mApplication code\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expence.log
cd /app &>>/tmp/expence.log
unzip /tmp/backend.zip &>>/tmp/expence.log
check_status $?


Print_Task_Heading "dependencies"
echo -e "\e[33mdependencies\e[0m"
cd /app &>>/tmp/expence.log
npm install &>>/tmp/expence.log
check_status $?
 cp vim /etc/systemd/system/backend.service

Print_Task_Heading "Load the service"
echo -e "\e[34mload the service\e[0m"
systemctl daemon-reload &>>/tmp/expence.log
check_status $?
Print_Task_Heading "system start"
systemctl enable backend &>>/tmp/expence.log
systemctl start backend &>>/tmp/expence.log
check_status $?

Print_Task_Heading "Install mysql"
echo -e "\e[35minstall mysql\e[0m"
dnf install mysql -y &>>/tmp/expence.log
check_status $?

Print_Task_Heading "Load Schema"
echo -e "\e[36m load schema\e[0m"
mysql -h 172.31.88.222 -uroot -p${mysql_password} < /app/schema/backend.sql &>>/tmp/expence.log
check_status $?