#!/bin/sh
unset TMPDIR
cwd="$(pwd)/"
filename=cscope.files

#find ${cwd} -type f  -name "*.[chxsS]" >-o -name "Makefile" \
#        -o -name "*.inc" -o -name "*.mk" \
#        -o -name "*.sh" >cscope.files && cscope -bkq || \
#	echo "Error: failed to generate cscope database" 1>&2

find ${cwd} -type f  -name "*.[chxsS]"  >${cwd}/${filename} && \
find ${cwd} -type f  -name "*.cpp"     >>${cwd}/${filename} && \
find ${cwd} -type f  -name "*.hpp"     >>${cwd}/${filename} && \
find ${cwd} -type f  -name "*.cc"      >>${cwd}/${filename} && \
find ${cwd} -type f  -name "Makefile"  >>${cwd}/${filename} && \
find ${cwd} -type f  -name "*.inc"     >>${cwd}/${filename} && \
find ${cwd} -type f  -name "*.mk"      >>${cwd}/${filename} && \
find ${cwd} -type f  -name "*.sh"      >>${cwd}/${filename} && \
cscope -bkq && rm -f ${cwd}/${filename} || \
        echo "Error: failed to generate cscope database" 1>&2
