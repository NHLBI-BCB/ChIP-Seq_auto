#!/bin/bash
#$ -S /bin/bash
if [ $# -lt 2  ]
    then
    echo "Usage: `basename $0` signal_BAM input_BAM [output_prefix] outdir [hs|mm]"
exit
fi

tbam=$1
cbam=$2
name=$3
outdir=$4
species=$5

: ${macs2:=/home/vdas/MyVE/bin/macs2}

### Automated running of macs2.1
### If the output_prefix has K27me3 as a part in the long string then executes broad macs2.1 peak calling else executes narrow macs2.1 peak calling
### qthreshold are as of now hard-coded for both broad and narrow peak calling

if  [[ $name == *"K27me3"* ]];
then
    echo "Running broad peak calling for the sample $name ..."
    $macs2 callpeak -t $tbam -c $cbam -f BAM --keep-dup=1 -n $name --outdir $outdir -q 0.1 -B --SPMR --broad -g $species --broad-cutoff 0.1 --nomodel
    echo "Broad peak calling is over and output is located in $outdir ..."
else
    echo "Narrow peak calling for the sample $name ..."
    $macs2 callpeak -t $tbam -c $cbam -f BAM --keep-dup=1 -n $name --outdir $outdir -q 0.05 -B --SPMR -g $species --nomodel
    echo "Narrow peak calling is over and output is located in $outdir ..."
fi
echo "The execution is over ..."
