#!/bin/sh

set -o noclobber
LOCKDIR="/tmp/tts-read-selection-lock"
PIDFILE="${LOCKDIR}/pid"

if mkdir "${LOCKDIR}" &>/dev/null; then
	trap 'rm -rf "${LOCKDIR}"' 0
	echo "$$" > ${PIDFILE}
	trap 'exit 3' 1 2 3 15
else
	if ! test -f "${PIDFILE}" || ! kill -0 "$(cat "${PIDFILE}")" &>/dev/null; then
		rm -rf "${LOCKDIR}"
		exec "$0" "$@"
	else
		echo "lock failed, PID $(cat "${PIDFILE}") is active" >&2
		exit 4
	fi
fi

test -d ${LOCKDIR} && echo "lock directory exists!" || exit 100

SPEECHTXT="${LOCKDIR}/text"
SPEECHWAV="${LOCKDIR}/text.wav"
xclip -selection clipboard -o > ${SPEECHTXT}
flite --setf duration_stretch=0.85 -f "${SPEECHTXT}" -o "${SPEECHWAV}"
play "${SPEECHWAV}"
exit 0
