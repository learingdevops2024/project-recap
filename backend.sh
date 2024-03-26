echo "Install nodejs"
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
echo "Add directory"
useradd expense
mkdir /app
echo "application code"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip
cd /app

unzip /tmp/backend.zip
echo" dependencies"
cd /app
npm install
echo " Expense Backend Service"
cp vim /etc/systemd/system/backend.service
echo "Load the service."
systemctl daemon-reload
systemctl enable backend
systemctl start backend
echo "Install mysql"
dnf install mysql -y
echo "Load Schema"
mysql -h <172.31.93.124> -uroot -pExpenseApp@1 < /app/schema/backend.sql