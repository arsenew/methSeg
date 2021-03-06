\docType{methods}
\name{adjust.methylC}
\alias{adjust.methylC}
\alias{adjust.methylC,methylRaw,methylRaw-method}
\alias{adjust.methylC,methylRawList,methylRawList-method}
\title{Adjust measured 5mC levels using 5hmC levels}
\usage{
  adjust.methylC(mc,hmc)
}
\arguments{
  \item{mc}{a \code{methylRawList} or \code{methylRaw}
  containing 5mC levels of a sample or set of samples}

  \item{hmc}{a \code{methylRawList} or \code{methylRaw}
  containing 5hmC levels of a sample or set of samples.  If
  a \code{methylRawList} given the sample order should be
  same as "mc" \code{methylRawList} object.}
}
\value{
  returns adjusted 5-methyl cytosine levels in the form of
  \code{methylRawList} or \code{methylRaw} object depending
  on the input object
}
\description{
  Measured 5mC levels via bisulfite sequencing might be a
  combination of 5hmC and 5mC levels since bisulfite
  sequencing can not distinguish between the two. This
  function can adjust 5mC levels of a bisulfite sequencing
  experiment if the user supplies corresponding 5hmC levels
  from the same sample.
}
\examples{
# read 5hmC and 5mC files
hmc.file=system.file("extdata", "test1.myCpG.txt", package = "methylKit")
mc.file =system.file("extdata", "test2.myCpG.txt", package = "methylKit")

my5hmC=read( hmc.file,sample.id="hmc",assembly="hg18")
my5mC =read( mc.file,sample.id="mc",assembly="hg18")

# adjusting the 5mC levels using 5hmC levels
adjusted.5mC=adjust.methylC(my5mC,my5hmC)
}
\references{
  1. Booth, Branco, et al. (2012). Quantitative Sequencing
  of 5-Methylcytosine and 5-Hydroxymethylcytosine at
  Single-Base Resolution. Science, 934

  2. Yu, Hon, et al. (2012). Base-resolution analysis of
  5-hydroxymethylcytosine in the Mammalian genome. Cell,
  149(6), 1368-80.
}

