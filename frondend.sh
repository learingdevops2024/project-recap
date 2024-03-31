source common.sh

app_dir=/app
component=frontend


Print_Task_Heading "Install Nginx"
dnf install nginx -y &>>$LOG
check_status $?


Print_Task_Heading "copy expence nginx configuration"
cp expence.conf /etc/nginx/default.d/expense.conf  &>>$LOG
check_status $?

App_preReq

Print_Task_Heading "system restart"
systemctl enable nginx &>>$LOG
systemctl restart nginx &>>$LOG
check_status $?