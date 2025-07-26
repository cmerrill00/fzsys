#!/bin/bash

menu_items=(
  "System Summary"
  "CPU Info"
  "Memory Usage"
  "Disk Usage"
  "Disk Partitions"
  "Network Interfaces"
  "Open Ports"
  "Top Processes"
  "Running Services"
  "Active Users"
  "System Uptime"
  "System Logs"
  "Hardware Info"
  "Search"
  "Watch: Top Processes"
  "Watch: Disk Usage"
  "Watch: Network"
  "Help"
  "Exit"
)

choice=$(printf '%s\n' "${menu_items[@]}" | \
  fzf --border --height=80% --layout=reverse \
      --prompt="Select System Info: " \
      --preview='
        case {} in
          "System Summary") echo "CPU:"; lscpu | grep "Model name"; echo; echo "Memory:"; free -h; echo; echo "Disk:"; df -hT | grep -E --color=always "^/|Filesystem"; echo; echo "Uptime:"; uptime ;;
          "CPU Info") lscpu ;;
          "Memory Usage") free -h ;;
          "Disk Usage") df -hT | grep -E --color=always "^/|Filesystem" ;;
          "Disk Partitions") lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT ;;
          "Network Interfaces") ip -br addr show ;;
          "Open Ports") ss -tuln ;;
          "Top Processes") ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 20 ;;
          "Running Services") systemctl list-units --type=service --state=running ;;
          "Active Users") who ;;
          "System Uptime") uptime ;;
          "System Logs") journalctl -n 30 --no-pager | tail -n 30 ;;
          "Hardware Info") lshw -short || echo "lshw not installed" ;;
          "Search") echo "Search for processes, logs, or files";;
          "Watch: Top Processes") echo "Press enter to run watch";;
          "Watch: Disk Usage") echo "Press enter to run watch";;
          "Watch: Network") echo "Press enter to run watch";;
          "Help") echo "Select an option to view system info. Use Search to find processes, logs, or files. Use Watch options for live updating views.";;
          "Exit") echo "Exit the menu";;
          *) echo "No preview available";;
        esac
      ' \
      --preview-window=right:70%:wrap
)

if [[ -z "$choice" ]]; then
  exit 0
fi

case "$choice" in
  "System Summary")
    clear
    echo "CPU:"
    lscpu | grep "Model name"
    echo
    echo "Memory:"
    free -h
    echo
    echo "Disk:"
    df -hT | grep -E --color=always "^/|Filesystem"
    echo
    echo "Uptime:"
    uptime
    ;;
  "CPU Info")
    lscpu | less
    ;;
  "Memory Usage")
    free -h | less
    ;;
  "Disk Usage")
    df -hT | grep -E --color=always "^/|Filesystem" | less
    ;;
  "Disk Partitions")
    lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT | less
    ;;
  "Network Interfaces")
    ip -br addr show | less
    ;;
  "Open Ports")
    ss -tuln | less
    ;;
  "Top Processes")
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 20 | less
    ;;
  "Running Services")
    systemctl list-units --type=service --state=running | less
    ;;
  "Active Users")
    who | less
    ;;
  "System Uptime")
    uptime | less
    ;;
  "System Logs")
    journalctl -n 30 --no-pager | tail -n 30 | less
    ;;
  "Hardware Info")
    lshw -short | less 2>/dev/null || echo "lshw not installed"
    ;;
  "Search")
    read -rp "Enter search term: " term
    echo "Processes matching '$term':"
    ps aux | grep --color=always "$term" | grep -v grep
    echo
    echo "Log lines matching '$term':"
    journalctl --no-pager | grep --color=always "$term" | tail -n 10
    echo
    echo "Files matching '$term':"
    find / -iname "*$term*" 2>/dev/null | head -n 10
    ;;
  "Watch: Top Processes")
    watch -n 1 "ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 20"
    ;;
  "Watch: Disk Usage")
    watch -n 1 "df -hT | sort -k6"
    ;;
  "Watch: Network")
    watch -n 1 "ss -tuln"
    ;;
  "Help")
    clear
    echo "fzsys - System Info Menu"
    echo
    echo "Select an option to view system info."
    echo "Use Search to find processes, logs, or files."
    echo "Use Watch options for live updating views."
    echo "Press Enter on Exit to quit."
    ;;
  "Exit")
    exit 0
    ;;
  *)
    echo "No preview available"
    ;;
esac