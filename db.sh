#!/bin/bash

echo "Enter password:ExpenseApp@1"
read -s db_root_password

source ./common.sh

check_root

dnf install mysql-server -y &>>LOG_FILE
#VALIDATE $? "Installation of mysql-server"


systemctl enable mysqld &>>LOG_FILE
#VALIDATE $? "Enable mysqld"

systemctl start mysqld &>>LOG_FILE
#VALIDATE $? "Start mysqld"

mysql -h db.narendra.shop -uroot -p${db_root_password} -e "SHOW DATABASES" &>>LOG_FILE

if [ $? -eq 0 ]
then 
    echo -e "Password already set $Y SKIPPING $N"
else 
mysql_secure_installation --set-root-pass ${db_root_password} &>>LOG_FILE
#VALIDATE $? "db password"
fi


