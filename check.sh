#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

MAIL_TO="woods.dai.biz@gmail.com"
MAIL_FROM="wood.dai.biz@gmail.com"
SUBJECT="【cron】グローバルIPアドレス変更通知"

DATE=`date`

PRE=`cat $SCRIPT_DIR/global_ip.txt`
GIP=`curl -s inet-ip.info`

send_mail() {
cat << EOD | /usr/sbin/sendmail -t
From: ${MAIL_FROM}
To: ${MAIL_TO}
Subject: ${SUBJECT}
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit

更新日時: ${DATE}
グローバルIPアドレスが変更されました。
${BODY}

EOD
}

if [ ${GIP} != ${PRE} ]; then
    BODY=`cat << EOD
old: ${PRE}
now: ${GIP}
EOD
`
    send_mail
    echo $GIP > $SCRIPT_DIR/global_ip.txt
fi

# END
