#! /bin/bash


if [ $# -lt 1 ]; then
	echo "Usage: $0 signatureSize blankPages <input.pdf> <output.pdf>" 
	exit 1
fi

SIGSIZE=$1
INAME="$3"
DIR=/tmp/$INAME.tmp
ONAME=`basename $INAME .pdf`
BLANK=$DIR/blankpage
WITHBLANK=$DIR/withblank
TMP0=$DIR/tmp0
TMP1=$DIR/tmp1
TMP2=$DIR/tmp2
ONAME="$4"

mkdir $DIR

echo "" | ps2pdf -sPAPERSIZE=a4 - $BLANK
cp $INAME $WITHBLANK
COUNT="$2"
for (( a=0; a <COUNT; a++ ))
do
	cp $WITHBLANK $WITHBLANK.copy
	pdftk A=$BLANK B=$WITHBLANK.copy cat A1-end B1-end A1-end output $WITHBLANK
done
echo "" | ps2pdf -sPAPERSIZE=a4 - $BLANK
pdf2ps $WITHBLANK $TMP0
psbook -s$SIGSIZE $TMP0 $TMP1
psnup -pa4 -2 $TMP1 $TMP2
ps2pdf -sPAPERSIZE=a4 $TMP2 $ONAME

rm -rf $DIR
