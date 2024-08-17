USER_ID=$(id -u)
SCRIPT_NAME=$(echo $0  | cut -d "." -f1)
TIMESTAMP=$(date +%F-%M-%H-%S)
LOG_FILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

# if [ USER_ID -ne 0 ]
# then 
#     echo "Please be a super user"
#     exit 1
# then 
#     echo "You are already a super user"
# fi


check_root(){
    if [ USER_ID -ne 0 ]
    then 
        echo "Please be a super user"
        exit 1
    then 
        echo "You are already a super user"
    fi    
}


VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2...$R FAILURE $N"
    else 
        echo -e "$2...$G SUCCESS $N" 
    fi
}
