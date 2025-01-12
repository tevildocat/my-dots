#!/bin/bash
export clk=1
pgrep wf-recorder || export clk=0
if [ "$clk" -eq "0" ]
then
fn=~/Видео/screens/$(date +%F_%T).mp4
wf-recorder -g "$(slurp)" --file=$fn -c libx264
dunstify "ЗАПИСЬ ЗАКОНЧЕНА!" "Файл : $fn"
else killall wf-recorder
fi