##### Faststructure outputs SVG plots 
# download them and copy to : /Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/plots/FASTSTRUCTURE
calldate=20200517 # date genotypes were called
wd="/u/home/d/dechavez/project-rwayne/rails.project/FASTSTRUCTURE/20200729/plots"
outdir="/u/home/d/dechavez/project-rwayne/rails.project/FASTSTRUCTURE/20200729/plots"
dir.create(outdir)
#install.packages("rsvg")
#install.packages("svglite")
require(rsvg)
#require(svglite)
# convert to PDF
for (i in seq(1,10)){
  print(i)
  svg1File <- paste(wd,"LS_joint_allchr_Annot_Mask_Filter_passingSNPs.NoInvar.vcf.faststructure_plot.",i,".svg",sep="")
  rsvg_pdf(svg1File, paste(outdir,"LS_joint_allchr_Annot_Mask_Filter_passingSNPs.NoInvar.vcf.faststructure_plot.",i,".pdf",sep=""))
}
