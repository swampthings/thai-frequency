#INFILE=/mnt/ramdisk/wiki-mini.txt
INFILE=/mnt/ramdisk/wiki-orig.txt
OUTFILE=/mnt/ramdisk/outfileth.txt
WORDFILE=/mnt/ramdisk/wordlist123k.txt
LOGFILE=/mnt/ramdisk/logfile.txt

#wordfile must be ordered longest to shortest
echo "words|bytes|time|notes" > $LOGFILE
beforesize=`du -b $INFILE | awk '{printf $1}'`
echo "|$beforesize|"`date`"|started process" >> $LOGFILE

counter=0
echo word"|"count > $OUTFILE

while read -r line; do
	line2=`echo $line | tr -d '\r'`

	parallel -a $INFILE --will-cite --block 50M --pipe-part "sed -e 's/${line2}/\n/g'" >$INFILE.bak
	mv $INFILE.bak $INFILE		
	aftersize=`du -b $INFILE | awk '{printf $1}'`
	wordlen=`expr length "$line"`
	WORDCOUNT=`echo "$(( ( $beforesize - $aftersize ) / ( 3 * $wordlen - 1 ) ))"`
	#WORDCOUNT=`echo "$(( ( $beforesize - $aftersize ) / ( 1 * $wordlen - 1 ) ))"` #for ec2
	#echo $line2"|"$WORDCOUNT"|"$beforesize"|"$aftersize"|"$wordlen >> $OUTFILE
	echo $line2"|"$WORDCOUNT >> $OUTFILE
	beforesize=$aftersize


	((counter++))
	if (( counter % 100 == 2 ))
	then
		gawk 'BEGIN {ORS="\n"}{if (a!=$0) {print $0};a=$0;}' $INFILE >$INFILE.reduce
		mv $INFILE.reduce $INFILE
		echo $counter"|"`stat --printf="%s" $INFILE`"|"`date` >> $LOGFILE
		beforesize=`du -b $INFILE | awk '{printf $1}'`	
	fi

	if (( counter >= 15)); then
		break
	fi
done < $WORDFILE

echo "|$beforesize|"`date`"|finished process" >> $LOGFILE


