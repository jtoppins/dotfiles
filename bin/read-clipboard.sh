#!/bin/sh

set -o noclobber
LOCKDIR="/tmp/tts-read-selection-lock"
PIDFILE="${LOCKDIR}/pid"

if mkdir "${LOCKDIR}" &>/dev/null; then
	trap 'rm -rf "${LOCKDIR}"' 0
	echo "$$" > ${PIDFILE}
	trap 'exit 3' 1 2 3 15
else
	otherpid="$(cat "${PIDFILE}")"
	if [ $? != 0 ]; then
		echo "lock failed, PID ${otherpid} is active" >&2
		exit 4
	fi
	if ! kill -0 $otherpid &>/dev/null; then
		rm -rf "${LOCKDIR}"
		exec "$0" "$@"
	else
		echo "lock failed, PID ${otherpid} is active" >&2
		exit 4
	fi
fi

xclip -selection clipboard -o | festival --tts -b
exit 0
