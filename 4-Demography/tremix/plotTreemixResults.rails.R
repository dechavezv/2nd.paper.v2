####### Plot treemix output ##########
# source the treemix plotting funcs

source("/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/tremix/plotting_funcs.AB.r") 
genotypeDate="20200517"
pops="/u/scratch/d/dechavez/rails.project/SNPRelate20200729/treemixFormat/data/poporder.rails.txt" # for plotting residuals
data.dir="/u/scratch/d/dechavez/rails.project/SNPRelate20200729/treemixFormat/"
######################## First do models that include BAJA ######################
#models=c("ferretOutgroup.noMig.treemix") # can specify by hand or get from list files in the dir
markers=c("allRails")
for(marker in markers){
models=list.files(data.dir,pattern = marker)
# pop file for models incld BAJA:
print(models)
# loop through models and save plots
for(modelName in models){
  # go to wd of that model
  #print(modelName)
  setwd(paste(data.dir,modelName,sep=""))
  # tree plot:
  png(paste("plot.",modelName,".treePlot.png",sep=""),width=2400,height=2000,res=300)
  plot_tree(modelName)
  dev.off()
  # residuals: 
  png(paste("plot.",modelName,".residualsPlot.png",sep=""),width=4400,height=3000,res=300)
  plot_resid(modelName,pop_order = pops) #poporder is a text file with populations in the order you want them
  dev.off()  
}
}

warnings()
