#!/bin/sh
#
#$ -N ChIPSeq_ovaca_merge_bams_24052016
#$ -cwd
#$ -e err_ChIPSeq_ovaca_merge_bams_24052016.log
#$ -o out_ChIPSeq_ovaca_merge_bams_24052016.log
#$ -S /bin/sh
#$ -M vivek.das@xyz.com
#$ -m bea
#$ -l h_vmem=25G

sambamba="/home/vdas/tools/sambamba/build/sambamba"
bamloc="/path/vdas/client/ChIP-Seq/output"

samples="S_1
S_2
S_3
...
S_N"

for s in $samples; do
    mkdir $bamloc/${s}"_final"
    echo "Running for sample $bamloc/${s} ..."
    $sambamba sort -o $bamloc/${s}"_final"/${s}"_sorted.bam" -p -t 12 $bamloc/${s}/${s}".sorted.bam"
    $sambamba sort -o $bamloc/${s}"_final"/${s}"_2_sorted.bam" -p -t 12 $bamloc/${s}"_2"/${s}"_2.sorted.bam"
    $sambamba merge -p -t 12 $bamloc/${s}"_final"/${s}"_final.sorted.bam" $bamloc/${s}"_final"/${s}"_sorted.bam" $bamloc/${s}"_final"/${s}"_2_sorted.bam"
    $sambamba flagstat -p -t 12 $bamloc/${s}"_final"/${s}"_final.sorted.bam" > $bamloc/${s}"_final"/${s}"_final".flagstat
    echo "Output of final merged bam for rerun samples are located in $bamloc/${s}"_final" ..."
    done
echo "done"
