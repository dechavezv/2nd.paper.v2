#!/bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/rails.project
#$ -l h_rt=190:00:00,h_data=16G,highp,h_vmem=50G
#$ -N HC_rail
#$ -o /u/scratch/d/dechavez/readsRailsFulgent/log/
#$ -e /u/scratch/d/dechavez/readsRailsFulgent/log/
#$ -m abe
#$ -M dechavezv

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load java
module load samtools
source activate gatk-intel
                                     
export DIREC=/u/home/d/dechavez/project-rwayne/rails.project
export OUT=/u/home/d/dechavez/project-rwayne/rails.project
export BAM=${1}
export Reference=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/chr_and_superScafolds/InaccesibleRail.chr.fa
export temp=/u/home/d/dechavez/project-rwayne/rails.project/temp

cd ${DIREC}

echo "#######"
echo "Haplotype Caller for '$1' "
echo "########"

/u/home/d/dechavez/project-rwayne/gatk-4.1.4.1/gatk --java-options "-Xmx16G" \
HaplotypeCaller \
-R ${Reference} \
-I ${BAM} \
-O ${OUT}/${BAM%.bam}.g.vcf.gz \
-ERC BP_RESOLUTION \
-mbq 10 \
--output-mode EMIT_ALL_ACTIVE_SITES \
-dont-use-soft-clipped-bases

echo "#######"
echo "Done haplotype calling for '$1'"     
echo "########"
