echo "Install nodejs"
echo -e "\e[31m Installnodejs server\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
echo $?


echo "Add directory"
echo -e "\e[32mAdd deirectory\e[0m"
useradd expense
cp backend.service /etc/systemd/system/backend.service
rm -rf /app
mkdir /app
echo $?

echo "application code"
echo -e "\e[36mApplication code\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip
cd /app
unzip /tmp/backend.zip
echo $?


echo" dependencies"
echo -e "\e[33mdependencies\e[0m"
cd /app
npm install
echo $?

echo " Expense Backend Service"
echo -e "\e[32mbackend srvice\e[0m"
echo $?

echo "Load the service."
echo -e "\e[34mload the service\e[0m"
systemctl daemon-reload
systemctl enable backend
systemctl start backend
echo $?

echo "Install mysql"
echo -e "\e[35minstall mysql\e[0m"
dnf install mysql -y
echo $?

echo "Load Schema"
echo -e "\e[36m load schema\e[0m"
mysql -h <172.31.94.46> -uroot -pExpenseApp@1 < /app/schema/backend.sql
echo $?