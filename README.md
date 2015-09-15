# ChIP-Seq_auto
To create an auto aligner for ChIP-Seq data
usage of the script (sh chipseq_align_test7.sh sample_name fastq_location output_folder)
This script takes the compressed ChIPSeq files for each sample from facility directory , 
decompresses them to one fastq then aligns them to the hg19 and
creates the bigwig files in its corresponding tag directories with HOMER
created by Vivek Das

Script to run
`sh chip_seq_auto_align.sh sample_name fastq_location output_folder`
