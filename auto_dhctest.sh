#! /bin/sh

mac_prefix="2C:C4:07:00"
inface="eth1"
test_bin="$PWD/dhtest"
tout_sec=10

gen_mac_list () {
	printf "%s\n" $mac_prefix:{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F}{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F}:{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F}{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F}
}

send_dhcp_pkt () {
	local idx=0
	local fail_num=0
	local pass_num=0

	local esc="\033"

	local greenf="${esc}[32m"
	local redf="${esc}[31m"
	local yellowf="${esc}[33m"
	local purplef="${esc}[35m"

	local reset="${esc}[0m"


	for m in `gen_mac_list`; do
		echo ""
		$test_bin -i $inface -T $tout_sec -m $m && pass_num=$(($pass_num+1)) || fail_num=$(($fail_num+1))
		idx=$(($idx+1))
		printf "${purplef}%s${reset} [${yellowf}%5s${reset} ${greenf}%5s${reset} ${redf}%5s${reset} ] ---------------------------\n" \
				`date +'%H:%M:%S'` \
				$idx \
				$pass_num \
				$fail_num
		sleep 1
	done
}

do_main () {
	send_dhcp_pkt
}

do_main

