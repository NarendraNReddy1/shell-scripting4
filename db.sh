#!/bin/bash


source ./common.sh

check_root

dnf install mysql-server -y &>>LOG_FILE
VALIDATE $? "Installation of mysql-server"


systemctl enable mysqld &>>LOG_FILE
VALIDATE $? "Enable mysqld"

systemctl start mysqld &>>LOG_FILE
VALIDATE $? "Start mysqld"

mysql -h db.narendra.shop -uroot -pExpenseApp@1 -e "SHOW DATABASES" &>>LOG_FILE

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>LOG_FILE
VALIDATE $? "Start mysqld"
