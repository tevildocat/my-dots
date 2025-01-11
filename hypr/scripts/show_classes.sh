#!/bin/bash
hyprctl clients | grep -E "class:|initialTitle:|monitor:" | awk '{$1=""; print $0}' | paste - - - | awk '{class=($2 ? $2 : "-"); title=($4 ? $4 : "-"); monitor=($1 ? $1 : "-"); printf "%-25s %-20.20s %-7s\n", class, title, monitor}' | awk 'BEGIN {print "CLASS                     INITIAL TITLE         MONITOR"; print "------------------------- -------------------- -------"} {print}'
