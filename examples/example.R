#source("~/Dropbox/PAPERS/R-devel/methylKit/R/backbone.R")
#source("~/Dropbox/PAPERS/R-devel/methylKit/R/diffMeth.R")
#source("~/Dropbox/PAPERS/R-devel/methylKit/R/annotate.R")

# R CMD BUILD --no-resave-data --keep-empty-dirs --install-args=install-tests methylKit
# R CMD INSTALL --install-tests --example methylKit_0.1.tar.gz

#file.list=list("~/Dropbox/PAPERS/R-devel/methylKit/data/test1.myCpG.txt",
#                "~/Dropbox/PAPERS/R-devel/methylKit/data/test2.myCpG.txt",
#                "~/Dropbox/PAPERS/R-devel/methylKit/data/control1.myCpG.txt",
#                "~/Dropbox/PAPERS/R-devel/methylKit/data/control2.myCpG.txt")

library(methylKit)


file.list=list( system.file("extdata", "test1.myCpG.txt", package = "methylKit"),
                system.file("extdata", "test2.myCpG.txt", package = "methylKit"),
                system.file("extdata", "control1.myCpG.txt", package = "methylKit"),
                system.file("extdata", "control2.myCpG.txt", package = "methylKit") )

myobj=read( file.list,
           sample.id=list("test1","test2","ctrl1","ctrl2"),assembly="hg18",pipeline="amp",treatment=c(1,1,0,0))

# get methylation statistics on second file "test2" in myobj which is a class of methylRawList
getMethylationStats(myobj[[2]],plot=F,both.strands=F)

# plot methylation statistics on second file "test2" in myobj which is a class of methylRawList
getMethylationStats(myobj[[2]],plot=T,both.strands=F)

# see what the data looks like for sample 2 in myobj methylRawList
head(myobj[[2]])

# merge all samples to one table by using base-pair locations that are covered in all samples
# setting destrand=T, will merge reads on both strans of a CpG dinucleotide. This provides better 
# coverage, but only advised when looking at CpG methylation
meth=unite(myobj,destrand=T)

# merge all samples to one table by using base-pair locations that are covered in all samples
# 
meth=unite(myobj)

# cluster all samples using correlation distance and return a tree object for plclust
hc = clusterSamples(meth, dist="correlation", method="ward", plot=FALSE)

# cluster all samples using correlation distance and plot hiarachical clustering
clusterSamples(meth, dist="correlation", method="ward", plot=TRUE)

# screeplot of principal component analysis.
PCASamples(meth, screeplot=TRUE)

# principal component anlaysis of all samples.
PCASamples(meth)

# calculate differential methylation
myDiff=calculateDiffMeth(meth)

# check how data part of methylDiff object looks like
head( myDiff )


# read-in transcript locations to be used in annotation
gene.obj=read.transcript.features(system.file("tests", "refseq.hg18.bed.txt", package = "methylKit"))

# annotate differentially methylated Cs with promoter/exon/intron using annotation data
annotate.WithGenicParts(myDiff,gene.obj)

#---------------


library(fastseg)
library(mclust)

system("curl -L -o H1.chr21.chr22.rds https://www.dropbox.com/s/zd7dxn6ykoe55uy/H1.chr21.chr22.rds?dl=1")
mbw=readRDS("/home/bobby/Downloads/mdiff.chao.mutVSwt.rds")

methSeg(methylDiff.obj, diagnostic.plot=TRUE)
segments = methSeg(mbw,diagnostic.plot=TRUE)
methSeg(methylDiff.obj,diagnostic.plot=TRUE,maxInt=100,minSeg=10)
methSeg(mbw[1:5000],diagnostic.plot=TRUE,maxInt=100,minSeg=10, G = 1:4)
segments = methSeg(mbw[1:1145],diagnostic.plot=TRUE)

methSeg(mbr, diagnostic.plot=TRUE)

mbr =readRDS("/home/bobby/Downloads/H1.chr21.chr22.rds")

methSeg2bed(segments, trackLine="track name='meth segments' description='meth segments' itemRgb=On", filename="/home/bobby/Downloads/H1.chr21.chr22.triallen.seg.bed")
