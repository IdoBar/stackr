# stackr

[![Travis-CI Build Status](https://travis-ci.org/thierrygosselin/stackr.svg?branch=master)](https://travis-ci.org/thierrygosselin/stackr) [![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.20563.svg)](http://dx.doi.org/10.5281/zenodo.20563)


The goal of **stackr** is to make GBS/RAD data produced by [STACKS] (http://creskolab.uoregon.edu/stacks/) easy to analyse in R.

This is the development page of the **stackr** package for the R software.

* Optimized for *de novo* and population genetics.
* Read and modify *batch_x.sumstats.tsv* and *batch_x.haplotypes.tsv* files.
* Transform the VCF file, *batch_x.vcf*, into a tidy format to visualise and filter summary statistics within R.
* Filters genetic markers based on: coverage (read depth, REF and ALT allele depth), genotype likelihood, the number of individuals, the number of populations, minor allele frequency (local and global), observed heterozygosity and inbreeding coefficient (Fis).
* View distribution of summary statistics and create publication-ready figures.
* Convert data into *genepop*, *genind* and *gtypes* object for easy integration with [adegenet] (https://github.com/thibautjombart/adegenet), [strataG] (https://github.com/EricArcher/strataG.devel/tree/master/strataG.devel), [hierfstat] (https://github.com/jgx65/hierfstat), [pegas] (https://github.com/emmanuelparadis/pegas) and [poppr] (https://github.com/grunwaldlab/poppr).
* Map-independent imputation of GBS markers using Random Forest is now integrated within the *haplo2genepop*, *haplo2genind* and *haplo2gtypes* functions. 
* \code{summary_haplotypes} function now output: putative paralogs,
consensus, monomorphic and polymorphic loci; the haplotypes statistics for the
observed and expected homozygosity and heterozygosity; Wright’s 
inbreeding coefficient (Fis), and a new proxy measure of the realized 
proportion of the genome that is identical by descent (IBDG), the FH measure is 
based on the excess in the observed number of homozygous genotypes within an 
individual relative to the mean number of homozygous genotypes expected under 
random mating (for references see function documentation). The nucleotide 
diversity (Pi) is also given. Pi measured here consider the consensus loci in 
the catalog (the reads with no variation between population).

## Roadmap of what's up next

* Joint Allele Frequency Spectrum from a \code{batch_x.sumstats.tsv} or \code{batch_x.haplotypes.tsv} files.
* Re-Integration with [strataG] (https://github.com/EricArcher/strataG.devel/tree/master/strataG.devel).
* Documentation and vignette.
* Tutorial of workflow.
* More linkage map tools.
* Use Shiny and ggvis when subplots or facet available.
* CRAN.
* Interaction with [STACKS] (http://creskolab.uoregon.edu/stacks/) database (Web-interface).
* Reference genome tools.
* Maybe try some integration with other GBS approaches: AftrRAD, pyRAD, dDocent.
* Got ideas ?


## Installation
You can try out the dev version of **stackr**. Follow the 2 steps below.

Step 1 You will need the package *devtools* and the dev version of *readr*
```r
install.packages("devtools")
library(devtools)
install_github("hadley/readr")
library(readr)
```

Step 2 Install **stackr**:
```r
install_github("thierrygosselin/stackr")
library(stackr)
```

On Mac OSX using a version of clang (the native compiler) with OpenMP greatly reduce the computation time for the imputation. There is a GCC version with OpenMP but it's highly unstable in R. To update your computer's compiler, follow the instruction below (inspired from [here](https://clang-omp.github.io)). In the terminal:

```r
cd Downloads
git clone https://github.com/clang-omp/llvm
git clone https://github.com/clang-omp/compiler-rt llvm/projects/compiler-rt
git clone -b clang-omp https://github.com/clang-omp/clang llvm/tools/clang

cd llvm
./configure
make
sudo make install
```

You need to tell R which compilers to use. Use TextWrangler or follow the lines below:
```r
cd ~
nano .R/Makevars
```

Enter the text below:
```r
CC=clang
CXX=clang++
PKG_CFLAGS=-g -O2
PKG_CXXFLAGS=-g -O2 -stdlib=libc++
```
Save and Exit with: crt-o, enter, crt-x


Preferably, re-install all packages depending on OpenMP or Rcpp.

```r
install.packages("Rcpp", type = "source")
install.packages("dplyr", type = "source")
install.packages("randomForestSRC", type = "source")
```

## GBS workflow
The **stackr** package fits currently at the end of the GBS workflow. Below, a flow chart using [STACKS] (http://creskolab.uoregon.edu/stacks/) and other software. You can use the [STACKS] (http://creskolab.uoregon.edu/stacks/) workflow [used in the Bernatchez lab] (https://github.com/enormandeau/stacks_workflow). ![](vignettes/GBS_workflow.png)

Functions found in **stackr** ![](vignettes/stackr_functions.png)
An example of the workflow ![](vignettes/stackr_workflow.png)
All-in-one filter ![](vignettes/stackr_all-in-one_filters.png)
Vignettes is a work in progress, check now and then for updates.
