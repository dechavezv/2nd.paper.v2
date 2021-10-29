#!/usr/bin/env Rscript
red='#d53e4f'
orange='#1d91c0'
blue='#41b6c4'
colormap = c(red,orange,blue)
topologies<-c("t1","t2","t3")
color.top<-data.frame(topologies,colormap)

library(reshape2)
library(ggplot2)
library(tidyverse)
library(ggeasy)
dirPath = '.'
filePath = paste(dirPath,'/freqQuad.csv',sep='')
md<-read.csv(filePath,header=F,sep='\t')
df<-data.frame(md,colormap)

nodes<-unique(df$V1)

#for (i in 0:length(nodes)){
#  n[i-1]<-md9[which(md$nodes ==)]
}
n16<-md[which(md$V1 == "N16"),]
n17<-md[which(md$V1 == "N17"),]
n18<-md[which(md$V1 == "N18"),]
n19<-md[which(md$V1 == "N19"),]
n20<-md[which(md$V1 == "N20"),]
n21<-md[which(md$V1 == "N21"),]
n22<-md[which(md$V1 == "N22"),]
n23<-md[which(md$V1 == "N23"),]

par(mfrow=c(2,4))
#plot0<-ggplot(data=n0)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n0") + ggeasy::easy_center_title()
#plot1<-ggplot(data=n1)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n1") + ggeasy::easy_center_title()
#plot2<-ggplot(data=n2)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n2") + ggeasy::easy_center_title()
#plot3<-ggplot(data=n3)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n3") + ggeasy::easy_center_title()
#plot4<-ggplot(data=n4)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n4") + ggeasy::easy_center_title()
#plot5<-ggplot(data=n5)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n5") + ggeasy::easy_center_title()
#plot6<-ggplot(data=n6)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n6") + ggeasy::easy_center_title()
#plot7<-ggplot(data=n7)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n7") + ggeasy::easy_center_title()
#plot8<-ggplot(data=n8)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n8") + ggeasy::easy_center_title()
#plot9<-ggplot(data=n9)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n9") + ggeasy::easy_center_title()
#plot10<-ggplot(data=n10)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n10") + ggeasy::easy_center_title()
#plot11<-ggplot(data=n11)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n11") + ggeasy::easy_center_title()
#plot12<-ggplot(data=n12)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n12") + ggeasy::easy_center_title()
#plot13<-ggplot(data=n13)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n13") + ggeasy::easy_center_title()
#plot14<-ggplot(data=n14)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n14") + ggeasy::easy_center_title()
#plot15<-ggplot(data=n15)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n15") + ggeasy::easy_center_title()
plot16<-ggplot(data=n16)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("N16") + theme(axis.title.x = element_blank()) + ggeasy::easy_center_title()
plot17<-ggplot(data=n17)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("N17") + theme(axis.title.x = element_blank()) + ggeasy::easy_center_title()
plot18<-ggplot(data=n18)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("N18") + theme(axis.title.x = element_blank()) + ggeasy::easy_center_title()
plot19<-ggplot(data=n19)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("N19") + theme(axis.title.x = element_blank()) + ggeasy::easy_center_title()
plot20<-ggplot(data=n20)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("N20") + theme(axis.title.x = element_blank()) + ggeasy::easy_center_title()
plot21<-ggplot(data=n21)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("N21") + theme(axis.title.x = element_blank()) + ggeasy::easy_center_title()
plot22<-ggplot(data=n22)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("N22") + theme(axis.title.x = element_blank()) + ggeasy::easy_center_title()
plot23<-ggplot(data=n23)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("N23") + theme(axis.title.x = element_blank()) + ggeasy::easy_center_title()
#plot24<-ggplot(data=n24)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n24") + ggeasy::easy_center_title()
#plot25<-ggplot(data=n25)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n25") + ggeasy::easy_center_title()
#plot26<-ggplot(data=n26)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n26") + ggeasy::easy_center_title()
#plot27<-ggplot(data=n27)+aes(x=topologies,y=V4,fill=colormap)+geom_bar(stat='identity',color=1,width=0.8,position='dodge') + scale_y_continuous(limits = c(0,1)) + theme(legend.position = "none") + theme(axis.title.y = element_blank()) + ggtitle("n27") + ggeasy::easy_center_title()
plots<-ggarrange(plot16,plot17,plot18,plot19,plot20,plot21,plot22,plot23,ncol=4,nrow=2)
ggsave('SACanid_quad.pdf',plot=plots, device = 'pdf')
#+theme_bw()+theme(axis.text.x=element_text(angle=90))+scale_fill_manual(values=colormap,name='Topology')+geom_hline(yintercept=1/3,size=0.4,linetype=2)+ylab('relative freq.')+facet_wrap(~value,scales='free_x')+xlab('')
#pdf(paste("quadFreq.pdf", sep = ""), width=9, height=9)
#dev.off()

