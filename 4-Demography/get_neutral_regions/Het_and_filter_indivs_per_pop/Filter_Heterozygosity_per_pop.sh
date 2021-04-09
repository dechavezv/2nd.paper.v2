#! /bin/bash
#$ -wd /u/project/rwayne/snigenda/finwhale/Neutral_regions/neutralVCFs 
#$ -l h_rt=10:00:00,h_data=10G,h_vmem=15G
#$ -N HetFilt_NeutralSites
#$ -o /u/project/rwayne/snigenda/finwhale/reports/NeutralSites_HetFilt.out.txt
#$ -e /u/project/rwayne/snigenda/finwhale/reports/NeutralSites_HetFilt.err.txt
#$ -t 1-96
#$ -m abe

# This script filters sites above certain threshold of heterozygosity per population, usually above 75% heterozygosity. It calls the script Filtering_perPopulation.noCall.maxHetFilter.py to perform the filtering (Author Annabel Beichman)
# Author: Sergio Nigenda
# Usage: qsub Filter_Heterozygosity_per_pop.sh population (The value for population could be "GOC", "ENP")
# Example: qsub Filter_Heterozygosity_per_pop.sh GOC

source /u/project/rwayne/software/finwhale/miniconda2/etc/profile.d/conda.sh
conda activate gentools

set -o pipefail

# QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub


########## Setting variables, directories and files

pop=${1}

homedir=/u/project/rwayne/snigenda/finwhale
workdir=${homedir}/Neutral_regions/neutralVCFs/${pop}
scriptdir=${homedir}/scripts/get_neutral_regions
IDX=$(printf %02d ${SGE_TASK_ID})
hetfilt_script=${scriptdir}/filtering_perPopulation.noCall.maxHetFilter.py


mkdir -p ${workdir}/hetFiltvcfs
mkdir -p ${workdir}/hetFiltvcfs/errorfiles


python ${hetfilt_script} --vcf ${workdir}/Neutral_sites_SFS_${pop}_${IDX}.vcf.gz --outfile ${workdir}/hetFiltvcfs/Neutral_sites_FiltHet_SFS_${pop}_${IDX}.vcf --errorfile ${workdir}/hetFiltvcfs/errorfiles/Neutral_sites_SFS_errorfileHet_${pop}_${IDX}.txt --maxNoCallFrac 1.0 --maxHetFilter 0.75

bgzip ${workdir}/hetFiltvcfs/Neutral_sites_FiltHet_SFS_${pop}_${IDX}.vcf

tabix -p vcf ${workdir}/hetFiltvcfs/Neutral_sites_FiltHet_SFS_${pop}_${IDX}.vcf.gz

gzip ${workdir}/hetFiltvcfs/errorfiles/Neutral_sites_SFS_errorfileHet_${pop}_${IDX}.txt

