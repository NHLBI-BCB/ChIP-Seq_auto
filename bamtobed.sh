###Running bamToBed on all bam files in a folder to enable to run SICER V.1 on them
### created by Vivek Das

cd /path_to/bam_folder/
for x in `ls -l S*/*.sorted.bam` ; do
	bamToBed -i "$x" > "${x%.bam}.bed"
done
