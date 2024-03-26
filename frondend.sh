echo "Install Nginx"
dnf install nginx -y
echo $?
echo "system start nginx"
 systemctl enable nginx
systemctl start nginx
echo $?
cp vim /etc/nginx/default.d/expense.conf
echo "Remove Default content"
rm -rf /usr/share/nginx/html/*
echo $?
echo "Download frontend content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
echo $?
echo "Extract frontend content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
echo $?
echo "system restart"
systemctl restart nginx
echo $?