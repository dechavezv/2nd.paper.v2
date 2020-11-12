#$ -l highp,h_rt=21:00:00,h_data=1G
#$ -N Get_phylogeny
#$ -cwd
#$ -m bea
#$ -o /u/scratch/d/dechavez/rails.project/VCF/Indv/Chr/log/
#$ -e /u/scratch/d/dechavez/rails.project/VCF/Indv/Chr/log/
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load python


export VCF=/u/scratch/d/dechavez/rails.project/VCF/Joint
export SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/3-Phylogenomics/Write_25kb

echo '###############'
echo Coding_Bed_Files
echo '###############'

cd ${VCF}
cat Window*.txt > Allwindows25kb.Aug6.2020.rails.txt
python ${SCRIPT}/Write_BedFile.Rail.py Allwindows25kb.Aug6.2020.rails.txt 25kb_GoodQ_rails.bed


