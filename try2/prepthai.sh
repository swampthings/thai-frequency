origfile=data/thaiex-orig.xml
outfile=data/wiki-orig.txt

perl -CSD -pe "s/[\P{InThai}]+/\n/g" $origfile >$outfile.bak1
gawk 'BEGIN {RS="^$"}{print "\n" $0 "\n"}' $outfile.bak1 >$outfile.bak2
rm $outfile.bak1
gawk 'BEGIN {ORS="\n"}{if (length($0)>1) {print $0}}' $outfile.bak2 >$outfile.bak3
#perl -CSD -pe "s/\n+/\n/g" $outfile.bak2 >$outfile
rm $outfile.bak2
gawk 'BEGIN {ORS="\n"}{if (a!=$0) {print $0};a=$0;}' $outfile.bak3 >$outfile
rm $outfile.bak3


