######## can run in the shell (is very fast) ########
# after a lot of testing of treemix paramters (see sandbox scripts)
# I have found that the paramters that yield the most sensical tree are:
# -k 500 (or any amount of ld pruning); -global (from Gauntiz paper); use sample size correction (don't disable with -noss); 


#### Also want to use files that have excluded 3 close relatives from the data set to not skew allele frequencies 
#### Also want to do with and without baja 
source /u/local/Modules/default/init/modules.sh
module load treemix
### using snp7 because it contains admixed individuals
### and I want those migration edges to show up
### it does also contain relatives which isn't amazing but shouldn't make a huge difference 
### can also do with snp9a and see the difference

header=LS_joint_allchr_Annot_Mask_Filter_passingSNPs.NoInvar.vcf
cd /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/20200517_filtered/treemixFormat

######### With BAJA (no relatives) #############
k=500
marker="allRails"
infile=${header}.${marker}.frq.strat.treemixFormat.gz
root='StCruz' # root is both
for m in {0..10}
do
outdir="root.${root}.mig.${m}.k.${k}.global.${marker}.treemix"
mkdir -p $outdir
treemix -i $infile -m ${m} -root ${root} -k ${k} -global -o $outdir/$outdir
done
