#!/bin/bash

source ./common.sh 

check_root

echo "Enter DB password:::ExpenseApp@1"
read -s db_root_password


dnf module disable nodejs -y &>>LOG_FILE
VALIDATE $? "Disable nodejs"

dnf module enable nodejs:20 -y &>>LOG_FILE
VALIDATE $? "Enable nodejs"

dnf install nodejs -y &>>LOG_FILE
VALIDATE $? "Install nodejs"


id expense &>>LOG_FILE
VALIDATE $? "id expense"

if [ $? -eq 0 ]
then 
    echo "user already exists"
else 
    useradd expense &>>LOG_FILE
    VALIDATE $? "expense user addition"
fi

mkdir -p /app &>>LOG_FILE
VALIDATE $? "App directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>LOG_FILE
VALIDATE $? "Code in tmp"

cd /app &>>LOG_FILE
rm -rf /app/*
VALIDATE $? "Move code in app"

unzip /tmp/backend.zip &>>LOG_FILE
VALIDATE $? "unzip"

npm install &>>LOG_FILE
VALIDATE $? "npm install"

cp -rf /home/ec2-user/shell-scripting4/backend.service /etc/systemd/system/backend.service &>>LOG_FILE
VALIDATE $? "Copy"

systemctl daemon-reload &>>LOG_FILE
VALIDATE $? "Daemon reload"

systemctl start backend &>>LOG_FILE
VALIDATE $? "Start backend"

systemctl enable backend &>>LOG_FILE
VALIDATE $? "Enable backend"









