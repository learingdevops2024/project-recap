Print_Task_Heading"Install nginx"
dnf install nginx -y
echo $?
Print_Task_Heading"system start nginx"
 systemctl enable nginx
systemctl start nginx
echo $?
cp vim /etc/nginx/default.d/expense.conf
Print_Task_Heading"Remove Default content"
rm -rf /usr/share/nginx/html/*
echo $?
Print_Task_Heading"Download frontend content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
echo $?
Print_Task_Heading"Extract frontend content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
echo $?
Print_Task_Heading"system restart"
systemctl restart nginx
echo $?