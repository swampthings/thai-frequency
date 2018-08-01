INFILE=origth2.txt
OUTFILE=outfileth.txt
WORDFILE=freqword.txt
#wordfile must be ordered longest to shortest
counter=0
echo word"|"count > $OUTFILE
while read -r line; do
	line2=`echo $line | tr -d '\r'`
	#line2=`echo ${line} | awk '{print $1'}`
	#WORDCOUNT=`cat $INFILE | parallel --blocksize=50M --will-cite --pipe grep -o "$line2" | wc -l`
	WORDCOUNT=`grep -o "$line2" $INFILE | wc -l`
	echo $line2"|"$WORDCOUNT >> $OUTFILE

	if (( $WORDCOUNT > 0 )); then
		#parallel -a $INFILE --will-cite --block 50M --pipe-part "sed -e 's/${line2}/\n/g'" >$INFILE.bak
		sed -i -e "s/${line2}/\n/g" $INFILE
		#cat $INFILE | parallel -k --will-cite --pipe 'sed -e "s/${line2}/\n/g"' >$INFILE.bak #doesn't work
		#mv $INFILE.bak $INFILE		
		#sed -i -e "s/${line2}/\n/g" $INFILE		
		#tr -s '\n' <$INFILE >$INFILE.bak
		#mv $INFILE.bak $INFILE
		#sed -i -e "s/-*${line2}-*/-/g" $INFILE
	fi
	((counter++))
	if (( counter >= 15)); then
		break
	fi
done < $WORDFILE

