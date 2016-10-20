#!/bin/sh

git pull
/home/serieall/scripts/kill_process_queues.sh
cat /dev/null > /home/serieall/serieall-dev/storage/logs/laravel.log
tail -f /home/serieall/serieall-dev/storage/logs/laravel.log
