# get input and output file names

plink2treemix <- function(inputfile, outputfile){
  library(data.table)
  library(R.utils) 
<<<<<<< HEAD
  
=======
>>>>>>> 435bfd93af73fb956d6cddf487b3bc58c9623637

  ifile <-fread(inputfile)
  ifile <- read.table(gzfile(inputfile), header = T)
  
  pops <- unique(ifile$CLST)
  snps <- unique(ifile$SNP)
  
  res <- matrix(NA, NROW(snps), NROW(pops))
  colnames(res) <- pops
  rownames(res) <- snps
  
  res <- as.data.frame(res)
  
  for(p in pops){
    
    temp <- ifile[ifile$CLST == p,]
    
    for(s in snps){
      
      A <- temp$MAC[temp$SNP == s]
      B <- temp$NCHROBS[temp$SNP == s]
      res[s,p] <- paste(A,B-A, sep = ",")
      
    }
  }
  
  fwrite(res, outputfile, quote = F, sep = " ")
  gzip(ofile.name, destname = paste0(outputfile, ".gz"))
}

#
# pop2rs = dict()
# rss = list()
# rss2 = set()

# read input file -----------

# line = infile.readline()
# line = infile.readline()

# while line:
#   line = line.strip().split()
# rs = line[1]            # SNP
# pop = line[2]           # POP
# mc = line[6]            # MAC
# total = line[7]         # nobs
# if rs not in rss2: 
#   rss.append(rs)
# rss2.add(rs)
# #if pop2rs.has_key(pop)==0:
# if pop not in pop2rs:
#   pop2rs[pop] =  dict()
# #if pop2rs[pop].has_key(rs)==0:
# if rs not in pop2rs[pop]:
#   pop2rs[pop][rs] = b" ".join([mc, total])
# line = infile.readline()
# 
# pops = list(pop2rs.keys())
# for pop in pops:
#   print(pop, end=' ', file=outfile)
# print("", file=outfile)
# 
# for rs in rss:
#   for pop in pops:
#   tmp = pop2rs[pop][rs].split()
# c1 = int(tmp[0])
# c2 = int(tmp[1])
# c3 = c2-c1
# print(",".join([str(c1), str(c3)]), end=' ', file=outfile)
# print("", file=outfile)

