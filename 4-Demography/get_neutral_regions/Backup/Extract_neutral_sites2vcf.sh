#! /bin/bash
#$ -wd /u/project/rwayne/snigenda/finwhale/Neutral_regions/neutralVCFs 
#$ -l h_rt=23:00:00,h_data=20G,h_vmem=35G
#$ -N Extract_NeutralSites2vcf
#$ -o /u/project/rwayne/snigenda/finwhale/reports/Neutral_sites2vcf.out.txt
#$ -e /u/project/rwayne/snigenda/finwhale/reports/Neutral_sites2vcf.err.txt
#$ -t 1-96
#$ -m abe

# This script extracts neutral sites from the vcf file generate at the last step of the variant calling pipeline (WGS_proc8) and put it into a new vcf file 
# Author: Annabel Beichman, modified by Sergio Nigenda
# Usage: qsub Extract_neutral_sites2vcf.sh reference population (The value for population could be "GOC", "ENP" or "ALL". If it is ALL, then it will include both populations (GOC and ENP)
# Example: qsub Extract_neutral_sites2vcf.sh Minke GOC

source /u/project/rwayne/software/finwhale/miniconda2/etc/profile.d/conda.sh
conda activate gentools

set -o pipefail

# QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub


########## Setting variables, directories and files

REF=${1}
POP=${2}

homedir=/u/project/rwayne/snigenda/finwhale
workdir=${homedir}/Neutral_regions
scriptdir=${homedir}/scripts/get_neutral_regions
outdir=${workdir}/neutralVCFs
IDX=$(printf %02d ${SGE_TASK_ID})

mkdir -p ${outdir}/${POP}

if [ ${REF} == 'Minke' ]; then
    REFERENCE=${homedir}/cetacean_genomes/minke_whale_genome/GCF_000493695.1_BalAcu1.0/GCF_000493695.1_BalAcu1.0_genomic.fasta
fi
if [ ${REF} == 'Bryde' ]; then
    REFERENCE=${homedir}/cetacean_genomes/brydes_whale_genome/DNAzoo_data/Balaenoptera_edeni_HiC.fasta
fi


if [ ${POP} == 'GOC' ] || [ ${POP} == 'ENP' ]; then
    vcfdir=${homedir}/analyses_results/structure_diversity/roh/newVcfs/${POP}
    allVCF=${vcfdir}/${POP}_PASS_${IDX}.vcf.gz
fi
if [ ${POP} == 'ALL' ]; then
    vcfdir=${homedir}/filteredvcf/all48/Minke
    allVCF=${vcfdir}/JointCalls_08_B_VariantFiltration_${IDX}.vcf.gz
fi

# This is the bed file of neutral sites that have been called and identified with the script Identify_Neutral_Regions.sh (min 10kb from genes, not in CpG island, doesn't blast to zebra fish)

neutralBed=${workdir}/HQ_neutral_sites/Final_HQ_neutral_regions.bed

# pull out neutral regions from the all_8 file (to use for getting monomorphic sites) and from the snp_8 file (for easy sfs projection)
# allVCF=all_8_rmRelatives_rmAdmixed_passingBespoke_maxNoCallFrac_1.0_rmBadIndividuals_passingFilters_raw_variants.vcf.gz

# allVCF=${vcfdir}/JointCalls_08_B_VariantFiltration_${IDX}.vcf.gz

# snpVCF=snp_8b_forEasySFS_rmRelatives_rmAdmixed_passingBespoke_maxNoCallFrac_1.0_passingBespoke_passingAllFilters_postMerge_raw_variants.vcf.gz
# snpVCF=snp_9b_forEasySFS_maxHetFilter_${maxHetFilter}_rmRelatives_rmAdmixed_passingBespoke_maxNoCallFrac_1.0_passingBespoke_passingAllFilters_postMerge_raw_variants.vcf.gz
# snp vcf first:  # for easy SFS, don't have snp sfs be gzipped 

##### Logging

cd ${outdir}/${POP}

mkdir -p ./logs
mkdir -p ./temp

# echo the input
echo "[$(date "+%Y-%m-%d %T")] Start Extracting neutral regions for ${REF} ${SGE_TASK_ID} JOB_ID: ${JOB_ID}"
echo "The qsub input"
echo "${REF} ${SGE_TASK_ID}"

PROGRESSLOG=./logs/Extract_Neutral_regions_${REF}_${IDX}_progress.log
echo -e "[$(date "+%Y-%m-%d %T")] JOB_ID: ${JOB_ID}" > ${PROGRESSLOG}


########## Extracting Neutral sites from vcfs and saving to neutral.vcf files
 
echo -e "[$(date "+%Y-%m-%d %T")]  Extracting Neutral sites with GATK SelecVariants... " >> ${PROGRESSLOG}
LOG=./logs/ExtractNeutralSites_${REF}_SelectVariants_${IDX}.log
date "+%Y-%m-%d %T" > ${LOG}

# java -jar $GATK \
# -R $REFERENCE \
# -T SelectVariants \
# --variant ${vcfdir}/${snpVCF} \
# -o $outdir/neutral.${snpVCF%.gz} \
# -L $neutralBed

# then all-sfs  (DO output as .gz)
gatk3 -Xmx15g -Djava.io.tmpdir=./temp -T SelectVariants \
-R $REFERENCE \
--variant ${allVCF} \
-L ${neutralBed} \
-o ${outdir}/${POP}/Neutral_sites_SFS_${POP}_${IDX}.vcf.gz &>> ${LOG}

exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
    echo -e "[$(date "+%Y-%m-%d %T")] FAIL" >> ${PROGRESSLOG}
    exit 1
fi
date "+%Y-%m-%d %T" >> ${LOG}
echo -e "[$(date "+%Y-%m-%d %T")] Done" >> ${PROGRESSLOG}

echo "[$(date "+%Y-%m-%d %T")] Done Extracting Neutral sites for ${REF} ${SGE_TASK_ID} Job ID: ${JOB_ID}"

conda deactivate

