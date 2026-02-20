#!/bin/bash

if [ "${4}x" == "x" ] ; then
	echo "USAGE: convert.sh file encoding_marker from_encoding to_encoding"
	exit
fi

FILE=${1}
MARKER=${2}
FROM=${3}
TO=${4}

if [ "$(file -bi ${FILE} | grep ${MARKER})" != "" ] ; then
	ORIG=${FILE}.orig.${FROM}
	echo "cp ${FILE} ${ORIG}; iconv -f ${FROM} -t ${TO} -o ${FILE} ${ORIG}"
	cp ${FILE} ${ORIG}
	iconv -f ${FROM} -t ${TO} -o ${FILE} ${ORIG}
fi
