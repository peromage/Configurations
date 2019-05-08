# Control Sequence Introducer
# usage: _csi_ <word> <csi_code>
_CSI_() {
    echo "\[\e[${2}\]${1}\[\e[0m\]"
}

_RET_() {
    local ret=$?
    echo "$ret"
}

_RET_FACE_() {
    local ret=$?
    if [ "$ret" -ne 0 ]; then
        echo "$(_CSI_ ":(" "31m")"
    else
        echo "$(_CSI_ ":)" "32m")"
    fi
}

# usage: _bash_style1_ <$UID>
_BASH_THEME1_() {
    case "$1" in
        0) export PS1="[$(_CSI_ "\u@\h" "31m"):\W]# " ;;
        *) export PS1="[$(_CSI_ "\u@\h" "32m"):\W]$ " ;;
    esac
}

# usage: _bash_style1_ <$UID>
_BASH_THEME2_() {
    case "$1" in
        0) export PS1="[$(_CSI_ "\u@\h" "31m"):\W \[\$?\]]# " ;;
        *) export PS1="[$(_CSI_ "\u@\h" "32m"):\W \[\$?\]]$ " ;;
    esac
}

# usage: _bash_style1_ <$UID>
_BASH_THEME3_() {
    case "$1" in
        0) export PS1="$(_CSI_ "\u@\h" "31m") \w $(_RET_FACE_)\n+++ " ;;
        *) export PS1="$(_CSI_ "\u@\h" "32m") \w $(_RET_FACE_)\n--- " ;;
    esac
}