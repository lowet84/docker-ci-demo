#!/bin/bash
clear
TEXT=$(echo $0 | sed -En "s/splash.sh/text_splash.txt/p")
cat $TEXT | cut -c1-200

