# USAGE: R CMD BATCH /u/home/j/jarobins/project-rwayne/utils/scripts/roh_genomic_F/filter_LROH_make_bed_030917.R

setwd('/u/home/j/jarobins/project-rwayne/irnp/ROH')

library(plyr)

list=list.files(pattern='gz.LROH')
rohData=ldply(list, read.table, header=T, sep='\t')

males=c("ALG1","CL039","CL061","CL062","CL141","CL149","CL152","CL175","CLA1","ETH1","ITL1","ITL2","RED1","RKW2455","RKW2515","RKW2523","TIB1","XJG1","YNP2","YNP3")
females=c("CL025","CL055","CL065","CL067","CL075","CL189","CRO1","IRA1","MEX1","PTG1","RKW119","RKW2518","RKW2524","SPN1","YNP1")

rohData=rohData[!(rohData$CHROM=="chrX" & rohData$INDV %in% males),]
rohData=rohData[(rohData$AUTO_END-rohData$AUTO_START)>=100000,]

lim=quantile((rohData$AUTO_END-rohData$AUTO_START)/rohData$N_VARIANTS_BETWEEN_MAX_BOUNDARIES, c(.025,.975))

rohData=rohData[(rohData$AUTO_END-rohData$AUTO_START)/rohData$N_VARIANTS_BETWEEN_MAX_BOUNDARIES>=lim[1] & (rohData$AUTO_END-rohData$AUTO_START)/rohData$N_VARIANTS_BETWEEN_MAX_BOUNDARIES<=lim[2],]

for (ind in unique(rohData$INDV)){
	data=rohData[rohData$INDV==ind,]
	chrom=data$CHROM
	start=data$AUTO_START-1
	end=data$AUTO_END
	write.table(cbind.data.frame(chrom,start,end,"1"), file=paste('LROH_filtered_',ind,'.bed', sep=''), col.names=F, row.names=F, quote=F, sep='\t')
}
