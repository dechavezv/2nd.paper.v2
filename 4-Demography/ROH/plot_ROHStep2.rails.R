# Make plot of autosomal het. versus ROH length sums
# Make plot of short, medium, long ROH numbers

args=commandArgs(TRUE)

# Genotype count data
gtfiles=list.files(path="/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/Chr_Joint/2021.31Genomes/", pattern="PerInd.txt")
gtfiles=paste("/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/Chr_Joint/2021.31Genomes/", gtfiles[1:35], sep="")
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

rohdata=read.table("rails.catted.hom", header=T)

shorts=rohdata[rohdata$POS2-rohdata$POS1>=100000 & rohdata$POS2-rohdata$POS1<500000,]
meds=rohdata[rohdata$POS2-rohdata$POS1>=500000 & rohdata$POS2-rohdata$POS1<2000000,]
longs=rohdata[rohdata$POS2-rohdata$POS1>=2000000,]


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

samps=c("LS02","LS03","LS05","LS06","LS08","LS09","LS10","LS12","LS13","LS14","LS15",
	"LS21","LS22","LS25","LS26","LS27","LS28","LS29","LS31","LS32","LS33","LS34",
	"LS35","LS36","LS37","LS38","LS39","LS40","LS43","LS44","LS49","LS50","LS51",
	"LS52","LS55","LS56","LS57","LS58","LS60")

#Orde has to be the same as in hete.txt files
mylabels=c("LS02.St.Curz","LS03.St.Curz","LS05.St.Curz","LS06.St.Curz","LS08.St.Curz",
	"LS09.St.Curz","LS10.St.Curz","LS12.St.Curz","LS13.St.Curz","LS14.St.Curz","LS15.St.Curz",
	"LS21.Isabela","LS22.Isabela","LS25.Isabela","LS26.Isabela","LS27.Isabela","LS28.Isabela",
	"LS29.Isabela","LS31.Isabela","LS32.Pinta","LS33.Pinta","LS34.Pinta","LS35.Pinta","LS36.Pinta",
	"LS37.Pinta","LS38.Pinta","LS39.Pinta","LS40.Pinta","LS43.Santiago","LS44.Santiago","LS49.Santiago",
	"LS50.Santiago","LS51.Santiago","LS52.Santiago","LS55.Santiago","LS56.Santiago","LS57.Santiago",
	"LS58.Santiago","LS60.Santiago")

StCruz=c("LS02","LS03","LS05","LS06","LS08","LS09","LS10","LS12","LS13","LS14","LS15")
Isabela=c("LS21","LS22","LS25","LS26","LS27","LS28","LS29","LS31")
Pinta=c("LS32","LS33","LS34","LS35","LS36","LS37","LS38","LS39","LS40")
Santiago=c("LS43","LS44","LS49","LS50","LS51","LS52","LS55","LS56","LS57","LS58","LS60")

myfonts=rep(3, length(samps))
myfonts[which(samps %in% c(Pinta))]=2

mygroups=rep(1, length(samps))
mygroups[which(samps %in% StCruz)]=1
mygroups[which(samps %in% Isabela)]=2
mygroups[which(samps %in% Pinta)]=3
mygroups[which(samps %in% Santiago)]=4

mydf=data.frame(samplename, nocalls, calls, homRs, homAs, hets, autohet, shortnums, mednums, longnums, shortsums, medsums, longsums)

mydf2=data.frame(mydf[which(mydf$samplename %in% samps),], mylabels, myfonts, mygroups)
mydf2=mydf2[order(mydf2$autohet, decreasing=F),]


#####

# Plot autosomal het and ROH length sums

pdf(paste("ROH_v_AutosomalHet_20200530_", args[1], "rails.pdf", sep=""), width=5.2, height=4.92, pointsize=8)

par(mfrow=c(1,2))
par(mar=c(4,1,1,4.5))
b1=barplot(-mydf2$autohet, horiz=T, names.arg=F, axes=F, xlim=c(-.0015, 0), col="dimgray", space=0)
axis(side=1, at=seq(0,-.0015, by=-.00025), las=1, labels=seq(0,1.50, by=.25), line=-.25)
title(1, xlab="Heterozygosity (per kb)", line=2)

par(xpd=T)
par(mar=c(4,2.5,1,1))
b2=barplot(rbind(mydf2$shortsums/1e6, mydf2$medsums/1e6, mydf2$longsums/1e6), space=0,
las=2, horiz=T, axes=F, xlim=c(0,400), col=rev(c("darkgreen","darkseagreen","darkseagreen1")))
title(1, xlab="ROH Length Sum (Gb)", line=2)
legend(167, 8.4, legend=c("[0.1, 0.5) Mb","[0.5, 2) Mb","[2, 10) Mb"), fill=rev(c("darkgreen","darkseagreen","darkseagreen1")), bty="n")
axis(side=1, at=seq(0,400, by=50), labels=seq(0,0.4, by=.05), las=1, line=-.4)
mtext(text = mydf2$mylabels, side = 2, at = b2, line = 3.5, las=1, adj=.5, font=mydf2$myfonts)
par(xpd=F)

# mycolors "darkseagreen1","darkseagreen",darkgreen"
# original colors JAR "#b2182b","#ef8a62","#fddbc7"

dev.off()


#####

# Plot numbers of ROH

# bg cols
myred="green4"
myblue="firebrick4"
mygrey="#bababa"
bgcols=c(mygrey,mygrey,myred,mygrey)

#Original Colors JAR
#myred="#ef8a62"
#myblue="#67a9cf"
#mygrey="#bababa"

# cols
myred2="green4"
myblue2="firebrick4"
mygrey2="#bababa"
linecols=c(mygrey2,mygrey2,myred2,mygrey2)

#Original Colors JAR
#myred="#ef8a62"
#myblue="#67a9cf"
#mygrey="#bababa"

pdf(paste("ROH_nums_20200530_", args[1], "rails.pdf", sep=""), width=6.83, height=2.65, pointsize=12)
par(mfrow=c(1,3))
par(mar=c(7,4,3,.9))

mygroups=rep(1, length(samps))
mygroups[which(samps %in% StCruz)]=1
mygroups[which(samps %in% Isabela)]=2
mygroups[which(samps %in% Pinta)]=3
mygroups[which(samps %in% Santiago)]=4

ymax=1.2*max(mydf2$shortnums)
plot(mydf2$mygroups,mydf2$shortnums, bty="n", ylim=c(0,ymax), axes=F, ylab="Total Number of ROH", main="Short ROH\n[100kb, 0.5Mb)", xlab="", cex=1.5, pch=21, col=linecols[mydf2$mygroups], bg=bgcols[mydf2$mygroups], font.main=1, cex.main=1, xlim=c(1,4))
axis(side=2, line=.5)
axis(side=1, labels=c("StCruz", "Isabela", "Pinta", "Santiago"), at=seq(1,4), las=2)

ymax=1.2*max(mydf2$mednums)
plot(mydf2$mygroups,mydf2$mednums, bty="n", ylim=c(0,ymax), axes=F, ylab="", main="Medium ROH\n[0.5Mb, 2Mb)", xlab="", cex=1.5, pch=21, col=linecols[mydf2$mygroups], bg=bgcols[mydf2$mygroups], font.main=1, cex.main=1, xlim=c(1,4))
axis(side=2, line=.5)
axis(side=1, labels=c("StCruz", "Isabela", "Pinta", "Santiago"), at=seq(1,4), las=2)

ymax=1.2*max(mydf2$longnums)
plot(mydf2$mygroups,mydf2$longnums, bty="n", ylim=c(0,ymax), axes=F, ylab="", main="Long ROH\n[2Mb,10Mb)", xlab="", cex=1.5, pch=21, col=linecols[mydf2$mygroups], bg=bgcols[mydf2$mygroups], font.main=1, cex.main=1, xlim=c(1,4))
axis(side=2, line=.5)
axis(side=1, labels=c("StCruz", "Isabela", "Pinta", "Santiago"), at=seq(1,4), las=2)

dev.off()
