@echo off 

rem set utf-8 
chcp 65001

rem zookeeper启动脚本进程名称
set zkName=start-zookeeper
rem zookeeper启动脚本进程名称
set kafkaName=start-kafka
set suffix =.bat
rem kafka 目录
set KafkaPath=D:\environment\kafka_2.13-3.2.0
rem zookeeper目录
set ZookeeperPath=D:\environment\kafka_2.13-3.2.0
set kafkaLogPath=D:\tmp\kafka-logs
set /a kafkaErrorCount=0
 
title Kafka进程监控
 
cls
 
echo.
 
echo 进程监控开始……
 
echo.
 
 
:startjc
   rem tasklist 同时查找服务
   rem qprocess|findstr /i %AppName% >nul 
   tasklist /V |findstr /i %zkName% >nul
 
   rem 变量errorlevel的值等于0表示查找到进程，否则没有查找到进程
 
   if %errorlevel%==0 (
 
         echo ^>%date:~0,10% %time:~0,8% Zookeeper程序正在运行……
 
    )else (

           echo ^>%date:~0,10% %time:~0,8% 没有发现Zookeeper进程
 
           echo ^>%date:~0,10% %time:~0,8% 正在重新启动Zookeeper
 
           start cmd /c "cd /d %ZookeeperPath%&&.\%zkName%%suffix% 2>nul"
           
           timeout /nobreak /t 5 >nul

           goto startjc
 
   )
   

   

   tasklist /V |findstr /i %kafkaName% >nul

   if %errorlevel%==0 (

         echo ^>%date:~0,10% %time:~0,8% Kafka正在运行……
         set /a kafkaErrorCount=0
 
    )else (
rem 用来删除kafka日志目录，windows下kafka可能会启动失败，需要删除log目录，有需要的删除注释，谨慎开启
rem	 set /a kafkaErrorCount=%kafkaErrorCount%+1
rem	echo %kafkaErrorCount%
rem           if %kafkaErrorCount% GTR 1 (
rem	 rd /s/q %kafkaLogPath%
rem	echo %kafkaErrorCount%
rem           )
 
           echo ^>%date:~0,10% %time:~0,8% 没有发现Kafka进程
 
           echo ^>%date:~0,10% %time:~0,8% 正在重新启动Kafka
 
           start cmd /c "cd /d %KafkaPath%&&.\%kafkaName%%suffix% 2>nul"
 
   )
   rem 用ping命令来实现延时运行
 
   timeout /nobreak /t 60
 
   goto startjc
 
echo on