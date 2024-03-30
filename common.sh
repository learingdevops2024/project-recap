Print_Task_Heading () {
 echo $1
 echo "########$1##########" &>>/tmp/expence.log
 }
check_status () {
  if [$1 -eq 0]; then
    echo -e "\e[32mSUCCESS\e[0m"
    else
      echo -e "\e[31m FAILURE\E[0m"
      exit2
      fi
}
