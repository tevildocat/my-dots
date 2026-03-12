#!/bin/bash
export clk=1
pgrep wf-recorder || export clk=0
if [ "$clk" -eq "0" ]
then
    fn=~/Видео/screens/$(date +%F_%T).mp4
    wf-recorder -g "$(slurp)" --file=$fn -c libx264
    notify-send "Запись экрана" "Файл сохранён: $(basename "$fn")" -i camera-video
else 
    killall wf-recorder
    notify-send "Запись экрана" "Запись остановлена" -i media-playback-stop
fi