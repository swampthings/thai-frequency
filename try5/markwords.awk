#j is the working chunk of the sentence to analyze. if j gets trimmed, then fill j back up 
#so that it's at least equal to the longest word.
#when j is at max length, then check each piece of j from longest to 1 character against the
#wordlist. if a match is found, then move the match to the outsentence, delimited by "-" ,
#and reduce j by the amount of the removed word.

#to fix
#when in the last section, it only considers one character at a time...but it should max out

BEGIN{
	split("this these are the words in the example sentence sent is an it",array)
	for (i in array){ #change to an easily searchable array
		wordlist[array[i]]++;
		}
#	for (i in wordlist) { 
#		print i, wordlist[i]
#		}
	string = "this is an example sentence with some example words in it"
	split(string,charsentence,"")
	
	longest=7
	outsentence=""
	if (length(charsentence)<longest)
		longest=length(charsentence)
	finished = 0
	fullyparsed = 0
	i = 0
#	for (i in charsentence) {
	do {
		i++
		if ((i+0)<=length(charsentence))
			j=j charsentence[i]
		else
			fullyparsed=1
		jlen = length(j)
		#if ((jlen>=longest) || ((i+0)>(length(charsentence)-longest+1))) { #analyze section when it's long enough or if it's at the end of the sentence. +1000 is convert to number
		if (jlen >= longest || fullyparsed == 1) { #should use this one, but then need to rework the end
			#print "pip", jlen, longest, i, (length(charsentence)-longest+1), (jlen>=longest) , (i>(length(charsentence)-longest+1))
			flag = -99
			k = 0
			do { #loop through all characters of section until a matching word is found
				tryphrase = substr(j,1,jlen - k)
				if (tryphrase in wordlist) {
					outsentence = outsentence "-" tryphrase
					j=substr(j,length(tryphrase)+1) #cut out the found phrase
					print "***removed '" tryphrase "'"
					flag = k
					}
				++k
				} while (k <= jlen && flag == -99)
			if (flag == -99) { #in the case there are no matching words, assume a 1-length word
				outsentence = outsentence "-" substr(j,1,1)
				print "***printed -'" substr(j,1,1) "'-"
				if (jlen > 1) { #cut off the character pushed from j to outsentance
					j=substr(j,2)
					}
				} 
			}
			print i,"debug '" j "'" jlen, fullyparsed
			if ((i+0)>length(charsentence) &&jlen <= 2)
				finished = 1
#			if ((i+0)>length(charsentence)+5 )
#				finished = 1
				
		} while (finished == 0)
	outsentence = outsentence "-"
	print outsentence

}

