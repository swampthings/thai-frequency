LOGFILE=logfile.txt
INFILE=README.md

echo "Started process at "`date` > $LOGFILE
for i in {0..10000..1}
  do 
	((counter++))
	if (( counter % 100 == 0 ))
	then
		echo $counter" words processed so far. The processing file is "`stat --printf="%s" $LOGFILE`" bytes. The time is "`date` >> $LOGFILE
	fi

 done

echo "Finished process at "`date` >> $LOGFILE



