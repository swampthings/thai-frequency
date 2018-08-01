origfile=thaiexmini.xml
outfile=origthmini.txt

perl -CSD -pe "s/[\P{InThai}]+/\r/g" $origfile >$outfile.bak
gawk 'BEGIN {RS="^$"}{print "-" $0 "-"}' $outfile.bak >$outfile.bak2
rm $outfile.bak
perl -CSD -pe "s/\r+/\r/g" $outfile.bak2 >$outfile
rm $outfile.bak2
#untested