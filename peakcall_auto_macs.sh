#!/bin/sh
#
# usage of the script (sh multipeakcall.sh sample_name bam_location1 bam_location2 output_folder)
# run sh multi_peak_call.sh multipeakout /scratch/GT/vdas/serena_b/ChIPSeq/FASTQ_2015/Sample_S_7_15DTAMO_S11395 /scratch/GT/vdas/serena_b/ChIPSeq/FASTQ_2015/Sample_S_2_10DCT_INPUT_S11390 /scratch/GT/vdas/serena_b/ChIPSeq/FASTQ_2015
# This script is created for the OvaCa project to run the MACS1.4 and MACS2 for 40 samples from 8 patients
# created by Vivek Das on 14-09-2014
#
##Commands

s=$1
sinloc1=$2
sinloc2=$3
soutloc=$4
#sbedout=$4
#GENOME=/scratch/GT/softwares/IGVTools/genomes/hg19.chrom.sizes
#peaks=/scratch/GT/softwares/HOMER/.//bin/findPeaks 
#cd /scratch/GT/vdas/serena_b/ChIPSeq/FASTQ_2015/
#sicerloc=/scratch/GT/softwares/SICER_V1.1/SICER/
#sicerbed=/scratch/GT/vdas/serena_b/ChIPSeq/FASTQ_2015/bed_files
#folder=/scratch/GT/vdas/serena_b/
#rsegpeak=/scratch/GT/softwares/rseg-0.4.8/bin/rseg-diff
#rsegmm9bed=/scratch/GT/softwares/rseg-0.4.8/data/mm9/mouse-mm9-size.bed
#rsegdeadzones=/scratch/GT/softwares/rseg-0.4.8/data/deadzones/deadzones-mm9-k51.bed

#resegout=/scratch/GT/vdas/serena_b/ChIPSeq/FASTQ_2015/

echo "Running MACS 1.4 on the bam files with control for peak calling..."
### if chip is of protein/tf turn --nomodel True is chip is of histone turn of --nomodel
macs14 -t $sinloc1/*.sorted.bam  -c $sinloc2/*.sorted.bam -n {$s}_macs14_out --format=BAM --keep-dup=1 --pvalue=1e-5 --gsize=2.7e9 --wig -S
echo "Finishing MACS 1.4 on the bam files..."

echo "Runnnig MACS2 on the bam files for peak calling..."
macs2 callpeak -t $sinloc1/*.sorted.bam -c $sinloc2/*.sorted.bam -f BAM -n {$s}_macs2_out --gsize=2.7e9 -B --keep-dup=1 --pvalue=1e-5 --broad
#macs2 callpeak -t $sinloc1/*.sorted.bam -c $sinloc2/*.sorted.bam -f SAM -g hs -n macs2_sl_local -B -q 0.05 --slocal 5000 --llocal 50000
echo "Finising MACS2 on the bam files..."
echo "Peak calling for histone modifications done with both MACS1.4 and MACS2.."
echo "done"
