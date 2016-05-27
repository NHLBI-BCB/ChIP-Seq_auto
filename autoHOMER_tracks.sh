#!/bin/bash
#$ -S /bin/bash
if [ $# -lt 2  ]
then
	echo "Usage: `basename $0` sorted_BAM_loc output_prefix"
	exit
fi


bam_loc=$1
s=$2
## variable initialization
: ${GENOME:=/path/softwares/IGVTools/genomes/hg19.chrom.sizes}
: ${bigwig:=/path/softwares/HOMER/.//bin/makeUCSCfile}
: ${maketagdir:=/path/softwares/HOMER/.//bin/makeTagDirectory}
: ${inbamloc:=/path/vdas/pietro/ChIP-Seq/output}

cd $bam_loc/${s}
echo "Reaching bam directory..."
#### Running the TagDirectory of HOMER
echo "Making Tag Directory with HOMER in $bam_loc/${s} ..."
$maketagdir ${s}_tag/ ${s}.sorted.bam -format bam
### ucscnormalzed files
### creating the UCSC files with HOMER
echo "Making UCSC files with HOMER..."
$bigwig ${s}_tag/ -o auto -bigWig $GENOME
echo "UCSC tracks generated for $s with HOMER located in $bam_loc/${s}/${s}_tag ..."
echo "done"
