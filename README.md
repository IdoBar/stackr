# stackr

[![Travis-CI Build Status](https://travis-ci.org/thierrygosselin/stackr.svg?branch=master)](https://travis-ci.org/thierrygosselin/stackr)

The goal of **stackr** is to make GBS/RAD data produced by [STACKS] (http://creskolab.uoregon.edu/stacks/) easy to analyse in R.

This is the development page of the **stackr** package for the R software.

* Optimized for *de novo* and population genetics
* Read and modify *batch_x.sumstats.tsv* and *batch_x.haplotypes.tsv* files.
* Transform the VCF file, *batch_x.vcf*, into a tidy format to visualise and filter summary statistics within R.
* Filters genetic markers based on: coverage (read depth, REF and ALT allele depth), genotype likelihood, the number of individuals, the number of populations, observed heterozygosity and inbreeding coefficient (Fis).
* View distribution of summary statistics and create publication-ready figures
* Convert data into genind object for easy integration with **adegenet**, **hierfstat** and **pegas**.

## Roadmap of what's up next

* Documentation and vignette.
* Tutorial of workflow.
* Linkage map tools
* CRAN.
* Interaction with STACKS database (Web-interface).
* Reference genome tools.
* Integration with other pipeline: AftrRAD, pyRAD, dDocent.
* Got ideas ?


## Installation
You can try out the dev version of *stackr*. You will need the package *devtools*.

```r
install.packages("devtools")
install_github("thierrygosselin/stackr")
library("stackr")
```
