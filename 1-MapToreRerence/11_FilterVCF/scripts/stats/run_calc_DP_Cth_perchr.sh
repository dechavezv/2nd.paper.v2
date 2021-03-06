#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Cth/VCF/Stats
#$ -l h_rt=22:00:00,h_data=2G,h_vmem=30G
#$ -N meanDP
#$ -o /u/home/d/dechavez/project-rwayne/Cth/VCF/Stats/log/
#$ -e /u/home/d/dechavez/project-rwayne/Cth/VCF/Stats/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

# highmem,highp

source /u/local/Modules/default/init/modules.sh
module load R

cd /u/home/d/dechavez/project-rwayne/Cth/VCF/Stats

export INFILE=bCth_chr$(printf %02d $SGE_TASK_ID).vcf.gz_DP.table
export OUTFILE=bCth_chr$(printf %02d $SGE_TASK_ID).vcf.gz_DP.table_mean.txt
export SpsList=bCth.sp.txt

#this script will calcualte the meand from a multipleIndiv. VCF file \
#IMORTANT: names from sp.list must match header of depth.table. For instance, \
#`Cb17082018` in sp.list and `Cb17082018.DP` in header of depth.table.


#Use awk, R is to slow!!!
for line in $(cat ${SpsList}); do \
(echo $line && cat ${INFILE} | \
grep -v 'NA' | \
awk -F "\t" 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i } } \
{ sum+=$(f["'${line}.DP'"]) } END { print sum/NR }' );done >  ${OUTFILE}

#After this script is complete, cd to the ouput directory and run \
#the following line that will give you the mean DP of all chr:

# touch mean.DP.allchr.txt
#for line in $(cat ${SpsList}); do (echo $line && grep -A1 $line *.gz_DP_mean.txt | grep -E '[0-9].[0-9]' | perl -pe 's/.*NA.*txt-(\d+.\d+)/\1/g' | grep -v 'NA_' | awk '{ sum += $1; n++ } END { if (n > 0) print "meanDP.'${line}'" ":"(sum / n) "," "minDP.'${line}'" ":"(sum / n)/3 "," "max.DP.'${line}'" ":" (sum / n)*2 }');done | grep 'mean' | perl -pe 's/meanDP\.(.*)(\:\d+\.\d+),minDP\..*\:\d+\.\d+,max.DP\..*\:\d+\.\d+/'\''\1'\''\2/g' | perl -pe 's/\n/,/g'


# The following works but takes hours. This is why I dont like R !!!
### for line in $(cat ${SpsList}); do \
### (echo $line && cat ${INFILE} | \
### grep -v 'NA' | \
### Rscript -e 'dat<-as.data.frame(read.table(file("stdin"), header=T, sep="")); newdat <-subset(dat,select='$line'.DP); mean(newdat$'$line'.DP)');done > ${OUTFILE}

#After this script is complete, cd to the ouput directory and run \
#the following line that will give you the mean DP of all chr:

#for line in $(cat ${SpsList}); do grep -A1 $line *.gz_DP_mean.txt | grep '\[' | perl -pe 's/.*(\s+\d+\.\d+)/\1/g' | awk '{ sum += $1; n++ } END { if (n > 0) print sum / n; }';done
