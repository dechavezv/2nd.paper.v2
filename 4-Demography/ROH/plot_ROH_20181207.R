# Make plot of autosomal het. versus ROH length sums
# Make plot of short, medium, long ROH numbers

args=commandArgs(TRUE)

# Genotype count data

gtfiles=list.files(path="/u/flashscratch/j/jarobins/HetPerInd", pattern="PerInd.txt")
gtfiles=paste("/u/flashscratch/j/jarobins/HetPerInd/", gtfiles[1:38], sep="")
gts=data.frame(read.table(gtfiles[1], header=T, sep='\t'))
for (i in 2:length(gtfiles)){
	gts=gts+data.frame(read.table(gtfiles[i], header=T, sep='\t'))
}

nn=dim(gts)[2]/5
samplename=sub("nocalls_", "", names(gts)[1:nn])
nocalls=as.numeric(gts[,(0*nn+1):(0*nn+nn)])
calls=as.numeric(gts[,(1*nn+1):(1*nn+nn)])
homRs=as.numeric(gts[,(2*nn+1):(2*nn+nn)])
homAs=as.numeric(gts[,(3*nn+1):(3*nn+nn)])
hets=as.numeric(gts[,(4*nn+1):(4*nn+nn)])
autohet=hets/calls


#####

# ROH data

rohdata=read.table("IRNP_44_joint_chrALL_polymorphic_SNPs_PASS_plink.hom", header=T)

shorts=rohdata[rohdata$POS2-rohdata$POS1>=100000 & rohdata$POS2-rohdata$POS1<1000000,]
meds=rohdata[rohdata$POS2-rohdata$POS1>=1000000 & rohdata$POS2-rohdata$POS1<10000000,]
longs=rohdata[rohdata$POS2-rohdata$POS1>=10000000,]


shortsums=NULL
shortnums=NULL
for (i in 1:length(samplename)){
	rohs=shorts[shorts$IID==samplename[i],]
	shortsums[i]=sum(rohs$POS2-rohs$POS1)	
	shortnums[i]=dim(rohs)[1]
}

medsums=NULL
mednums=NULL
for (i in 1:length(samplename)){
	rohs=meds[meds$IID==samplename[i],]
	medsums[i]=sum(rohs$POS2-rohs$POS1)	
	mednums[i]=dim(rohs)[1]
}

longsums=NULL
longnums=NULL
for (i in 1:length(samplename)){
	rohs=longs[longs$IID==samplename[i],]
	longsums[i]=sum(rohs$POS2-rohs$POS1)	
	longnums[i]=dim(rohs)[1]
}


#####

# Make data table

samps=c("ALG1","ARC1","ARC2","ARC3","ARC4","CL025","CL055","CL061","CL062","CL065","CL067","CL075","CL141","CL152","CL175","CL189","CLA1","ETH2","IRA1","ITL2","MEX1","PTG1","RED1","RKW119","RKW2455","RKW2515","RKW2518","RKW2523","RKW2524","SPN1","TIB1","XJG1","YNP1","YNP2","YNP3")

mylabels=c(
"Quebec",
"Arctic, Vic. Isl.","Arctic, Baf. Isl.","Arctic, Ell. Isl.","Arctic, NU",
"Isl. Roy. F25","Isl. Roy. F55","Isl. Roy. M61","Isl. Roy. M62","Isl. Roy. F65","Isl. Roy. F67","Isl. Roy. F75","Isl. Roy. M141","Isl. Roy. M152","Isl. Roy. M175","Isl. Roy. F189","Coyote",
"Ethiopia","Iran","Italy","Mexico","Portugal","Red Wolf",
"Minnesota","Minnesota","Minnesota","Minnesota","Minnesota","Minnesota",
"Spain","Tibet","Xinjiang",
"Yellowstone","Yellowstone","Yellowstone")

IRNPnames=c("CL025", "CL055", "CL061", "CL062", "CL065", "CL067", "CL075", "CL141", "CL152", "CL175", "CL189")
MNnames=c("RKW119", "RKW2455", "RKW2515", "RKW2518", "RKW2523", "RKW2524")
othernames=c("ALG1", "ARC1", "ARC2", "ARC4", "IRA1", "ITL2", "PTG1", "SPN1", "XJG1", "YNP1", "YNP2", "YNP3","CLA1","RED1")

myfonts=rep(3, length(samps))
myfonts[which(samps %in% c(IRNPnames, MNnames))]=2

mygroups=rep(1, length(samps))
mygroups[which(samps %in% "TIB1")]=2
mygroups[which(samps %in% "ETH2")]=3
mygroups[which(samps %in% "ARC3")]=4
mygroups[which(samps %in% "MEX1")]=5
mygroups[which(samps %in% MNnames)]=6
mygroups[which(samps %in% IRNPnames)]=7

mydf=data.frame(samplename, nocalls, calls, homRs, homAs, hets, autohet, shortnums, mednums, longnums, shortsums, medsums, longsums)

mydf2=data.frame(mydf[which(mydf$samplename %in% samps),], mylabels, myfonts, mygroups)
mydf2=mydf2[order(mydf2$autohet, decreasing=F),]


#####

# Plot autosomal het and ROH length sums

pdf(paste("ROH_v_AutosomalHet_20181207_", args[1], ".pdf", sep=""), width=3.28, height=4.92, pointsize=8)

par(mfrow=c(1,2))
par(mar=c(4,1,1,4.5))
b1=barplot(-mydf2$autohet, horiz=T, names.arg=F, axes=F, xlim=c(-.002, 0), col="#4393c3", space=0)
axis(side=1, at=seq(0,-.002, by=-.0005), las=1, labels=seq(0,2, by=.5), line=-.5)
title(1, xlab="Heterozygosity (per kb)", line=2)

par(xpd=T)
par(mar=c(4,2.5,1,1))
b2=barplot(rbind(mydf2$shortsums/1e6, mydf2$medsums/1e6, mydf2$longsums/1e6), space=0,
las=2, horiz=T, axes=F, xlim=c(0,2000), col=rev(c("#b2182b","#ef8a62","#fddbc7")))
title(1, xlab="ROH Length Sum (Gb)", line=2)
legend(500, 36.125, legend=c("[0.1, 1) Mb","[1, 10) Mb","[10, 100) Mb"), fill=rev(c("#b2182b","#ef8a62","#fddbc7")), bty="n")
axis(side=1, at=seq(0,2000, by=500), labels=seq(0,2, by=.5), las=1, line=-.5)
mtext(text = mydf2$mylabels, side = 2, at = b2, line = 3.5, las=1, adj=.5, font=mydf2$myfonts)
par(xpd=F)

dev.off()


#####

# Plot numbers of ROH

# bg cols
myred="#ef8a62"
myblue="#67a9cf"
mygrey="#bababa"
bgcols=c(mygrey,mygrey,mygrey,mygrey,mygrey,myblue,myred)

# cols
myred2="#67001f"
myblue2="#053061"
mygrey2="#1a1a1a"
linecols=c(mygrey2,mygrey2,mygrey2,mygrey2,mygrey2,myblue2,myred2)


pdf(paste("ROH_nums_20181207_", args[1], ".pdf", sep=""), width=6.83, height=2.75, pointsize=12)
par(mfrow=c(1,3))
par(mar=c(7,4,3,.1))

ymax=1.2*max(mydf2$shortnums)
plot(mydf2$mygroups,mydf2$shortnums, bty="n", ylim=c(0,ymax), axes=F, ylab="Total Number of ROH", main="Short ROH\n[100kb, 1Mb)", xlab="", cex=1.5, pch=21, col=linecols[mydf2$mygroups], bg=bgcols[mydf2$mygroups], font.main=1, cex.main=1, xlim=c(1,8))
axis(side=2, line=.5)
axis(side=1, labels=c("Reference","Tibet","Ethiopia","Ellesmere Isl.","Mexico","Minnesota","Isle Royale"), at=seq(1,7), las=2)

ymax=1.2*max(mydf2$mednums)
plot(mydf2$mygroups,mydf2$mednums, bty="n", ylim=c(0,ymax), axes=F, ylab="", main="Medium ROH\n[1Mb, 10Mb)", xlab="", cex=1.5, pch=21, col=linecols[mydf2$mygroups], bg=bgcols[mydf2$mygroups], font.main=1, cex.main=1, xlim=c(1,8))
axis(side=2, line=.5)
axis(side=1, labels=c("Reference","Tibet","Ethiopia","Ellesmere Isl.","Mexico","Minnesota","Isle Royale"), at=seq(1,7), las=2)

ymax=1.2*max(mydf2$longnums)
plot(mydf2$mygroups,mydf2$longnums, bty="n", ylim=c(0,ymax), axes=F, ylab="", main="Long ROH\n[10Mb,100Mb)", xlab="", cex=1.5, pch=21, col=linecols[mydf2$mygroups], bg=bgcols[mydf2$mygroups], font.main=1, cex.main=1, xlim=c(1,8))
axis(side=2, line=.5)
axis(side=1, labels=c("Reference","Tibet","Ethiopia","Ellesmere Isl.","Mexico","Minnesota","Isle Royale"), at=seq(1,7), las=2)

dev.off()

