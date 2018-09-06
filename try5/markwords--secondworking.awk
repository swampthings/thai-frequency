#j is the working chunk of the sentence to analyze. if j gets trimmed, then fill j back up 
#so that it's at least equal to the longest word.
#when j is at max length, then check each piece of j from longest to 1 character against the
#wordlist. if a match is found, then move the match to the outsentence, delimited by "-" ,
#and reduce j by the amount of the removed word.

#to fix
#when in the last section, it only considers one character at a time...but it should max out

BEGIN{
	delimiter="-"
	longest=0
	split("this these are the words in the example sentence sent is an it",array)
	for (i in array){ #change to an easily searchable array
		wordlist[array[i]]++;
		if (length(array[i])>longest)
			longest = length(array[i])
		}
#	for (i in wordlist) { 
#		print i, wordlist[i]
#		}
	string = "mumbothis is an example sentence with some example words in itjumbo sentence"
	split(string,charsentence,"")
	
	outsentence=""
	fullyparsed = 0
	i = 0
	sentlen=length(charsentence)
	if (sentlen<longest)
		longest=sentlen
	do {
		i++
		if ((i+0)<=sentlen)
			j=j charsentence[i]
		else
			fullyparsed=1
		jlen = length(j)
		if (jlen >= longest || fullyparsed == 1) { #analyze section when it's long enough or if it's at the end of the sentence.
			flag = -99
			k = 0
			do { #loop through all characters of section until a matching word is found
				tryphrase = substr(j,1,jlen - k)
				if (tryphrase in wordlist) {
					outsentence = outsentence delimiter tryphrase
					j=substr(j,length(tryphrase)+1) #cut out the found phrase
					flag = k
					}
				++k
				} while (k <= jlen && flag == -99)
			if (flag == -99 && jlen > 0) { #in the case there are no matching words, assume a 1-length word. jlen>0 for the case where the last text in a sentence is a word.
				outsentence = outsentence delimiter substr(j,1,1)
				if (jlen > 1) { #cut off the character pushed from j to outsentance
					j=substr(j,2)
					}
				} 
			}
		#print i,"debug '" j "'" jlen, fullyparsed
		} while (!((i+0)>sentlen &&jlen <= 1))
	outsentence = outsentence delimiter
	print outsentence
	print "longest: " longest

}

