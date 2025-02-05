#!/bin/bash

function check_privileges() {
	# Args:
	# 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If user is root.

	local LOG="$1"

	if [[ "$(id -u)" -eq 0 ]]; then
		if [[ "$LOG"  == "true" ]]; then
			echo -e "[*] User is root.\n"
		fi

		return
	else
		echo -e "[!] Error: This script requires root privileges to work."
		exit 1
	fi
}

function main() {
	# [*] MAIN FUNCTION [*]
	#
	# Provides functions to install or remove tC.
	
	local OPTION

	echo "+------ Welcome to theUnixManager-bash installer ------+"
	echo -e "\nOptions:"
	echo "    1 - Install theUnixManager."
	echo "    2 - Remove theUnixManager."
	echo -e "    3 - Update theUnixManager.\n"

	read -rp "[==>] " OPTION
	if [[ "$OPTION" == "1" ]]; then
		install_theunixmanager
	elif [[ "$OPTION" == "2" ]]; then
		remove_theunixmanager
	elif [[ "$OPTION" == "3" ]]; then
		update_unstable_repository
	else
		echo "[!] Invalid option: $OPTION"
		return 1
	fi
}

function list_of_commands() {
	# Helping ourselves.
	
	echo "Help page:"
	echo " -h/--help - lists commands."
	echo " -i/--install - Installs theUnixManager."
	echo " -r/--remove - Removes theUnixManager."
	echo " -u/--update - Downloads unstable updates from theUnixManager-bash git repository."	
}

function install_theunixmanager() {
	# Moves src/the_unix_manager.sh to /usr/bin
	# Creates /etc/theunixmanager/bash/ and moves VERSION.txt.
	
	check_privileges

	if [[ -f "src/the_unix_manager.sh" ]]; then
		cp src/the_unix_manager.sh /usr/bin/the_unix_manager.sh && echo "[<==] Moving theUnixManager-bash to /usr/bin..."
	fi

	if [[ -f "VERSION.txt" ]]; then
		mkdir /etc/theunixmanager && echo "[<==] Moving theUnixManager configurations to /etc/theunixmanager/bash..."
		mkdir /etc/theunixmanager/bash
		cp VERSION.txt /etc/theunixmanager/bash/VERSION.txt
	fi
	
	touch /etc/theunixmanager/bash/EDITOR.txt

	echo "[*] Success!"

}

function remove_theunixmanager() {
	# Removes the_unix_manager.sh from /usr/bin
	# Removes /etc/theunixmanager/bash
	
	check_privileges

	if [[ -f "/usr/bin/the_unix_manager.sh" ]]; then
		rm /usr/bin/the_unix_manager.sh
	fi

	if [[ -d "/etc/theunixmanager/bash" ]]; then
		rm -rf /etc/theunixmanager/bash
	fi

	echo "[*] Success!"

}

function debug() {
	# Debugging function for checking where theUnixManager and its configuration are located.
	# Sometimes can be very helpful, especially when you trying to port tC on new distros
	#
	# On Alpine Linux needs 'util-linux' package installed.
	
	echo -e "\ntheUnixManager:"
	whereis the_unix_manager.sh
	echo -e "\ntheUnixManager configurations:"
	whereis theunixmanager
}

function parse_args() {
	if [[ $# -eq 0 ]]; then
		main
		return
	fi

	while [[ $# -gt 0 ]]; do
		case "$1" in
			"-h"|"--help")
				list_of_commands
				exit 0
				;;
			"-i"|"--install")
				install_theunixmanager
				exit 0
				;;
			"-r"|"--remove")
				remove_theunixmanager
				exit 0
				;;
			"-d"|"--debug")
				debug
				exit 0
				;;
			*)
				echo "[!] Error: Unknown argument: $1"
				exit 1
				;;
		esac
	done
}

parse_args "$@"
