#!/bin/bash

SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

function select_option() {
    OLDIFS="$IFS"
    IFS="|"
    local description=$1
    local options=($2)
    local selected=0
    local option_length=${#options[@]}

    function show_select() {
        clear
        echo "$description"
        local i=0
        for option in "${options[@]}"; do
            if [ $i -eq $selected ]; then
                echo -e "\033[32m●  $option\033[0m"
            else
                echo -e "○  $option"
            fi
            i=$((i + 1))
        done
    }

    while true;do
       show_select
       read -rs -n 1
       case "$REPLY" in
           A) selected=$((selected-1)) ;;
           B) selected=$((selected+1)) ;;
           "") break ;;
       esac
       if [ $selected -lt 0 ]; then
           selected=$((option_length - 1))
       elif [ $selected -ge ${#options[@]} ]; then
           selected=0
       fi
    done

    SELECTED_INDEX=$selected
}

select_option "Select a workflow to view running state:" "Show copy.yml running state|Show sync.yml running state"

clear

echo "Waiting..."

if [ $SELECTED_INDEX -eq 0 ]; then
    ./exec.sh status -w copy.yml
elif [ $SELECTED_INDEX -eq 1 ]; then
    ./exec.sh status -w sync.yml
fi