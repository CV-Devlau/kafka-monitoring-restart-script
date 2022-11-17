# kafka-monitoring-restart-script
创建linux定时任务监控kafka进程，进行重启

1. 运行shell脚本
2. 输入kafka所在目录 例如：/usr/local/kafka_01_10
3. 脚本会在kafka目录下创建一个名为`kafkaRestart.sh`的shell脚本，其作用是检测进程中有没有kafka进行，如果没有则重启
4. 在crontab文件中创建定时任务
