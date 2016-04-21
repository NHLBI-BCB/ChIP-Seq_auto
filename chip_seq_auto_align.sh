#!/bin/sh
#
# usage of the script (sh chipseq_align_test7.sh sample_name fastq_location output_folder)
# This script takes the compressed ChIPSeq files for each sample from facility directory , 
# decompresses them to one fastq then aligns them to the mm9 and
# creates the bigwig files in its corresponding tag directories with HOMER
# created by Vivek Das
##Commands

echo "find the ChIPSeq files from the facility directory..."
echo "my facility directory= $2"
s=$1
sloc=$2
soutloc=$3
GENOME=/path_to/softwares/IGVTools/genomes/hg19.chrom.sizes
bigwig=/path_to/softwares/HOMER/.//bin/makeUCSCfile 

mkdir $soutloc

echo "performing assembly to create one fastq file ..."
zcat $sloc/*.fastq.gz > $soutloc/$s.fastq

### moving to the directory of the fastq
echo "reach out to the fastq directory..."

### stats count
echo "counting statistics for one fastq file..."
echo "show fastq file with location = $soutloc/$s.fastq"
cat $soutloc/$s.fastq| echo $((`wc -l`/4))> $soutloc/$s.counts
echo "finished decompressing and stats count.."

### to assemble

cd $soutloc
echo "Aligning sample $s.fastq..."
bowtie -t -v 2 -m 1  -S -p 8 --phred33-quals /db/bowtie/hg19/hg19 "$s.fastq" "$s.sam"

## sam to bam conversion
echo "Creating the bam..."
samtools view -bS $s.sam > $s.bam
echo "Sorting aligned reads..."
samtools sort $s.bam $s.sorted
echo "Computing statistics..."
samtools flagstat $s.sorted.bam > $s.flagstat

### Running Homer
echo "Reaching sam directory..."
cd $soutloc

#### Running the TagDirectory of HOMER
echo "Making Tag Directory with HOMER..."
/scratch/GT/softwares/HOMER/.//bin/makeTagDirectory ${s}_tag/ $s.sam -format sam
### ucscnormalzed files
### creating the UCSC files with HOMER
echo "Making UCSC files with HOMER..."
$bigwig ${s}_tag/ -o auto -bigWig $GENOME
rm $s.bam
rm $s.sam
rm $s.fastq
echo "ChIPSeq $s sample aligned and UCSC tracks generated.."
echo "done"
