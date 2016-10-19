#!/bin/sh

set -o noclobber
LOCKDIR="/tmp/tts-read-selection-lock"
PIDFILE="${LOCKDIR}/pid"

toppid="$(cat "${PIDFILE}")"
if [ $? != 0 ]; then
	exit 0
fi

pidlist=$(pstree -p -A -n "${toppid}" | \
		grep -Po '(?<=\().*?(?=\))' | \
		sort -u --reverse | tail -3)

for p in ${pidlist}; do
	kill "$p" 1>&2 2>/dev/null
done

rm -rf "${LOCKDIR}"
exit 0
