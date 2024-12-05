#!/bin/bash
arc=$(uname -a)
cpu=$(lscpu | grep "Socket(s)" | awk '{print $2}')
vcpu=$(lscpu | grep "CPU(s)" | awk 'NR == 1{print $2}')
memuse=$(free -m | awk '$1 == "Mem:" {print $3"/"$2"MB"}')
percent=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
diskusemb=$(df -m --total | grep "total" | awk '{print $3}')
diskusegb=$(df -BG --total | grep "total" | awk '{print $2"b"" " "("$5")"}')
cpuload=$(top -bn1 | grep "%Cpu" | awk '{printf("%.1f%%"), $1 + $3}')
lastboot=$(who -b | awk '{print $3" "$4}')
lvmuse=$(if lsblk | grep "lvm" | awk 'N==1{print "true"}'; then echo "yes"; else echo "no"; fi)
conecttcp=$(ss -t | grep "ESTAB" | wc -l)
userlog=$(who | wc -l)
ipaddr=$(hostname -I | awk '{print $1}')
macaddr=$(ip link show | grep "link/ether" | awk 'NR == 1{print $2}')
sudocmd=$(journalctl _COMM=sudo | grep "COMMAND" | wc -l)
wall "	#Architecture: $arc
	#CPU physical: $cpu
	#vCPU: $vcpu
	#Memory Usage: $memuse ($percent%)
	#Disk Usage: $diskusemb/$diskusegb
	#CPU load: $cpuload
	#Last boot: $lastboot
	#LVM use: $lvmuse
	#Connections TCP : $conecttcp ESTABLISHED
	#User log: $userlog
	#Network: IP $ipaddr ($macaddr)
	#Sudo : $sudocmd cmd"
