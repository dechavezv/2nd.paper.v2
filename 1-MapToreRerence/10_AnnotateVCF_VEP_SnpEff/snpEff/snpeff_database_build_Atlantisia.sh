#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/10_AnnotateVCF_VEP_SnpEff/snpEff
#$ -l h_rt=48:00:00,h_data=10G,h_vmem=50G,highp
#$ -N snpEff.rails
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/10_AnnotateVCF_VEP_SnpEff/snpEff/log/
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/10_AnnotateVCF_VEP_SnpEff/snpEff/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

# Modiefied from Meixi script 
# Usage: snpEff database building only for Atlantisia genome 
# Acording to Meixi Gff3 may be problemaatic. You may want to convert ot gtf.

REF="Atlantisia"
Database=Atro.0055
Snpeffdir=/u/home/d/dechavez/project-rwayne/snpEff
# Snpeffdir=/u/home/m/meixilin/snpEff/snpEff
HOMEDIR=/u/home/d/dechavez/project-rwayne
ATLDIR=${HOMEDIR}/rails.project/reference.genomes/InaccesibleRail/chr_and_superScafolds

# chooses the reference genome and gtf file to construct the SnpEff database
REFERENCE=${ATLDIR}/InaccesibleRail.chr.fa
GTF=${ATLDIR}/Chr.OUT-0055.homolog.gff

# the config files already modified manually 
# vi snpEff.config 
# append to file 
# % Atro.0055.genome : Atlantisia_rogersi
# % 	# Atro.0055.reference : /u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/OUT-0055.homolog.gff.gz

# goes to the data directory within the SnpEff directory and puts the necessary files to create the SnpEff database in place with the appropriate names
mkdir -p ${Snpeffdir}/data/${Database}
mkdir -p ${Snpeffdir}/data/genomes
cd ${Snpeffdir}/data/${Database}

cp ${GTF} genes.gff

cd ${Snpeffdir}/data/genomes
cp ${REFERENCE} ${Database}.fa

# NOW STARTS BUILDING ########
# Use auto detection for file format 
cd ${Snpeffdir}
java -Xmx10g -jar snpEff.jar build -gff3 -debug ${Database} &> ${Database}.build.log
##############################
