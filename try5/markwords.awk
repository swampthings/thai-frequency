#j is the working chunk of the sentence to analyze. if j gets trimmed, then fill j back up 
#so that it's at least equal to the longest word.
#when j is at max length, then check each piece of j from longest to 1 character against the
#wordlist. if a match is found, then move the match to the outsentence, delimited by "-" ,
#and reduce j by the amount of the removed word.

BEGIN{
	split("this these are the words in the example sentence is an it",array)
	for (i in array){ #change to an easily searchable array
		wordlist[array[i]]++;
		}
#	for (i in wordlist) { 
#		print i, wordlist[i]
#		}
	string = "this is an example sentence with some example words in it"
	split(string,charsentence,"")
	longest=8
	outsentence=""
	cutoff=length(charsentence)-longest+1
	for (i in charsentence) {
		j=j charsentence[i]
		jlen = length(j)
		if (length(j)>=longest || i>cutoff) {
			flag = -99
			for (k = 0; k <= jlen; ++k) {
				tryphrase = substr(j,1,jlen - k)
				if (tryphrase in wordlist) {
					fishword =  tryphrase
					outsentence = outsentence "-" fishword
					flag = k
					}
				}
			if (flag == -99) { #in the case there are no matching words, assume a 1-length word
				outsentence = outsentence "-" substr(j,1,1)
				if (jlen > 1) { 
					j=substr(j,2)
					}
				} else { #in the case there are matching words
				fishwordlen=length(fishword)
				if (fishwordlen >= jlen) {
					j="" #needed because of how substr works
					} else {
					j=substr(j,fishwordlen+1)
					}
				} 
			}
		}
	outsentence = outsentence "-"
	print outsentence

}

