INFILE=/mnt/ramdisk/wiki-mini.txt
OUTFILE=/mnt/ramdisk/outfileth.txt
WORDFILE=/mnt/ramdisk/wordlist123k.txt
#wordfile must be ordered longest to shortest
counter=0
echo word"|"count > $OUTFILE
while read -r line; do
	line2=`echo $line | tr -d '\r'`
	#line2=`echo ${line} | awk '{print $1'}`
	WORDCOUNT=`cat $INFILE | parallel --blocksize=50M --will-cite --pipe grep -o "$line2" | wc -l`
	#WORDCOUNT=`grep -o "$line2" $INFILE | wc -l`
	echo $line2"|"$WORDCOUNT >> $OUTFILE

	if (( $WORDCOUNT > 0 )); then
		parallel -a $INFILE --will-cite --block 50M --pipe-part "sed -e 's/${line2}/\n/g'" >$INFILE.bak
		#cat $INFILE | parallel -k --will-cite --pipe 'sed -e "s/${line2}/\n/g"' >$INFILE.bak #doesn't work
		mv $INFILE.bak $INFILE		
		#sed -i -e "s/${line2}/\n/g" $INFILE		
		#tr -s '\n' <$INFILE >$INFILE.bak
		#mv $INFILE.bak $INFILE
		#sed -i -e "s/-*${line2}-*/-/g" $INFILE
	fi
	((counter++))
	#if (( counter % 10 == 0 ))
	#then
	#	gawk 'BEGIN {ORS="\n"}{if (a!=$0) {print $0};a=$0;}' $INFILE >$INFILE.bak
	#	mv $INFILE.bak $INFILE
	#fi

	#if (( counter >= 15)); then
	#	break
	#fi
done < $WORDFILE


#50M=55 seconds
#100M=57 seconds 
#10M 60 seconds
#260M=56 seconds
#500M=70 seconds
#1M=123 seconds