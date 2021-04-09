#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/Chr_Joint/2021.31Genomes
#$ -l h_rt=65:00:00,h_data=10G,h_vmem=134G,highp
#$ -N RunSnpEffRails
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/Chr_Joint/2021.31Genomes/log/
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/Chr_Joint/2021.31Genomes/log/
#$ -m abe
#$ -t 1-35:1

source /u/local/Modules/default/init/modules.sh
module load java

IDX=$(printf %02d $SGE_TASK_ID)


################################################################################

### Set variables

SNPEFFDIR=/u/home/d/dechavez/project-rwayne/snpEff
REF=AtlantChr
#REF=AtlantScaf
WORKDIR=/u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf/snpEff/${REF}
VCF=/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/Chr_Joint/2021.31Genomes
Database=Atro.0055

mkdir -p ${WORKDIR}

IDX=$(printf ${SGE_TASK_ID}) # this is SGE specific array id, essentially the contig list 

################################################################################################3
### logging 

cd ${WORKDIR}

# starts logging 
LOGDIR=${WORKDIR}/logs/annotation
mkdir -p ${LOGDIR}
PROGRESSLOG=./logs/progress_${REF}.log
echo -e "[$(date "+%Y-%m-%d %T")] JOB_ID: ${JOB_ID}" > ${PROGRESSLOG}
echo -e "[$(date "+%Y-%m-%d %T")] snpEff annotations based on ${Database} ... " >> ${PROGRESSLOG}

LOG=${LOGDIR}/rails_snpEff_${IDX}.log
date "+%Y-%m-%d %T" > ${LOG}

################################################################################

### snpEFF annotations
cd ${SNPEFFDIR}
java -Xmx10g -jar snpEff.jar -nodownload -v -canon -stats ${LOGDIR}/${REF}_chr${IDX}.html \
${Database} \
${VCF}/LS_joint_chr${IDX}_TrimAlt_Annot_Mask_Filter.vcf.gz > \
${VCF}/LS_joint_chr${IDX}_TrimAlt_Annot_Mask_Filter.vcf.snpEff.vcf 2> ${LOG}

exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
    echo -e "[$(date "+%Y-%m-%d %T")] FAIL" >> ${PROGRESSLOG}
    exit 1
fi
echo -e "[$(date "+%Y-%m-%d %T")] Done" >> ${PROGRESSLOG}
 
cd ${VCF}
# gzip the files 
/u/home/d/dechavez/tabix-0.2.6/bgzip LS_joint_chr${IDX}_TrimAlt_Annot_Mask_Filter.vcf.snpEff.vcf
/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf LS_joint_chr${IDX}_TrimAlt_Annot_Mask_Filter.vcf.snpEff.vcf.gz
