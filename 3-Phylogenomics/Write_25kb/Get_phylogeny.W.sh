#$ -l highp,h_rt=21:00:00,h_data=1G
#$ -N Get_phylogeny
#$ -cwd
#$ -m bea
#$ -o /u/scratch/d/dechavez/rails.project/VCF/Indv/Chr/log/
#$ -e /u/scratch/d/dechavez/rails.project/VCF/Indv/Chr/log/
#$ -M dechavezv


source /u/local/Modules/default/init/modules.sh
module load python

i=W

export VCF=/u/scratch/d/dechavez/rails.project/VCF/Joint
export SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/3-Phylogenomics/Write_25kb

echo '###############'
echo Coding_Bed_Files
echo '###############'

cd ${VCF}
python ${SCRIPT}/SlidingWindowRails.py LS_joint_chr${i}_TrimAlt_Annot_Mask_Filter.vcf.gz 25000 10000 PseudoChr_${i} > Windows_25kb_filtered_Phylogeny.rails.${i}.txt
