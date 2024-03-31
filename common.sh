LOG=/tmp/expence.log

Print_Task_Heading() {
 echo $1
 echo "########$1##########" &>>$LOG

check_status() {
if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
else
    echo -e "\e[31m FAILURE\e[0m"
     exit 2
fi
}

App_preReq() {
 Print_Task_Heading "cleanup the old content"
 rm -rf ${app_dir} &>>$LOG
 check_status $?

 Print_Task_Heading "Create app directory"
mkdir ${app_dir} &>>$LOG
check_status $?

Print_Task_Heading "download app content"
curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
check_status $?

Print_Task_Heading "Extract app content"
cd ${app_dir} &>>$LOG
unzip /tmp/${component}.zip &>>$LOG
check_status $?
}
