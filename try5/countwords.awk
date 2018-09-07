BEGIN {
	FS="-"
}
{ 
	for(i=1; i < NF;i++) {
		if (length($i)>0)
			array[$i]++
		}
}
END {
	for (j in array)
		print j, array[j]
}

