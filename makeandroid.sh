#!/bin/bash
# This is our first script.
# osascript -t "title-name" -x bash -c "sh /bin/ls;exec bash;"
osascript -e 'tell application "Terminal" to do script "cd /Users/mt/Work/ai-peilian;make android;make android; make android;open -a \"android studio\""'