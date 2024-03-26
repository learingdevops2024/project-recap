echo "Install nodejs"
echo -e "\e[31m Installnodejs server\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
echo "Add directory"
echo -e "\e[31mAdd deirectory\e[0m"
useradd expense
mkdir /app
echo "application code"
echo -e "\e[31mApplication code\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip
cd /app

unzip /tmp/backend.zip
echo" dependencies"
echo -e "\e[31mdependencies\e[0m"
cd /app
npm install
echo " Expense Backend Service"
echo -e "\e[31mbackend srvice\e[0m"
cp vim /etc/systemd/system/backend.service
echo "Load the service."
echo -e "\e[31mload the service\e[0m"
systemctl daemon-reload
systemctl enable backend
systemctl start backend
echo "Install mysql"
echo -e "\e[31minstall mysql\e[0m"
dnf install mysql -y
echo "Load Schema"
echo -e "\e[31m load schema\e[0m"
mysql -h <172.31.93.124> -uroot -pExpenseApp@1 < /app/schema/backend.sql