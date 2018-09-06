

BEGIN{
	split("this these are the words in the example sentence is an it",array)
	for (i in array){
		wordlist[array[i]]++;
		#print i, array[i]
		}
	for (i in wordlist) { 
		print i, wordlist[i]
		}
	string = "this is an example sentence with some example words in it"
	split(string,charsentence,"")
	longest=8
	outsentence=""
	cutoff=length(charsentence)-longest+1
	for (i in charsentence) {
		j=j charsentence[i]
		l=j
		jlen = length(j)
#		if (jlen>=longest) {
		if (length(j)>=longest || i>cutoff) {
			flag = -99
			for (k = 0; k <= jlen; k++) {
					#print "*****"
					tryphrase = substr(j,1,jlen - k)
					if (tryphrase in wordlist) {
						print "we found '" tryphrase "' !!!!!"
						fishword =  tryphrase
						outsentence = outsentence "-" fishword
						flag = k
						}
						if (flag == -99 && k == jlen) {
							outsentence = outsentence "-" substr(j,1,1)
							#print "diag2: '" j "'", substr(j,1,1)
							}
				}
			
			if (flag != -99) {
				fishwordlen=length(fishword)
				if (fishwordlen >= jlen) {
					j=""
					#print "******"
					} else {
					j=substr(j,fishwordlen+1)
					}
				#print "diag: '" j "'", "'" fishword "'", fishwordlen, jlen, flag
				} 
#			if (flag == 0 && i<cutoff) { 
			if (flag == -99 && jlen > 1) { 
				j=substr(j,2)
				}
			}
		print i, charsentence[i], length(l), "'" l "'"
		}
	outsentence = outsentence "-"
	print outsentence
	#print i, charsentence[i], length(l), "'" l "'", length(j), "'" j "'", "cutoff " cutoff

}

#j is the working chunk of the sentence to analyze. if j gets trimmed, then fill j back up 
#so that it's at least equal to the longest word.
#when j is at max length, then check each piece of j from longest to 1 character against the
#wordlist. if a match is found, then move the match to the outsentence, delimited by "-" ,
#and reduce j by the amount of the removed word.
