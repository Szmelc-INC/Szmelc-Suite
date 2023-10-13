#!/bin/bash
# Kill process by RegEx in CLI
# /.core/bin utils by Szmelc

clear
logging='Y' # Change to 'N' to disable logging

log() {
    if [ "$logging" == "Y" ]; then
        # Ensure logs directory exists
        mkdir -p logs
        local timestamp=$(date '+%Y%m%d%H%M%S')
        echo "$1" >> "logs/log_${timestamp}.txt"
    fi
}

fetch_processes() {
    local regex="$1"
    local processes
    processes=$(ps aux | awk -v pattern="$regex" '$0 ~ pattern {print $2 " " $11}' | head -20)

    options=()
    actions=()

    while read -r line; do
        pid=$(echo $line | cut -d ' ' -f1)
        procname=$(echo $line | cut -d ' ' -f2)
        options+=("$procname (PID: $pid)")
        actions+=("$pid")
    done <<< "$processes"
}

kill_process() {
    local pid="${actions[$selected]}"
    kill "$pid"
    echo "Process with PID $pid has been killed."
    log "Process with PID $pid has been killed."
}

display_help() {
    clear
    cat doc.md
    read -p "Press any key to return to the menu..." -n1
    display_menu
}

display_menu() {
    clear
    echo ""
    echo " ╔══════════════════════════╗"
    echo " ║ [Process to Kill]: {PID} ║"
    echo " ╚══════════════════════════╝"
    echo ""
    for ((i=0; i<${#options[@]}; i++)); do
        if [ $i -eq $selected ]; then
            echo " > ${options[$i]}"
        else
            echo "   ${options[$i]}"
        fi
    done
    echo ""
    echo " ╔═════════════════════════════════════════════════╗"
    echo " ║ Kill: [e] ║ Search: [s] ║ Quit: [q] ║ Help: [h] ║"
    echo " ╚═════════════════════════════════════════════════╝"
    echo ""
}

echo "" && figlet " KillRegX " && echo ""
read -p " RegEx to search for processes: " regex
fetch_processes "$regex"
selected=0
display_menu

while true; do
    read -rsn1 input

    case $input in
        'A') # Up arrow
            if [ $selected -gt 0 ]; then
                selected=$((selected - 1))
            fi
            ;;
        'B') # Down arrow
            if [ $selected -lt $(( ${#options[@]} - 1 )) ]; then
                selected=$((selected + 1))
            fi
            ;;
        'q') # q key
            clear && echo " Thanks for choosing Szmelc <3 " && sleep 1 && exit 0
            ;;
        'e') # e key
            kill_process
            read -p "Press Enter to continue..."
            fetch_processes "$regex"
            selected=0
            ;;
        's') # s key
            read -p "Enter RegEx to search for processes: " regex
            fetch_processes "$regex"
            selected=0
            ;;
        'h') # h key
            display_help
            ;;
    esac
    display_menu
done

