#! /bin/bash
#$ -wd /u/scratch/d/dechavez/SA.VCF
#$ -l h_rt=04:00:00,h_data=2G
#$ -o /u/scratch/d/dechavez/SA.VCF/log/
#$ -e /u/scratch/d/dechavez/SA.VCF/log/
#$ -m abe
#$ -M dechavezv
#$ -N getDmagBen
#$ -t 1-38:1

cd /u/scratch/d/dechavez/SA.VCF

FILE=SA_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_Mask_Filter_VEP_Table_protein_coding.txt

# Get damaging variants

head -1 ${FILE} > ${FILE%.txt}_damaging.txt

grep "frameshift_variant\|splice_acceptor_variant\|splice_donor_variant\|start_lost\|stop_gained\|stop_lost\|deleterious\|inframe_insertion\|inframe_deletion" ${FILE} | grep -v 'FAIL' | grep -v 'low_confidence' \
>> ${FILE%.txt}_damaging.txt


# Get benign variants

head -1 ${FILE} > ${FILE%.txt}_benign.txt

grep "splice_region_variant\|stop_retained_variant\|synonymous\|tolerated\|missense" ${FILE} | grep -v 'FAIL' | grep -v 'low_confidence' |\
grep -v "frameshift_variant\|splice_acceptor_variant\|splice_donor_variant\|start_lost\|stop_gained\|stop_lost\|deleterious\|inframe_insertion\|inframe_deletion" \
>> ${FILE%.txt}_benign.txt
