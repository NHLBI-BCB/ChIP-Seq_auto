# ChIP-Seq_auto
To create an auto aligner for ChIP-Seq data
usage of the script (sh chipseq_align_test7.sh sample_name fastq_location output_folder)
This script takes the compressed ChIPSeq files for each sample from facility directory , 
decompresses them to one fastq then aligns them to the hg19 and
creates the bigwig files in its corresponding tag directories with HOMER
created by Vivek Das

Remember to install the necessary depedancy softwares at your desired location for use the script for your benefits. Some of the paths are hardcoded in the variable locations which can be changed as per the users compatibility.
Script to run as per the requirements

`sh chip_seq_auto_align.sh sample_name fastq_location output_folder`

`sh homer_peak_call_TF.sh tag_dir_loc1 tag_dir_loc2`

`sh homer_peak_call_histone.sh tag_dir_loc1 tag_dir_loc2`

`sh multipeak_call_TF.sh sample_name bam_location1 bam_location2 output_folder`

`sh multipeak_call_histone.sh sample_name bam_location1 bam_location2 output_folder`
