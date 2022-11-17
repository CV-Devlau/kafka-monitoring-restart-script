#!/bin/bash
echo "请输入kafka目录(例 /usr/local/kafka_2.12-2.0.0)"
read dir

cat>$dir/kafkaRestart.sh<<EOF
#!/bin/bash
source /etc/profile
EOF
echo "proc_dir=$dir" $dir/kafkaRestart.sh

cat>>$dir/kafkaRestart.sh<<EOF
pid=0

n=\`ps -ef | grep kafka | grep -v grep |wc -l\`
num=\$?
proc_id()
{
	pid=\`ps -ef | grep kafka | grep -v grep | awk '{print \$2}'\`
}
 
if [ \$num -eq 0 ]
then
	$dir/bin/kafka-server-stop.sh 
	nohup $dir/bin/kafka-server-start.sh -daemon $dir/config/server.properties > $dir/kafka.log &
proc_id
echo "server down restart..." >> $dir/kafka_reStart.log
echo \${pid}, \`date\` >> $dir/kafka_reStart.log
fi
EOF
/sbin/service crond start
systemctl enable crond
cat>>/etc/crontab<<EOF
*/1 * * * * root sh $dir/kafkaRestart.sh
EOF
