source common.sh
app_dir=/usr/share/nginx/html
component=frontend


Print_Task_Heading "Install Nginx"
dnf install nginx -y &>>$LOG
check_status $?

cp expence.conf /etc/nginx/default.d/expense.conf  &>>$LOG
Print_Task_Heading "remove Default content"
check_status $?

App_preReq

Print_Task_Heading "system restart"
systemctl enable nginx &>>$LOG
systemctl restart nginx &>>$LOG
check_status $?