#!/bin/bash
#
# ---------------------------------------
# This is theUnixManager - ultimate package manager && init system handling library
# made by Archetypum that simplifies interaction with UNIX systems and creation of system-related bash scripts.
#
# Archetypum: (https://github.com/Archetypum)
# Github repo link: (https://github.com/Archetypum/theUnixManager)
# Real usage example: (https://github.com/Archetypum/theSuffocater)
#
# TODO:
#    * add logging functionality arguments.
#    * test this on more systems.
#    * add more methods to the package managers.
#    * many more?
# 
# theUnixManager is licensed by GNU Lesser General Public License v3.
# Date: 18.10.2024
# ---------------------------------------

# ANSI Color codes and text formating:
declare BLACK="\033[90m"
declare WHITE="\033[97m"
declare YELLOW="\033[93m"
declare ORANGE="\033[38;5;214m"
declare BLUE="\033[94m"
declare CYAN="\e[0;36m"
declare PURPLE="\033[95m"
declare GREEN="\033[92m"
declare RED="\033[91m"

declare BG_BLACK="\033[40m"
declare BG_RED="\033[41m"
declare BG_GREEN="\033[42m"
declare BG_ORANGE="\033[43m"
declare BG_BLUE="\033[44m"
declare BG_MAGENTA="\033[105m"
declare BG_CYAN="\033[46m"
declare BG_WHITE="\033[47m"

declare BOLD="\033[1m"
declare UNDERLINE="\033[4m"
declare REVERSED="\033[7m"
declare ITALIC="\033[3m"
declare CROSSED_OUT="\033[9m"
declare RESET="\033[0m"

# GNU/Linux operating systems:
declare -a DEBIAN_BASED=(
	"debian" "ubuntu" "xubuntu" "linuxmint" "lmde" "trisquel" "devuan" "kali" "parrot" "pop" "elementary"
	"mx" "antix" "crunchbag" "crunchbag++" "pureos" "deepin" "zorin" "peppermintos" "lubuntu" "kubuntu" "wubuntu"
	"steamos" "astra" "tails" "ututos" "ulteo" "aptosid" "canaima" "corel" "dreamlinux" "elive" "finnix" "gibraltar"
	"gnulinex" "kanotix" "kurumin" "linspire" "maemo" "mepis" "vyatta" "solusos" "openzaurus" "cutefishos"
)

declare -a ARCH_BASED=(
	"arch" "artix" "manjaro" "endeavouros" "garuda" "parabola" "hyperbola" "archbang" "blackarch" "librewolf"
	"chakra" "archex" "archman" "arco" "bluestar" "chimeraos" "instantos" "kaos" "rebornos" "archhurd" "cyberos"
)

declare -a ALPINE_BASED=(
	"alpine" "postmarket"
)

declare -a GENTOO_BASED=(
	"gentoo" "pentoo" "funtoo" "calculate" "chromeos" "vidalinux" "knopperdisk" "gentoox" "sabayon" "chromiumos"
	"tinhatlinux" "ututo"
)

declare -a VOID_BASED=(
	"void" "argon" "shikake" "pristine"
)

declare -a DRAGORA_BASED=(
	"dragora"
)

declare -a SLACKWARE_BASED=(
	"slackware" "salixos" "simplelinux" "basiclinux" "frugalware" "austrumi" "hostgis" "kateos" "mulinux"
	"nimblex" "platypux" "slackintosh" "slax" "supergamer" "topologilinux" "vectorlinux" "wolvix" "zenwalk" "zipslack"
)

declare -a FEDORA_BASED=(
	"fedora" "mos" "rocky"
)

declare -a CENTOS_BASED=(
	"centos"
)

declare -a GUIX_BASED=(
	"guix"
)

# BSD UNIX operating systems:
declare -a FREEBSD_BASED=(
	"freebsd" "midnightbsd" "ghostbsd" "bastillebsd" "cheribsd" "dragonflybsd" "trueos" "hardenedbsd" "hellosystem"
	"truenas" "nomadbsd" "clones" "junosos" "xigmanas" "opnsense" "pfsense" "cellos" "orbisos" "zrouter" "ulbsd" "ravynos"
)

declare -a OPENBSD_BASED=(
	"openbsd" "adj" "libertybsd" "bitrig" "bowlfish" "ekkobsd" "embsd" "fabbsd" "fuguita" "marbsd" "microbsd"
	"miros" "olivebsd" "psygnat" "quetzal" "sonafr" "hyperbolabsd"
)

declare -a NETBSD_BASED=(
	"netbsd" "blackbsd" "edgebsd" "seos" "os108" "jibbed"
)

function the_unix_manager_version() {
    	# Returns:
	# 	str: theUnixManager version.

	if [[ -f "VERSION.txt" ]]; then
		local VERSION
		VERSION=$(cat VERSION.txt)
		echo "$VERSION"
	else
		echo -e "${RED}[!] Error: 'VERSION.txt' file not found.\nBroken installation?${RESET}"
	fi
}

function the_unix_manager_tester() {
	# Autotests.
	#
	# Returns:
	# 	Nothing.

	echo -e "theUnixManager version: $(the_unix_manager_version)\n"
	
	declare -A TEST_RESULTS
	local INIT_SYSTEM
	local DISTRO
	
	INIT_SYSTEM=$(get_init_system)
	DISTRO=$(get_user_distro)

	echo "user distro: $DISTRO"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["get_user_distro"]=true
	else
		TEST_RESULTS["get_user_distro"]=false
	fi
	
	echo "user init system: $INIT_SYSTEM"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["get_init_system"]=true
	else
		TEST_RESULTS["get_init_system"]=false
	fi
	
	echo -e "${BLACK}black text${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["black_text"]=true
	else
		TEST_RESULTS["black_text"]=false
	fi
	
	echo -e "${WHITE}white text${RESET}"	
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["white_text"]=true
	else
		TEST_RESULTS["white_text"]=false
	fi
	
	echo -e "${YELLOW}yellow text${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["yellow_text"]=true
	else
		TEST_RESULTS["yellow_text"]=false
	fi
	
	echo -e "${ORANGE}orange text${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["orange_text"]=true
	else
		TEST_RESULTS["orange_text"]=false
	fi

	echo -e "${BLUE}blue text${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["blue_text"]=true
	else
		TEST_RESULTS["blue_text"]=false
	fi
	
	echo -e "${CYAN}cyan text${RESET}"
	if prompt_user "[?] is that true"; then
		TEST_RESULTS["cyan_text"]=true
	else
		TEST_RESULTS["cyan_text"]=false
	fi

	echo -e "${PURPLE}purple text${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["purple_text"]=true
	else
		TEST_RESULTS["purple_text"]=false
	fi
	
	echo -e "${GREEN}green text${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["green_text"]=true
	else
		TEST_RESULTS["green_text"]=false
	fi
	
	echo -e "${RED}red text${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["red_text"]=true
	else
		TEST_RESULTS["red_text"]=false
	fi
	
	echo -e "${BG_BLACK}black background${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["background_black"]=true
	else
		TEST_RESULTS["background_black"]=false
	fi
	
	echo -e "${BG_RED}red background${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["background_red"]=true
	else
		TEST_RESULTS["background_red"]=false
	fi
	
	echo -e "${BG_GREEN}green background${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["background_green"]=true
	else
		TEST_RESULTS["background_green"]=false
	fi
	
	echo -e "${BG_ORANGE}orange background${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["background_orange"]=true
	else
		TEST_RESULTS["background_yellow"]=false
	fi
	
	echo -e "${BG_BLUE}blue background${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["background_blue"]=true
	else
		TEST_RESULTS["background_blue"]=false
	fi

	echo -e "${BG_MAGENTA}magenta background${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["background_magenta"]=true
	else
		TEST_RESULTS["background_magenta"]=false
	fi

	echo -e "${BG_CYAN}cyan background${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["background_cyan"]=true
	else
		TEST_RESULTS["background_cyan"]=false
	fi

	echo -e "${BG_WHITE}white background${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["background_white"]=true
	else
		TEST_RESULTS["background_white"]=false
	fi

	echo -e "${BOLD}bold text${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["bold_text"]=true
	else
		TEST_RESULTS["bold_text"]=false
	fi
	
	echo -e "${UNDERLINE}underlined text${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["underlined_text"]=true
	else
		TEST_RESULTS["underlined_text"]=false
	fi

	echo -e "${REVERSED}reversed text${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["reversed_text"]=true
	else
		TEST_RESULTS["reversed_text"]=false
	fi
	
	echo -e "${ITALIC}italic text${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["italic_text"]=true
	else
		TEST_RESULTS["italic_text"]=false
	fi
	
	echo -e "${CROSSED_OUT}crossed out text${RESET}"
	if prompt_user "[?] is that true?"; then
		TEST_RESULTS["crossed_out_text"]=true
	else
		TEST_RESULTS["crossed_out_text"]=false
	fi
	
	local ALL_TESTS_PASSED="true"
	for RESULT in "${TEST_RESULTS[@]}"; do
		if [[ "$RESULT" == "false" ]]; then
			ALL_TESTS_PASSED="false"
			break
		fi
	done
	
	init_system_handling "$INIT_SYSTEM" "ssh" "start" && TEST_RESULTS["init_system_handling"]=true || TEST_RESULTS["init_system_handling"]=false
	package_handling "$DISTRO" "install" "vim" "apt" && TEST_RESULTS["package_handling"]=false || TEST_RESULTS["package_handling"]=true
	
	local ANY_TESTS_PASSED=false
	for TEST_NAME in "${!TEST_RESULTS[@]}"; do
		if [[ "${TEST_RESULTS[$TEST_NAME]}" == true ]]; then
			ANY_TESTS_PASSED=true
			break
		fi
	done
	
	if [[ "$ANY_TESTS_PASSED" == false ]]; then
		echo -e "\n${RED}[!] Didn't pass a single test${RESET}"
	else
		echo -e "\n${GREEN}[*] All tests are successfully passed!${RESET}"
	fi
	
	for TEST_NAME in "${!TEST_RESULTS[@]}"; do
		echo "$TEST_NAME = ${TEST_RESULTS[$TEST_NAME]}"
	done
}

function clear_screen() {
	# Clears user's screen.
	# 
	# Returns:
	# 	cleaning status.
	
	clear
}

function is_debian_based() {
	# Args:
        # 	distro: User's operating system.
        # 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If provided distro is Debian based.
	
	local DISTRO="$1"
	local LOG="$2"

	if [[ "$LOG" == "true" ]]; then
		echo "[<==] Checking if $DISTRO is Debian based..."
	fi

	local FOUND=false
	for BASE_DISTRO in "${DEBIAN_BASED[@]}"; do
		if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
			local FOUND=true
			break
		fi
	done

	if $FOUND; then
		return 0
	else
		return 1
	fi
}

function is_arch_based() {
	# Args:
        # 	distro: User's operating system.
        # 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If provided distro is Arch based.

	local DISTRO="$1"
	local LOG="$2"

	if [[ "$LOG" == "true" ]]; then
		echo "[<==] Checking if $DISTRO is Arch based..."
	fi

	local FOUND=false
	for BASE_DISTRO in "${ARCH_BASED[@]}"; do
		if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
			local FOUND=true
			break
		fi
	done

	if $FOUND; then
		return 0
	else
		return 1
	fi
}

function is_alpine_based() {
	# Args:
        # 	distro: User's operating system.
        # 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If provided distro is Alpine based.

	local DISTRO="$1"
	local LOG="$2"

	if [[ "$LOG" == "true" ]]; then
		echo "[<==] Checking if $DISTRO is Alpine based..."
	fi

	local FOUND=false
	for BASE_DISTRO in "${ALPINE_BASED[@]}"; do
		if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
			local FOUND=true
			break
		fi
	done

	if $FOUND; then
		return 0
	else
		return 1
	fi
}

function is_gentoo_based() {
	# Args:
        # 	distro: User's operating system.
        # 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If provided distro is Gentoo based.

	local DISTRO="$1"
	local LOG="$2"

	if [[ "$LOG" == "true" ]]; then
		echo "[<==] Checking if $DISTRO is Gentoo based..."
	fi

	local FOUND=false
	for BASE_DISTRO in "${GENTOO_BASED[@]}"; do
		if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
			local FOUND=true
			break
		fi
	done

	if $FOUND; then
		return 0
	else
		return 1
	fi
}

function is_void_based() {
	# Args:
        # 	distro: User's operating system.
        # 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If provided distro is Void based.
	
	local DISTRO="$1"
	local LOG="$2"

	if [[ "$LOG" == "true" ]]; then
		echo "[<==] Checking if $DISTRO is Void based..."
	fi

	local FOUND=false
	for BASE_DISTRO in "${VOID_BASED[@]}"; do
		if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
			local FOUND=true
			break
		fi
	done

	if $FOUND; then
		return 0
	else
		return 1
	fi
}

function is_dragora_based() {
	# Args:
        # 	distro: User's operating system.
        # 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If provided distro is Dragora based.

	local DISTRO="$1"
	local LOG="$2"

	if [[ "$LOG" == "true" ]]; then
		echo "[<==] Checking if $DISTRO is Dragora based..."
	fi

	local FOUND=false
	for BASE_DISTRO in "${DRAGORA_BASED[@]}"; do
		if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
			local FOUND=true
			break
		fi
	done

	if $FOUND; then
 		return 0
	else
		return 1
	fi
}

function is_slackware_based() {
	# Args:
        # 	distro: User's operating system.
        # 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If provided distro is Slackware based.

	local DISTRO="$1"
	local LOG="$2"

	if [[ "$LOG" == "true" ]]; then
		echo "[<==] Checking if $DISTRO is Slackware based..."
	fi

	local FOUND=false
	for BASE_DISTRO in "${SLACKWARE_BASED[@]}"; do
		if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
			local FOUND=true
			break
		fi
	done

	if $FOUND; then
		return 0
	else
		return 1
	fi
}

function is_fedora_based() {
	# Args:
        # 	distro: User's operating system.
        # 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If provided distro is Fedora based.
	
	local DISTRO="$1"
	local LOG="$2"

	if [[ "$LOG" == "true" ]]; then
		echo "[<==] Checking if $DISTRO is Fedora based..."
	fi

	local FOUND=false
	for BASE_DISTRO in "${FEDORA_BASED[@]}"; do
		if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
			local FOUND=true
			break
		fi
	done

	if $FOUND; then
		return 0
	else
		return 1
	fi
}

function is_centos_based() {
	# Args:
        # 	distro: User's operating system.
        # 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If provided distro is CentOS based.

	local DISTRO="$1"
	local LOG="$2"

	if [[ "$LOG" == "true" ]]; then
		echo "[<==] Checking if $DISTRO is CentOS based..."
	fi

	local FOUND=false
	for BASE_DISTRO in "${CENTOS_BASED[@]}"; do
		if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
			local FOUND=true
			break
		fi
	done

	if $FOUND; then
		return 0
	else
		return 1
	fi
}

function is_guix_based() {
	# Args:
        # 	distro: User's operating system.
        # 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If provided distro is Guix based.
	
	local DISTRO="$1"
	local LOG="$2"

	if [[ "$LOG" == "true" ]]; then
		echo "[<==] Checking if $DISTRO is Guix based..."
	fi

	local FOUND=false
	for BASE_DISTRO in "${GUIX_BASED[@]}"; do
		if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
			local FOUND=true
			break
		fi
	done

	if $FOUND; then
		return 0
	else
		return 1
	fi
}

function is_freebsd_based() {
	# Args:
        # 	distro: User's operating system.
        # 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If provided distro is FreeBSD based.
	
	local DISTRO="$1"
	local LOG="$2"

	if [[ "$LOG" == "true" ]]; then
		echo "[<==] Checking if $DISTRO is FreeBSD based..."
	fi

	local FOUND=false
	for BASE_DISTRO in "${FREEBSD_BASED[@]}"; do
		if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
			local FOUND=true
			break
		fi
	done

	if $FOUND; then
		return 0
	else
		return 1
	fi
}

function is_openbsd_based() {
	# Args:
        # 	distro: User's operating system.
        # 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If provided distro is OpenBSD based.
	
	local DISTRO="$1"
	local LOG="$2"

	if [[ "$LOG" == "true" ]]; then
		echo "[<==] Checking if $DISTRO is OpenBSD based..."
	fi

	local FOUND=false
	for BASE_DISTRO in "${OPENBSD_BASED[@]}"; do
		if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
			local FOUND=true
			break
		fi
	done

	if $FOUND; then
		return 0
	else
		return 1
	fi
}

function is_netbsd_based() {
	# Args:
        # 	distro: User's operating system.
        # 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If provided distro is NetBSD based.
	
	local DISTRO="$1"
	local LOG="$2"

	if [[ "$LOG" == "true" ]]; then
		echo "[<==] Checking if $DISTRO is NetBSD based..."
	fi

	local FOUND=false
	for BASE_DISTRO in "${NETBSD_BASED[@]}"; do
		if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
			local FOUND=true
			break
		fi
	done

	if $FOUND; then
		return 0
	else
		return 1
	fi
}

function prompt_user() {
    	# Prompts the user for input and returns True for 'y/yes' or False for 'n/no'.
    	# Allows for a default value to be used if the user presses Enter without typing.
	#
    	# Args:
        # 	prompt (str): The prompt message to display to the user.
        # 	default (str): The default value ('Y' or 'N') to assume if the user just presses Enter.
	#
    	# Returns:
        # 	bool: True for 'y', 'ye', 'yes' (case-insensitive); False for 'n', 'no' (case-insensitive).
	
	local USER_INPUT
	local PROMPT="$1"
	local DEFAULT="${2:-N}"

	read -erp "$PROMPT (y/n): " USER_INPUT
	USER_INPUT=$(echo "$USER_INPUT" | sed "s/^[[:space:]]*//;s/[[:space:]]*$//" | tr "[:upper:]" "[:lower:]")	
	
	if [[ -z "$USER_INPUT" ]]; then
		USER_INPUT=$(echo "$DEFAULT" | tr "[:upper:]" "[:lower:]")
	fi

	case "$USER_INPUT" in
		y|ye|es|yes)
			return 0
			;;
		n|no)
			return 1
			;;
		*)
			return 1
			;;
	esac
}

function get_user_distro() {
	# Detects user GNU/Linux or BSD distribution.
	#
	# Returns:
	# 	User distro name.
	
	if [[ -f /etc/os-release ]]; then
		source /etc/os-release
		echo "$ID"
	else
		echo -e "${RED}[!] Error: Cannot detect distribution from /etc/os-release.${RESET}"
		read -rp "[==>] Write your OS name yourself: " local ID
		echo "$ID"
	fi
}

function get_init_system() {
	# Detects init system.
	# Can detect systemd, runit, sysvinit, openrc, s6, init, and launchd.
	#
    	# Returns:
        # 	Name of the init system (e.g., "systemd", "sysvinit", "upstart", "openrc", etc.)
	
	if [[ -d /run/systemd/system ]] || [[ "$(ps -p 1 -o comm=)" == "systemd" ]]; then
		echo "systemd"
		return
	fi

	if [[ -d /etc/init.d ]] && [[ -d /etc/init.d/openrc ]]; then
		echo "openrc"
		return
	fi

	if [[ -d /etc/init.d ]]; then
		echo "sysvinit"
		return
	fi

	if [[ -d /etc/s6 ]]; then
		echo "s6"
		return
	fi

	if [[ -d /etc/runit ]]; then
		echo "runit"
		return
	fi

	local INIT_PID
	INIT_PID=$(ps -p 1 -o comm= 2>/dev/null)
	if [[ "$INIT_PID" == "init" ]]; then
		echo "init"
		return
	fi

	echo "unknown"
}


#
# Systemd Management:
#
# Functions for managing services using systemd.
#
# Next functions are providing methods to perform basic operations on services,
# such as starting, stopping, reloading, and checking the status. It uses the
# 'systemctl' utility to manage services and handles errors that occur during
# command execution.
#
# Attributes:
# 	command: The command to perform on the service (start, stop, restart, reload, status).
# 	service: The name of the service to manage.

function _run_systemctl_systemd() {
	local ACTION="$1"
	local SERVICE="$2"

	if systemctl "$ACTION" "$SERVICE" >/dev/null 2>&1; then
		echo -e "${GREEN}[*] Success!${RESET}"
		return 0
	else
		echo -e "${RED}[!] Error: systemctl $ACTION $SERVICE failed.${RESET}"
		return 1
	fi
}

function start_systemctl_systemd() {
	local SERVICE="$1"
	_run_systemctl_systemd "start" "$SERVICE"
}

function stop_systemctl_systemd() {
	local SERVICE="$1"
	_run_systemctl_systemd "stop" "$SERVICE"
}

function reload_systemctl_systemd() {
	local SERVICE="$1"
	_run_systemctl_systemd "reload" "$SERVICE"
}

function restart_systemctl_systemd() {
	local SERVICE="$1"
	_run_systemctl_systemd "restart" "$SERVICE"
}

function status_systemctl_systemd() {
	local SERVICE="$1"
	_run_systemctl_systemd "status" "$SERVICE"
}

function execute_systemctl_systemd() {
	local COMMAND="$1"
	local SERVICE="$2"

	case "$COMMAND" in
		start)
			start_systemctl_systemd "$SERVICE"
			return "$?"
			;;
		stop)
			stop_systemctl_systemd "$SERVICE"
			return "$?"
			;;
		reload)
			reload_systemctl_systemd "$SERVICE"
			return "$?"
			;;
		restart)
			restart_systemctl_systemd "$SERVICE"
			return "$?"
			;;
		status)
			status_systemctl_systemd "$SERVICE"
			return "$?"
			;;
		*)
			echo -e "${RED}[!] Error: Unknown command: $COMMAND${RESET}"
			return 1
			;;
	esac
}

#
# SysVInit Management:
#
# Functions for managing services using SysVInit.
#
# Next functions are providing methods to perform basic operations on services,
# such as starting, stopping, reloading, and checking the status. It uses the
# 'service' utility to manage services and handles errors that occur during
# command execution.
#
# Attributes:
#        command: The command to perform on the service (start, stop, restart, reload, force-reload, status).
#        service: The name of the service to manage.

function _run_service_sysvinit() {
	local ACTION="$1"
	local SERVICE="$2"

	if service "$SERVICE" "$ACTION" >/dev/null 2>&1; then
		echo -e "${GREEN}[*] Success!${RESET}"
		return 0
	else
		echo -e "${RED}[!] Error: service $SERVICE $ACTION failed.${RESET}"
		return 1
	fi
}

function start_service_sysvinit() {
	local SERVICE="$1"
	_run_service_sysvinit "start" "$SERVICE"	
}

function stop_service_sysvinit() {
	local SERVICE="$1"
	_run_service_sysvinit "stop" "$SERVICE"
}

function reload_service_sysvinit() {
	local SERVICE="$1"
	_run_service_sysvinit "reload" "$SERVICE"
}

function force_reload_service_sysvinit() {
	local SERVICE="$1"
	_run_service_sysvinit "force-reload" "$SERVICE"
}

function restart_service_sysvinit() {
	local SERVICE="$1"
	_run_service_sysvinit "restart" "$SERVICE"
}

function status_service_sysvinit() {
	local SERVICE="$1"
	_run_service_sysvinit "status" "$SERVICE"
}

function execute_service_sysvinit() {
	local COMMAND="$1"
	local SERVICE="$2"

	case "$COMMAND" in
		start)
			start_service_sysvinit "$SERVICE"
			return "$?"
			;;
		stop)
			stop_service_sysvinit "$SERVICE"
			return "$?"
			;;
		reload)
			reload_service_sysvinit "$SERVICE"
			return "$?"
			;;
		force-reload)
			force_reload_service_sysvinit "$SERVICE"
			return "$?"
			;;
		restart)
			restart_service_sysvinit "$SERVICE"
			return "$?"
			;;
		status)
			status_service_sysvinit "$SERVICE"
			return "$?"
			;;
		*)
			echo -e "${RED}[!] Error: Unknown command: $COMMAND${RESET}"
			return 1
			;;
	esac
}

#
# Init Management:
#
# Functions for managing services using Init.
#
# Next functions are providing methods to perform basic operations on services,
# such as starting, stopping, reloading, and checking the status. It uses the
# 'service' utility to manage services and handles errors that occur during
# command execution.
#
# Attributes:
#        command: The command to perform on the service (start, stop, restart, reload, force-reload, status).
#        service: The name of the service to manage.

function _run_service_init() {
	local ACTION="$1"
	local SERVICE="$2"

	if service "$SERVICE" "$ACTION" >/dev/null 2>&1; then
		echo -e "${GREEN}[*] Success!${RESET}"
		return 0
	else
		echo -e "${RED}[!] Error: service $SERVICE $ACTION failed.${RESET}"
		return 1
	fi
}

function start_service_init() {
	local SERVICE="$1"
	_run_service_init "start" "$SERVICE"	
}

function stop_service_init() {
	local SERVICE="$1"
	_run_service_init "stop" "$SERVICE"
}

function reload_service_init() {
	local SERVICE="$1"
	_run_service_init "reload" "$SERVICE"
}

function force_reload_service_init() {
	local SERVICE="$1"
	_run_service_init "force-reload" "$SERVICE"
}

function restart_service_init() {
	local SERVICE="$1"
	_run_service_init "restart" "$SERVICE"
}

function status_service_init() {
	local SERVICE="$1"
	_run_service_init "status" "$SERVICE"
}

function execute_service_init() {
	local COMMAND="$1"
	local SERVICE="$2"

	case "$COMMAND" in
		start)
			start_service_init "$SERVICE"
			return "$?"
			;;
		stop)
			stop_service_init "$SERVICE"
			return "$?"
			;;
		reload)
			reload_service_init "$SERVICE"
			return "$?"
			;;
		force-reload)
			force_reload_service_init "$SERVICE"
			return "$?"
			;;
		restart)
			restart_service_init "$SERVICE"
			return "$?"
			;;
		status)
			status_service_init "$SERVICE"
			return "$?"
			;;
		*)
			echo -e "${RED}[!] Error: Unknown command: $COMMAND${RESET}"
			return 1
			;;
	esac
}

#
# OpenRC Management:
#
# Functions for managing services using OpenRC.
#
# Next functions are providing methods to perform basic operations on services,
# such as starting, stopping, reloading, and checking the status. It uses the
# 'rc-service' utility to manage services and handles errors that occur during
# command execution.
#
# Attributes:
#        command: The command to perform on the service (start, stop, restart, reload, status).
#        service: The name of the service to manage.

function _run_rc_openrc() {
	local ACTION="$1"
	local SERVICE="$2"

	if rc-service "$SERVICE" "$ACTION" >/dev/null 2>&1; then
		echo -e "${GREEN}[*] Success!${RESET}"
		return 0
	else
		echo -e "${RED}[!] Error: rc-service $SERVICE $ACTION failed.${RESET}"
		return 1
	fi
}

function start_rc_openrc() {
	local SERVICE="$1"
	_run_rc_openrc "start" "$SERVICE"	
}

function stop_rc_openrc() {
	local SERVICE="$1"
	_run_rc_openrc "stop" "$SERVICE"
}

function reload_rc_openrc() {
	local SERVICE="$1"
	_run_rc_openrc "reload" "$SERVICE"
}

function restart_rc_openrc() {
	local SERVICE="$1"
	_run_rc_openrc "restart" "$SERVICE"
}

function status_rc_openrc() {
	local SERVICE="$1"
	_run_rc_openrc "status" "$SERVICE"
}

function execute_rc_openrc() {
	local COMMAND="$1"
	local SERVICE="$2"

	case "$COMMAND" in
		start)
			start_rc_openrc "$SERVICE"
			return "$?"
			;;
		stop)
			stop_rc_openrc "$SERVICE"
			return "$?"
			;;
		reload)
			reload_rc_openrc "$SERVICE"
			return "$?"
			;;
		restart)
			restart_rc_openrc "$SERVICE"
			return "$?"
			;;
		status)
			status_rc_openrc "$SERVICE"
			return "$?"
			;;
		*)
			echo -e "${RED}[!] Error: Unknown command: $COMMAND${RESET}"
			return 1
			;;
	esac
}

#
# s6 Management:
#
# Functions for managing services using s6.
#
# Next functions are providing methods to perform basic operations on services,
# such as starting, stopping, reloading, and checking the status. It uses the
# 's6-svc' utility to manage services and handles errors that occur during
# command execution.
#
# Attributes:
#        command: The command to perform on the service (start, stop, restart, reload, status).
#        service: The name of the service to manage.

function _run_svc_s6() {
	local ACTION="$1"
	local SERVICE="$2"

	if s6-svc "$ACTION" "$SERVICE" >/dev/null 2>&1; then
		echo -e "${GREEN}[*] Success!${RESET}"
		return 0
	else
		echo -e "${RED}[!] Error: s6-svc $ACTION $SERVICE failed.${RESET}"
		return 1
	fi
}

function start_svc_s6() {
	local SERVICE="$1"
	_run_svc_s6 "start" "$SERVICE"
}

function stop_svc_s6() {
	local SERVICE="$1"
	_run_svc_s6 "stop" "$SERVICE"
}

function reload_svc_s6() {
	local SERVICE="$1"
	_run_svc_s6 "reload" "$SERVICE"
}

function restart_svc_s6() {
	local SERVICE="$1"
	_run_svc_s6 "restart" "$SERVICE"
}

function status_svc_s6() {
	local SERVICE="$1"
	_run_svc_s6 "status" "$SERVICE"
}

function execute_svc_s6() {
	local COMMAND="$1"
	local SERVICE="$2"

	case "$COMMAND" in
		start)
			start_svc_s6 "$SERVICE"
			return "$?"
			;;
		stop)
			stop_svc_s6 "$SERVICE"
			return "$?"
			;;
		reload)
			reload_svc_s6 "$SERVICE"
			return "$?"
			;;
		restart)
			restart_svc_s6 "$SERVICE"
			return "$?"
			;;
		status)
			status_svc_s6 "$SERVICE"
			return "$?"
			;;
		*)
			echo -e "${RED}[!] Error: Unknown command: $COMMAND${RESET}"
			return 1
			;;
	esac
}

#
# runit Management:
#
# Functions for managing services using runit.
#
# Next functions are providing methods to perform basic operations on services,
# such as starting, stopping, reloading, and checking the status. It uses the
# 'sv' utility to manage services and handles errors that occur during
# command execution.
#
# Attributes:
#        command: The command to perform on the service (start, stop, restart, reload status).
#        service: The name of the service to manage.

function _run_sv_runit() {
	local ACTION="$1"
	local SERVICE="$2"

	if sv "$ACTION" "$SERVICE" >/dev/null 2>&1; then
		echo -e "${GREEN}[*] Success!${RESET}"
		return 0
	else
		echo -e "${RED}[!] Error: sv $ACTION $SERVICE failed.${RESET}"
		return 1
	fi
}

function start_sv_runit() {
	local SERVICE="$1"
	_run_sv_runit "start" "$SERVICE"
}

function stop_sv_runit() {
	local SERVICE="$1"
	_run_sv_runit "stop" "$SERVICE"
}

function reload_sv_runit() {
	local SERVICE="$1"
	_run_sv_runit "reload" "$SERVICE"
}

function restart_sv_runit() {
	local SERVICE="$1"
	_run_sv_runit "restart" "$SERVICE"
}

function status_sv_runit() {
	local SERVICE="$1"
	_run_sv_runit "status" "$SERVICE"
}

function execute_sv_runit() {
	local COMMAND="$1"
	local SERVICE="$2"

	case "$COMMAND" in
		start)
			start_sv_runit "$SERVICE"
			return "$?"
			;;
		stop)
			stop_sv_runit "$SERVICE"
			return "$?"
			;;
		reload)
			reload_sv_runit "$SERVICE"
			return "$?"
			;;
		restart)
			restart_sv_runit "$SERVICE"
			return "$?"
			;;
		status)
			status_sv_runit "$SERVICE"
			return "$?"
			;;
		*)
			echo -e "${RED}[!] Error: Unknown command: $COMMAND${RESET}"
			return 1
			;;
	esac
}

#
# Launchd Management:
#
# Functions for managing services using Launchd.
#
# Next functions are providing methods to perform basic operations on services,
# such as starting, stopping, reloading, and checking the status. It uses the
# 'launchctl' utility to manage services and handles errors that occur during
# command execution.
#
# Attributes:
#        command: The command to perform on the service (start, stop, restart, reload, status).
#        service: The name of the service to manage.

function _run_launchctl_launchd() {
	local ACTION="$1"
	local SERVICE="$2"

	if launchctl "$ACTION" "$SERVICE" >/dev/null 2>&1; then
		echo -e "${GREEN}[*] Success!${RESET}"
		return 0
	else
		echo -e "${RED}[!] Error: launchctl $ACTION $SERVICE failed.${RESET}"
		return 1
	fi
}

function start_launchctl_launchd() {
	local SERVICE="$1"
	_run_launchctl_launchd "start" "$SERVICE"
}

function stop_launchctl_launchd() {
	local SERVICE="$1"
	_run_launchctl_launchd "stop" "$SERVICE"
}

function reload_launchctl_launchd() {
	local SERVICE="$1"
	_run_launchctl_launchd "reload" "$SERVICE"
}

function restart_launchctl_launchd() {
	local SERVICE="$1"
	_run_launchctl_launchd "restart" "$SERVICE"
}

function status_launchctl_launchd() {
	local SERVICE="$1"
	_run_launchctl_launchd "status" "$SERVICE"
}

function execute_launchctl_launchd() {
	local COMMAND="$1"
	local SERVICE="$2"

	case "$COMMAND" in
		start)
			start_launchctl_launchd "$SERVICE"
			return "$?"
			;;
		stop)
			stop_launchctl_launchd "$SERVICE"
			return "$?"
			;;
		reload)
			reload_launchctl_launchd "$SERVICE"
			return "$?"
			;;
		restart)
			restart_launchctl_launchd "$SERVICE"
			return "$?"
			;;
		status)
			status_launchctl_launchd "$SERVICE"
			return "$?"
			;;
		*)
			echo -e "${RED}[!] Error: Unknown command: $COMMAND${RESET}"
			return 1
			;;
	esac
}

#
# Debian Package Management:
#
# Functions for managing packages using apt/aptitude/dpkg.
# Includes updating && upgrading, full-upgrading, installing, removing, purging and autoremoving packages.
#

##
## apt Methods:
##

function apt_update_debian() {
	if apt update; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list.${RESET}"
		return 1
	fi
}

function apt_upgrade_debian() {
	if apt upgrade -y; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to upgrade packages.${RESET}"
		return 1
	fi
}

function apt_full_upgrade_debian() {
	if apt full-upgrade -y; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to full-upgrade packages.${RESET}"
		return 1
	fi
}

function apt_install_debian() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if apt install "$PACKAGE" -y; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function apt_remove_debian() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if apt remove "$PACKAGE" -y; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function apt_purge_debian() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if apt purge "$PACKAGE" -y; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to purge package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function apt_autoremove_debian() {
	if apt autoremove -y; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to autoremove packages.${RESET}"
		return 1
	fi
}

##
## aptitude Methods:
##

function aptitude_update_debian() {
	if aptitude update; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list.${RESET}"
		return 1
	fi
}

function aptitude_upgrade_debian() {
	if aptitude upgrade -y; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to upgrade packages.${RESET}"
		return 1
	fi
}

function aptitude_full_upgrade_debian() {
	if aptitude full-upgrade -y; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to full-upgrade packages.${RESET}"
		return 1
	fi
}

function aptitude_install_debian() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if aptitude install "$PACKAGE" -y; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function aptitude_remove_debian() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if aptitude remove "$PACKAGE" -y; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function aptitude_purge_debian() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if aptitude purge "$PACKAGE" -y; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to purge package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function aptitude_autoremove_debian() {
	if aptitude autoremove -y; then
		return
	else
		echo -e "${RED}[!] Error: Failed to autoremove packages.${RESET}"
		return 1
	fi
}

##
## dpkg Methods:
##

function dpkg_install_debian() {
	local DEB_PATH="$1"
	
	if dpkg --install "$DEB_PATH"; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to install .deb package: $DEB_PATH.${RESET}"
		return 1
	fi
}

function dpkg_remove_debian() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if dpkg --remove "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function dpkg_purge_debian() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if dpkg --purge "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to purge package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

#
# Gentoo Package Management:
#
# Functions for managing packages using portage.
# Includes updating && upgrading, installing, and removing packages
#

function portage_update_gentoo() {
	if emerge --sync; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list.${RESET}"
		return 1
	fi
}

function portage_upgrade_gentoo() {
	if emerge --update --deep @world; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to upgrade packages.${RESET}"
		return 1
	fi
}

function portage_install_gentoo() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if emerge "$PACKAGE"; then
			return 0
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function portage_remove_gentoo() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if emerge --depclean "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

#
# Fedora Package Management:
#
# Functions for managing packages using dnf.
# Includes updating && upgrading, installing, and removing packages
#

function dnf_update_fedora() {
	if dnf update -y; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list.${RESET}"
		return 1
	fi
}

function dnf_upgrade_fedora() {
	if dnf update -y; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to upgrade packages.${RESET}"
		return 1
	fi
}

function dnf_install_fedora() {
	local PACKAGES=("$@")	

	for PACKAGE in "${PACKAGES[@]}"; do
		if dnf install "$PACAKGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function dnf_remove_fedora() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if dnf remove "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done

}

#
# CentOS Package Management:
#
# Functions for managing packages using yum.
# Includes updating && upgrading, installing, and removing packages.
#

function yum_update_centos() {
	if yum update -y; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list.${RESET}"
		return 1
	fi
}

function yum_upgrade_centos() {
	if yum upgrade -y; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to upgrade packages.${RESET}"
		return 1
	fi
}

function yum_install_centos() {
	local PACKAGES=("$@")
	
	for PACKAGE in "${PACKAGES[@]}"; do
		if yum install "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0       
}

function yum_remove_centos() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if yum remove "$PACKAGE"; then
			conitunue
		else
			echo -e "${RED}[!] Error: Failed to update package list.${RESET}"
			return 1
		fi
	done

	return 0
}

#
# OpenSUSE Package Management:
#
# Functions for managing packages using zypper.
# Includes updating && upgrading, installing, and removing packages.
#

function zypper_update_opensuse() {
	if zypper refresh; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list.${RESET}"
		return 1
	fi
}

function zypper_upgrade_opensuse() {
	if zypper update -y; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to upgrade packages.${RESET}"
		return 1
	fi
}

function zypper_install_opensuse() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if zypper install "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function zypper_remove_opensuse() {
	local PACKAGES=("$@")
	
	for PACKAGE in "${PACKAGES[@]}"; do
		if zypper rm "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done
	
	return 0
}

#
# Alpine Package Management:
#
# Functions for managing packages using apk.
# Includes updating && upgrading, installing, and removing packages.
#

function apk_update_alpine() {
	if apk update; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list.${RESET}"
		return 1
	fi
}

function apk_upgrade_alpine() {
	if apk upgrade; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to upgrade packages.${RESET}"
		return 1
	fi
}

function apk_install_alpine() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if apk add "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done
	
	return 0
}

function apk_remove_alpine() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if apk del "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

#
# Void Package Management:
#
# Functions for managing packages using xbps.
# Includes updating && upgrading, installing, and removing packages.
#

function xbps_update_upgrade_void() {
	if xbps-install -Su; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list && upgrade packages.${RESET}"
		return 1
	fi
}

function xbps_install_void() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if xbps-install "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function xbps_remove_void() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if xbps-remove "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

#
# Dragora Package Management:
#
# Functions for managing packages using qi.
# Includes updating && upgrading, installing, and removing packages.
#

function qi_update_dragora() {
	if qi update; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list.${RESET}"
		return 1
	fi
}

function qi_upgrade_dragora() {
	if qi upgrade; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to upgrade packages.${RESET}"
		return 1
	fi
}

function qi_install_dragora() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if qi install "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done
	
	return 0
}

function qi_remove_dragora() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if qi remove "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

#
# Slackware Package Management:
#
# Functions for managing packages using slackpkg.
# Includes updating && upgrading, installing, and removing packages.
#

function slackpkg_update_slackware() {
	if slackpkg update; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list.${RESET}"
		return 1
	fi
}

function slackpkg_upgrade_slackware() {
	if slackpkg upgrade; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to upgrade packages.${RESET}"
		return 1
	fi
}

function slackpkg_install_slackware() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if slackpkg install "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function slackpkg_remove_slackware() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if slackpkg remove "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

#
# Guix Package Management:
#
# Functions for managing packages using guix.
# Includes updating && upgrading, installing, and removing packages.
#

function guix_update_guix() {
	if guix upgrade; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list.${RESET}"
		return 1
	fi
}

function guix_upgrade_guix() {
	if guix upgrade; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to upgrade packages.${RESET}"
		return 1
	fi
}

function guix_install_guix() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if guix install "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function guix_remove_guix() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if guix remove "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

#
# Arch Package Management:
#
# Functions for managing packages using pacman.
# Includes updating && upgrading, installing, removing, and purging packages.
#

function pacman_update_upgrade_arch() {
	if pacman -Syu; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list && upgrade packages.${RESET}"
		return 1
	fi
}

function pacman_install_arch() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if pacman -S "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function pacman_remove_arch() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if pacman -R "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function pacman_purge_arch() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if pacman -Rns "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to purge package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

#
# FreeBSD Package Management:
#
# Functions for managing packages using pkg.
# Includes updating && upgrading, installing, and removing packages.
#

function pkg_update_freebsd() {
	if pkg update; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list.${RESET}"
		return 1
	fi
}

function pkg_upgrade_freebsd() {
	if pkg upgrade -y; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to upgrade packages.${RESET}"
		return 1
	fi
}

function pkg_install_freebsd() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if pkg install -y "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function pkg_remove_freebsd() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if pkg delete -y "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

#
# OpenBSD Package Management:
#
# Functions for managing packages using pkg_add.
# Includes updating && upgrading, installing, and removing packages.
#

function pkg_add_update_openbsd() {
	if pkg_add -u; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list.${RESET}"
		return 1
	fi
}

function pkg_add_upgrade_openbsd() {
	if pkg_add -uf; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to upgrade packages.${RESET}"
		return 1
	fi
}

function pkg_add_install_openbsd() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if pkg_add "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done
	
	return 0
}

function pkg_add_remove_openbsd() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if pkg_delete "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

#
# NetBSD Package Management:
#
# Functions for managing packages using pkgin.
# Includes updating && upgrading, installing, and removing packages.
#

function pkgin_update_netbsd() {
	if pkgin update; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to update package list.${RESET}"
		return 1
	fi
}

function pkgin_upgrade_netbsd() {
	if pkgin upgrade; then
		return 0
	else
		echo -e "${RED}[!] Error: Failed to upgrade packages.${RESET}"
		return 1
	fi
}

function pkgin_install_netbsd() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if pkgin install "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to install package: $PACKAGE.${RESET}"
			return 1
		fi
	done
	
	return 0
}

function pkgin_remove_netbsd() {
	local PACKAGES=("$@")

	for PACKAGE in "${PACKAGES[@]}"; do
		if pkgin remove "$PACKAGE"; then
			continue
		else
			echo -e "${RED}[!] Error: Failed to remove package: $PACKAGE.${RESET}"
			return 1
		fi
	done

	return 0
}

function package_handling() {
    	# Handles package downloading for different GNU/Linux and BSD distributions.
	# 
	# Args:
        # 	distro: User's operating system.
        # 	package_list: Lists of packages to handle.
        # 	command: Handling command.
        # 	pm: Package manager choice for Debian based distributions: apt, aptitude or dpkg.
	# Returns:
	#	Package handling status.

	local DISTRO="$1"
	local COMMAND="$2"
	local PACKAGE="$3"
	local PM=""

	if [[ $# -ge 4 ]]; then
		PM="$4"
	else
		PM="apt"
	fi

	echo "[<==] Installing requirements [$PACKAGE]..."
	sleep 1
	
	for BASE_DISTRO in "${DEBIAN_BASED[@]}"; do
		if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
			if [[ "$COMMAND" == "update" ]]; then
				if [[ "$PM" == "apt" ]]; then
					apt_update_debian
				elif [[ "$PM" == "aptitude" ]]; then
					aptitude_update_debian
				fi

			elif [[ "$COMMAND" == "upgrade" ]]; then
				if [[ "$PM" == "apt" ]]; then
					apt_upgrade_debian
				elif [[ "$PM" == "aptitude" ]]; then
					aptitude_upgrade_debian
				fi

			elif [[ "$COMMAND" == "full-upgrade" ]]; then
				if [[ "$PM" == "apt" ]]; then
					apt_full_upgrade_debian
				elif [[ "$PM" == "aptitude" ]]; then
					aptitude_full_upgrade_debian
				fi

			elif [[ "$COMMAND" == "install" ]]; then
				if [[ "$PM" == "apt" ]]; then
					apt_install_debian "$PACKAGE"
				elif [[ "$PM" == "aptitude" ]]; then
					aptitude_install_debian "$PACKAGE"
				elif [[ "$PM" == "dpkg" ]]; then
					dpkg_install_debian "$PACKAGE"
				fi

			elif [[ "$COMMAND" == "remove" ]]; then
				if [[ "$PM" == "apt" ]]; then
					apt_remove_debian "$PACKAGE"
				elif [[ "$PM" == "aptitude" ]]; then
					aptitude_remove_debian "$PACKAGE"
				elif [[ "$PM" == "dpkg" ]]; then
					dpkg_remove_debian "$PACKAGE"
				fi

			elif [[ "$COMMAND" == "purge" ]]; then
				if [[ "$PM" == "apt" ]]; then
					apt_purge_debian "$PACKAGE"
				elif [[ "$PM" == "aptitude" ]]; then
					aptitude_purge_debian "$PACKAGE"
				elif [[ "$PM" == "dpkg" ]]; then
					dpkg_purge_debian "$PACKAGE"
				fi

			elif [[ "$COMMAND" == autoremove ]]; then
				if [[ "$PM" == "apt" ]]; then
					apt_autoremove_debian
				elif [[ "$PM" == "aptitude" ]]; then
					aptitude_autoremove_debian
				fi

			else
				echo -e "${RED}[!] Error: Unsupported command: $COMMAND.${RESET}"
				exit 1
			fi
			
			local FOUND=true
			break
		fi
	done
	
	if ! $FOUND; then
		for BASE_DISTRO in "${ARCH_BASED[@]}"; do
			if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
				if [[ "$COMMAND" == "update" ]]; then
					pacman_update_upgrade_arch

				elif [[ "$COMMAND" == "upgrade" ]]; then
					pacman_update_upgrade_arch
			
				elif [[ "$COMMAND" == "install" ]]; then
					pacman_install_arch "$PACKAGE"
			
				elif [[ "$COMMAND" == "remove" ]]; then
					pacman_remove_arch "$PACKAGE"

				elif [[ "$COMMAND" == "purge" ]]; then
					pacman_purge_arch "$PACKAGE"
			
				else
					echo -e "${RED}[!] Error: Unsupported command: $COMMAND.${RESET}"
					exit 1
				fi
			
				local FOUND=true
        			break
			fi
		done
	fi

	if ! $FOUND; then
		for BASE_DISTRO in "${ALPINE_BASED[@]}"; do
			if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
				if [[ "$COMMAND" == "update" ]]; then
					apk_update_alpine

				elif [[ "$COMMAND" == "upgrade" ]]; then
					apk_upgrade_alpine
			
				elif [[ "$COMMAND" == "install" ]]; then
					apk_install_alpine "$PACKAGE"
			
				elif [[ "$COMMAND" == "remove" ]]; then
					apk_remove_alpine "$PACKAGE"
	
				else
					echo -e "${RED}[!] Error: Unsupported command: $COMMAND.${RESET}"
					exit 1
				fi
			
				local FOUND=true
        			break
			fi	
		done
	fi

	if ! $FOUND; then
		for BASE_DISTRO in "${GENTOO_BASED[@]}"; do
			if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
				if [[ "$COMMAND" == "update" ]]; then
					portage_update_gentoo

				elif [[ "$COMMAND" == "upgrade" ]]; then
					portage_upgrade_gentoo

				elif [[ "$COMMAND" == "install" ]]; then
					portage_install_gentoo "$PACKAGE"

				elif [[ "$COMMAND" == "remove" ]]; then
					portage_remove_gentoo "$PACKAGE"

				else
					echo -e "${RED}[!] Error: Unsupported command: $COMMAND.${RESET}"
					exit 1
				fi

				local FOUND=true
        			break
			fi
		done
	fi

	if ! $FOUND; then
		for BASE_DISTRO in "${VOID_BASED[@]}"; do
			if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
				if [[ "$COMMAND" == "update" ]]; then
					xbps_update_upgrade_void

				elif [[ "$COMMAND" == "upgrade" ]]; then
					xbps_upgrade_upgrade_void

				elif [[ "$COMMAND" == "install" ]]; then
					xbps_install_void "$PACKAGE"

				elif [[ "$COMMAND" == "remove" ]]; then
					xbps_remove_void "$PACKAGE"

				else
					echo -e "${RED}[!] Error: Unsupported command: $COMMAND.${RESET}"
					exit 1
				fi

				local FOUND=true
        			break
			fi
		done
	fi

	if ! $FOUND; then
		for BASE_DISTRO in "${DRAGORA_BASED[@]}"; do
			if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
				if [[ "$COMMAND" == "update" ]]; then
					qi_update_dragora

				elif [[ "$COMMAND" == "upgrade" ]]; then
					qi_upgrade_dragora

				elif [[ "$COMMAND" == "install" ]]; then
					qi_install_dragora "$PACKAGE"

				elif [[ "$COMMAND" == "remove" ]]; then
					qi_remove_dragora "$PACKAGE"

				else
					echo -e "${RED}[!] Error: Unsupported command: $COMMAND.${RESET}"
					exit 1
				fi

				local FOUND=true
        			break
			fi
		done
	fi

	if ! $FOUND; then
		for BASE_DISTRO in "${SLACKWARE_BASED[@]}"; do
			if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
				if [[ "$COMMAND" == "update" ]]; then
					slackpkg_update_slackware

				elif [[ "$COMMAND" == "upgrade" ]]; then
					slackpkg_upgrade_slackware

				elif [[ "$COMMAND" == "install" ]]; then
					slackpkg_install_slackware "$PACKAGE"

				elif [[ "$COMMAND" == "remove" ]]; then
					slackpkg_remove_slackware "$PACKAGE"

				else
					echo -e "${RED}[!] Error: Unsupported command: $COMMAND.${RESET}"
					exit 1
				fi

				local FOUND=true
        			break
			fi
		done
	fi

	if ! $FOUND; then
		for BASE_DISTRO in "${FEDORA_BASED[@]}"; do
			if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
				if [[ "$COMMAND" == "update" ]]; then
					dnf_update_fedora

				elif [[ "$COMMAND" == "upgrade" ]]; then
					dnf_upgrade_fedora

				elif [[ "$COMMAND" == "install" ]]; then
					dnf_install_fedora "$PACKAGE"

				elif [[ "$COMMAND" == "remove" ]]; then
					dnf_remove_fedora "$PACKAGE"

				else
					echo -e "${RED}[!] Error: Unsupported command: $COMMAND.${RESET}"
					exit 1
				fi

				local FOUND=true
        			break
			fi
		done
	fi

	if ! $FOUND; then
		for BASE_DISTRO in "${CENTOS_BASED[@]}"; do
			if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
				if [[ "$COMMAND" == "update" ]]; then
					yum_update_centos

				elif [[ "$COMMAND" == "upgrade" ]]; then
					yum_upgrade_centos

				elif [[ "$COMMAND" == "install" ]]; then
					yum_install_centos "$PACKAGE"

				elif [[ "$COMMAND" == "remove" ]]; then
					yum_remove_centos "$PACKAGE"

				else
					echo -e "${RED}[!] Error: Unsupported command: $COMMAND.${RESET}"
					exit 1
				fi

				local FOUND=true
        			break
			fi
		done
	fi
	
	if ! $FOUND; then
		for BASE_DISTRO in "${OPENSUSE_BASED[@]}"; do
			if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
				if [[ "$COMMAND" == "update" ]]; then
					zypper_update_opensuse

				elif [[ "$COMMAND" == "upgrade" ]]; then
					zypper_upgrade_opensuse

				elif [[ "$COMMAND" == "install" ]]; then
					zypper_install_opensuse "$PACKAGE"

				elif [[ "$COMMAND" == "remove" ]]; then
					zypper_remove_opensuse "$PACKAGE"

				else
					echo -e "${RED}[!] Error: Unsupported command: $COMMAND.${RESET}"
					exit 1
				fi

				local FOUND=true
        			break
			fi
		done
	fi

	if ! $FOUND; then
		for BASE_DISTRO in "${GUIX_BASED[@]}"; do
			if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
				if [[ "$COMMAND" == "update" ]]; then
					guix_update_guix

				elif [[ "$COMMAND" == "upgrade" ]]; then
					guix_upgrade_guix

				elif [[ "$COMMAND" == "install" ]]; then
					guix_install_guix "$PACKAGE"

				elif [[ "$COMMAND" == "remove" ]]; then
					guix_remove_guix "$PACKAGE"

				else
					echo -e "${RED}[!] Error: Unsupported command: $COMMAND.${RESET}"
					exit 1
				fi

				local FOUND=true
        			break
			fi
		done
	fi

	if ! $FOUND; then
		for BASE_DISTRO in "${FREEBSD_BASED[@]}"; do
			if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
				if [[ "$COMMAND" == "update" ]]; then
					pkg_update_freebsd

				elif [[ "$COMMAND" == "upgrade" ]]; then
					pkg_upgrade_freebsd

				elif [[ "$COMMAND" == "install" ]]; then
					pkg_install_freebsd "$PACKAGE"

				elif [[ "$COMMAND" == "remove" ]]; then
					pkg_remove_freebsd "$PACKAGE"

				else
					echo -e "${RED}[!] Error: Unsupported command: $COMMAND.${RESET}"
					exit 1
				fi

				local FOUND=true
        			break
			fi
		done
	fi

	if ! $FOUND; then
		for BASE_DISTRO in "${OPENBSD_BASED[@]}"; do
			if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
				if [[ "$COMMAND" == "update" ]]; then
					pkg_add_update_openbsd

				elif [[ "$COMMAND" == "upgrade" ]]; then
					pkg_add_upgrade_openbsd

				elif [[ "$COMMAND" == "install" ]]; then
					pkg_add_install_openbsd "$PACKAGE"

				elif [[ "$COMMAND" == "remove" ]]; then
					pkg_add_remove_openbsd "$PACKAGE"

				else
					echo -e "${RED}[!] Error: Unsupported command: $COMMAND.${RESET}"
					exit 1
				fi

				local FOUND=true
        			break
			fi
		done
	fi
	
	if ! $FOUND; then
		for BASE_DISTRO in "${NETBSD_BASED[@]}"; do
			if [[ "$DISTRO" == "$BASE_DISTRO" ]]; then
				if [[ "$COMMAND" == "update" ]]; then
					pkgin_update_netbsd

				elif [[ "$COMMAND" == "upgrade" ]]; then
					pkgin_upgrade_netbsd

				elif [[ "$COMMAND" == "install" ]]; then
					pkgin_install_netbsd "$PACKAGE"

				elif [[ "$COMMAND" == "remove" ]]; then
					pkgin_remove_netbsd "$PACKAGE"

				else
					echo -e "${RED}[!] Error: Unsupported command: $COMMAND.${RESET}"
					exit 1
				fi

				local FOUND=true
        			break
			fi
		done
	fi
}

function init_system_handling() {
	# Handles service management based on the provided init system.
	#
    	# Args:
        # 	init_system: The name of the init system being used
        # 	command: The command to execute for service management
        # 	service: The name of the service to manage.
	#
    	# Returns:
	#         True (0) if the service management command was executed successfully, False (1) otherwise.

	local INIT_SYSTEM="$1"
	local SERVICE="$2"
	local COMMAND="$3"
	
	echo "[<==] Enabling services [$SERVICE]... "
	sleep 1

	case "$INIT_SYSTEM" in
		"systemd")
			execute_systemctl_systemd "$COMMAND" "$SERVICE"
			return 0
			;;
		"sysvinit")
			execute_service_sysvinit "$COMMAND" "$SERVICE"
			return 0
			;;
		"init")
			execute_service_init "$COMMAND" "$SERVICE"
			return 0
			;;
		"s6")
			execute_svc_s6 "$COMMAND" "$SERVICE"
			return 0
			;;
		"runit")
			execute_sv_runit "$COMMAND" "$SERVICE"
			return 0
			;;
		"launchd")
			execute_launchctl_launchd "$COMMAND" "$SERVICE"
			return 0
			;;
		"openrc")
			execute_rc_openrc "$COMMAND" "$SERVICE"
			return 0
			;;
		*)
			echo -e "${RED}[!] Error: Unsupported init system: $INIT_SYSTEM.$RESET"
			exit 1
			;;
	esac
}	

function check_privileges() {
	# Args:
	# 	log: Enables/Disables logging.
	#
	# Returns:
	# 	If user is root.
	
	local LOG="$1"

	if [[ "$(id -u)" -eq 0 ]]; then
		if [[ "$LOG"  == "true" ]]; then
			echo -e "${GREEN}[*] User is root.${RESET}\n"
		fi
		
		return
	else
		echo -e "${RED}[!] Error: This script requires root privileges to work.${RESET}"
		exit 1
	fi
}

# check_privileges true
# the_unix_manager_tester
