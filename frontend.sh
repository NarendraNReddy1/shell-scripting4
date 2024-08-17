#!/bin/bash


dnf install nginx -y &>>LOG_FILE
VALIDATE $? "install nginx"

systemctl enable nginx &>>LOG_FILE
VALIDATE $? "nable nginx"

systemctl start nginx &>>LOG_FILE
VALIDATE $? "start nginx"

rm -rf /usr/share/nginx/html/* &>>LOG_FILE
VALIDATE $? "HTMl Removal" 

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>LOG_FILE
VALIDATE $? "temp code" 

cd /usr/share/nginx/html &>>LOG_FILE
VALIDATE $? "moved to html"

unzip /tmp/frontend.zip &>>LOG_FILE
VALIDATE $? "Unzip" 

systemctl restart nginx &>>LOG_FILE
VALIDATE $? "Restart nginx"

