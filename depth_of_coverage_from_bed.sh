for region in `cat regions.bed | sed 's/\t/:/' | sed 's/\t/-/'`; do
  echo -n "$region "
  samtools depth -r $region reads.bam | awk '{c++;s+=$3;if($3>M)M=$3}END{print s/c, M}'
done
