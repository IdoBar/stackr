% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_cstacks.R
\name{run_cstacks}
\alias{run_cstacks}
\title{Run STACKS cstacks module}
\usage{
run_cstacks(b = 1, P = "06_ustacks_cstacks_sstacks",
  M = "population.map.catalog.tsv", g = FALSE, n = 1,
  p = parallel::detectCores() - 1, catalog.path = NULL, gapped = TRUE,
  max_gaps = 2, min_aln_len = 0.8, m = FALSE, k_len = NULL,
  report_mmatches = FALSE, h = FALSE)
}
\arguments{
\item{b}{database/batch ID for this catalog. Advice: don't modify.
Default: \code{b = 1}.}

\item{P}{path to the directory containing STACKS files.
Default: \code{P = "06_ustacks_cstacks_sstacks"}.
Inside the folder \code{06_ustacks_cstacks_sstacks}, you should have:
\itemize{
  \item \strong{4 files for each samples:} The sample name is the prefix of
  the files ending with:
\code{.alleles.tsv.gz, .models.tsv.gz, .snps.tsv.gz, .tags.tsv.gz}.
Those files are created in the
\href{http://catchenlab.life.illinois.edu/stacks/comp/ustacks.php}{ustacks}
module.
}}

\item{M}{path to a population map file (Required when P is used).
Default: \code{M = "06_ustacks_cstacks_sstacks/population.map.catalog.tsv"}.}

\item{g}{base catalog construction on alignment position, not sequence identity.
Advice: don't modify.
Default: \code{g = FALSE}.}

\item{n}{number of mismatches allowed between sample loci when build the catalog.
Default: \code{n = 1}}

\item{p}{enable parallel execution with num_threads threads.
Default: \code{p = parallel::detectCores() - 1}}

\item{catalog.path}{This is for the "Catalog editing" part in cstacks where
you can provide the path to an existing catalog.
cstacks will add data to this existing catalog.
With default: \code{catalog.path = NULL} or with a supplied path, the function
The function scan automatically for the presence of a catalog inside the input folder.
If none is found, a new catalog is created.
If your catalog is not in the input folder, supply a path here.
e.g. \code{catalog.path = ~/catalog_folder}, the catalog files are inside the
P folder along the samples files and detected automatically.
If a catalog is detected in the input folder,
the samples in the \code{sample.list} argument
will be added in this catalog. The catalog is made of 3 files:
\code{batch_1.catalog.alleles.tsv.gz,
batch_1.catalog.snps.tsv.gz,
batch_1.catalog.tags.tsv.gz}}

\item{gapped}{Gapped assembly options: do you want to preform
gapped alignments between stacks.
Default: \code{gapped = TRUE}}

\item{max_gaps}{The number of gaps allowed between stacks before merging.
Default: \code{max_gaps = 2}}

\item{min_aln_len}{The minimum length of aligned sequence in a gapped
alignment.
Default: \code{min_aln_len = 0.8}}

\item{m}{Include tags in the catalog that match to more than one entry.
Advice: don't modify.
Default: \code{m = FALSE}}

\item{k_len}{Specify k-mer size for matching between between catalog loci
(automatically calculated by default).
Advice: don't modify.
Default: \code{k_len = NULL}}

\item{report_mmatches}{Report query loci that match more than one catalog locus.
Advice: don't modify.
Default: \code{report_mmatches = FALSE}}

\item{h}{Display this help messsage.
Default: \code{h = FALSE}}
}
\value{
\href{http://catchenlab.life.illinois.edu/stacks/comp/sstacks.php}{sstacks}
returns a \code{.matches.tsv.gz file for each sample}
}
\description{
Run \href{http://catchenlab.life.illinois.edu/stacks/}{STACKS}
\href{http://catchenlab.life.illinois.edu/stacks/comp/cstacks.php}{cstacks}
module inside R!
}
\details{
\strong{Computer or server problem during the cstacks ?} Look
in the log file to see which individuals remains to be included. Create a
new list of individuals to include and use the catalog.path argument to point
to the catalog created before the problem.
}
\examples{
\dontrun{
# The simplest form of the function:
run_cstacks()
# that's it ! Now if you have your own workflow folders, etc. See below.
Next example, let say you only want to include 10 individuals/pop and
include in the catalog samples with more than 2000000 reads. With the project
info file in the global environment:
individuals.catalog <- project.info.file) \%>\%
filter(RETAINED > 2000000) \%>\%
group_by(POP_ID) \%>\%
sample_n(size = 10, replace = FALSE) \%>\%
ungroup \%>\%
arrange(desc(RETAINED)) \%>\%
distinct(INDIVIDUALS_REP)
# The next line will give you the list of individuals to include
individuals.catalog <- individuals.catalog$INDIVIDUALS_REP

# To keep your info file updated with this information:
project.info.file <- project.info.file \%>\%
mutate(CATALOG = if_else(INDIVIDUALS_REP \%in\% individuals.catalog,
true = "catalog", false = "not_catalog")
)
write_tsv(project.info.file, "project.info.catalog.tsv")

# Then run the command this way:
run_cstacks (
P = "06_ustacks_cstacks_sstacks",
catalog.path = NULL,
b = 1,
g = FALSE,
m = FALSE,
n = 1,
p = 32,
h = FALSE,
gapped = TRUE, max_gaps = 2, min_aln_len = 0.8,
k_len = NULL, report_mmatches = FALSE
)
}
}
\references{
Catchen JM, Amores A, Hohenlohe PA et al. (2011)
Stacks: Building and Genotyping Loci De Novo From Short-Read Sequences.
G3, 1, 171-182.

Catchen JM, Hohenlohe PA, Bassham S, Amores A, Cresko WA (2013)
Stacks: an analysis tool set for population genomics.
Molecular Ecology, 22, 3124-3140.
}
\seealso{
\href{http://catchenlab.life.illinois.edu/stacks/comp/sstacks.php}{sstacks}
}
