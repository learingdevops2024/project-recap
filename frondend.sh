source common.sh


Print_Task_Heading "Install Nginx"
dnf install nginx -y &>>$LOG
check_status $?

cp vim /etc/nginx/default.d/expense.conf  &>>$LOG
Print_Task_Heading "Remove Default content"
rm -rf /usr/share/nginx/html/* &>>$LOG
check_status $?

Print_Task_Heading  "Download frontend content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
check_status $?

Print_Task_Heading  "Extract frontend content"
cd /usr/share/nginx/html &>>$LOG
unzip /tmp/frontend.zip &>>$LOG
check_status $?

Print_Task_Heading  "system restart"
systemctl restart nginx &>>$LOG
check_status $?