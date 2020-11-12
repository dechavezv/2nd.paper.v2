################ TREEMIX ############# 
# this should be run *after* you've converted your vcf to plink format
###### Involves some manual steps!!!!!!! ############ 

## It will make 3 versions of treemix input: 
source /u/local/Modules/default/init/modules.sh
module load treemix
module load plink/1.07

# converter script:
# wget https://bitbucket.org/nygcresearch/treemix/downloads/plink2treemix.py
# from treemix 3/12/12:
# Added a small script to convert stratified allele frequencies output from plink into TreeMix format. 
# This will be incorporated into the next release, but for the moment must be downloaded 
# separately. To run this, let's say you have data in plink format (e.g., data.bed, data.bim, 
# data.fam) and a plink cluster file matching each individual to a population (data.clust).
# data was formatted for PLINK to run faststructure (see those scripts)
## change third column of .fam to be the pop identifier, as save as population.clusters
# only want first three columns
#awk '{OFS="\t"; print $1,$2,$3}' population.clusters.temp > population.clusters
############## get plink format files from fastStructure_Step_1_vcf2plinkBed.20181119.sh in the FASTSTRUCTURE analysis section ##########

scriptdir=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/tremix
genotypeDate=20200517
vcfdir=/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/${genotypeDate}_filtered
plinkFileDir=$vcfdir/plinkFormat
treeFileDir=$vcfdir/treemixFormat
mkdir -p $treeFileDir

#### DO FOR BOTH HEADERS (separate scripts) ##########

header=LS_joint_allchr_Annot_Mask_Filter_passingSNPs.NoInvar.vcf

# must add a snp name to my .bim file:
# make a backup
/bin/cp $plinkFileDir/$header.bim $plinkFileDir/${header}.original.bim
awk '{$2 = $1":"$4; print}' $plinkFileDir/${header}.original.bim >  $plinkFileDir/$header.bim
### awk '{print $1,$2}' $plinkFileDir/$header.fam > $plinkFileDir/$header.samples
### /bin/cp $plinkFileDir/$header.samples $plinkFileDir/$header.population.clusters 
### clusters=$plinkFileDir/$header.population.clusters # 3 columns: 0 sampleID popID
# make a back up once you've added populations
### /bin/cp $clusters $clusters.backup


##################################### With separate CA/BAJA and removing 3 relatives   ##############################
############# Excluding 3 Relatives: can use plink --filter ######################

# make a filter file:
# plink --file data --filter myfile.raw 1 --freq

#implies a file myfile.raw exists which has a similar format to phenotype and cluster files: that is, the first two columns are family and individual IDs; the third column is expected to be a numeric value (although the file can have more than 3 columns), and only individuals who have a value of 1 for this would be included in any subsequent analysis or file generation procedure. e.g. if myfile.raw were 
# copy cols 1, 2 and then a "1"

awk '{print $1,$2,1}' $plinkFileDir/$header.fam > $plinkFileDir/$header.exclList.allIndsIncluded
echo " YOU MUST MANUALLY EXCLUDE THE RELATIVES HERE" #### 
# excluding relatives from my excel sheet:
# 104_Elut_KUR_7 (keep 79_Elut_KUR_17)
# 77_Elut_KUR_14 (keep 81_Elut_KUR_2)
# 106_Elut_AL_AD_GE91109 (keep 118_Elut_AL_AD_GE91101)

###### MANUALLY edit and rename as : $plinkFileDir/$header.exclList.rmRelatives
# manually edit the file to set individuals you want to exclude to "0"
clusters=$plinkFileDir/$header.population.clusters.all.rails # 3 columns: 0 sampleID popID
marker="allRails"
plink --bfile $plinkFileDir/$header \
--freq \
--missing \
--within $clusters \
--noweb \
--chr 1-36 \
--out $plinkFileDir/$header.${marker} \
--nonfounders \
--keep-allele-order \
--filter $plinkFileDir/$header.exclList.allIndsIncluded 1
## --chr-set 36 no-x no-y no-xy no-mt \
### --allow-extra-chr \

gzip -f $plinkFileDir/${header}.${marker}.frq.strat

python $scriptdir/plink2treemix.py $plinkFileDir/${header}.${marker}.frq.strat.gz $treeFileDir/${header}.${marker}.frq.strat.treemixFormat.gz
