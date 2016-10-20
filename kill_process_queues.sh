#!/bin/sh
################################################################
# Kill des process queues LARAVEL
################################################################

ps -ef |grep '/home/serieall/serieall-dev/artisan queue:work' |grep -v grep
process=$(ps -ef |grep '/home/serieall/serieall-dev/artisan queue:work' |grep -v grep |awk '{print $2}')

printf '%s\n' "$process" | while IFS= read -r line
do
   echo "Kill du process : $line"
   kill -9 $line
   if [ $? -eq 0 ]; then
      echo "Kill OK"
   else
      echo "Kill du process $line ne s'est pas bien terminé"
   fi 
done
