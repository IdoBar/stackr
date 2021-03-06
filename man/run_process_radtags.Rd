% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_process_radtags.R
\name{run_process_radtags}
\alias{run_process_radtags}
\title{Run STACKS process_radtags module}
\usage{
run_process_radtags(project.info, path.seq.lanes = "03_sequencing_lanes",
  i = "guess", o = "04_process_radtags", y = "guess",
  first.pe.input = NULL, second.pe.input = NULL, c = TRUE, q = TRUE,
  r = TRUE, t = 90, D = FALSE, E = "phred33", w = 0.15, s = 10,
  barcode_inline_null = TRUE, barcode_index_null = FALSE,
  barcode_null_index = FALSE, barcode_inline_inline = FALSE,
  barcode_index_index = FALSE, barcode_inline_index = FALSE,
  barcode_index_inline = FALSE, enzyme = NULL, renz_1 = NULL,
  renz_2 = NULL, adapter_1 = NULL, adapter_2 = NULL, adapter_mm = NULL,
  retain_header = FALSE, merge = FALSE, filter_illumina = TRUE,
  disable_rad_check = FALSE, len_limit = NULL, barcode_dist_1 = 1,
  barcode_dist_2 = NULL, parallel.core = parallel::detectCores() - 1)
}
\arguments{
\item{project.info}{(character, path) Path to the project info file.
The file is tab separated and as 3 columns named: \code{LANES}, \code{BRACODES}
and \code{INDIVIDUALS}. See details for more info.}

\item{path.seq.lanes}{(character, path) Path to sequencing lanes if
processing single-end sequences.
Same as \code{f} in STACKS command line.
Default: \code{path.seq.lanes = "03_sequencing_lanes"}.}

\item{i}{(character) Input file type, either \code{"fastq"}, \code{"gzfastq"},
\code{"bam"}, or \code{bustard}. Default: \code{i = "guess"}.}

\item{o}{(character, path) Path to output the processed files.
Default:\code{o = "04_process_radtags"}.}

\item{y}{(character) Output file type: \code{"fastq"}, \code{"gzfastq"},
\code{"fasta"}, or \code{gzfasta}. Default: \code{y = "guess"} (match input type).}

\item{first.pe.input}{(character, path) First input file in a set of
paired-end sequences. Default:\code{first.pe.input = NULL}.}

\item{second.pe.input}{(character, path) Second input file in a set of
paired-end sequences. Default:\code{second.pe.input = NULL}.}

\item{c}{(logical) Clean data, remove any read with an uncalled base.
Default:\code{c = TRUE}.}

\item{q}{(logical) Discard reads with low quality scores.
Default:\code{q = TRUE}.}

\item{r}{(logical) Rescue barcodes and RAD-Tags.
Default:\code{r = TRUE}.}

\item{t}{(integer) Truncate final read length to this value.
Default:\code{t = 90}.}

\item{D}{(logical) Capture discarded reads to a file.
Default:\code{D = FALSE}.}

\item{E}{(character) Specify how quality scores are encoded,
\code{"phred33"} for Illumina 1.8+/Sanger or \code{"phred64"} for Illumina 1.3-1.5.
Default:\code{E = "phred33"}.}

\item{w}{(double) Set the size of the sliding window as a fraction of the
read length, between 0 and 1.
Default:\code{W = 0.15}.}

\item{s}{(integer) Set the score limit.
If the average score within the sliding window drops below this value,
the read is discarded (default 10).
Default:\code{s = 10}.}

\item{barcode_inline_null}{(logical) Barcode is inline with sequence,
occurs only on single-end read.
Default:\code{barcode_inline_null = TRUE}.}

\item{barcode_index_null}{Barcode is provided in FASTQ header
(Illumina i5 or i7 read).
Default:\code{barcode_index_null = FALSE}.}

\item{barcode_null_index}{Barcode is provded in FASTQ header
(Illumina i7 read if both i5 and i7 read are provided).
Default:\code{barcode_null_index = FALSE}.}

\item{barcode_inline_inline}{Barcode is inline with sequence,
occurs on single and paired-end read.
Default:\code{barcode_inline_inline = FALSE}.}

\item{barcode_index_index}{Barcode is provded in FASTQ header
(Illumina i5 and i7 reads).
Default:\code{barcode_index_index = FALSE}.}

\item{barcode_inline_index}{Barcode is inline with sequence on single-end
read and occurs in FASTQ header (from either i5 or i7 read).
Default:\code{barcode_inline_index = FALSE}.}

\item{barcode_index_inline}{Barcode occurs in FASTQ header
(Illumina i5 or i7 read) and is inline with single-end sequence
(for single-end data) on paired-end read (for paired-end data).
Default:\code{barcode_index_inline = FALSE}.}

\item{enzyme}{(character) Provide the restriction enzyme used
(cut site occurs on single-end read).
If double-digest use: \code{enzyme = NULL}.
Currently supported enzymes include:
\code{"aciI"}, \code{"ageI"}, \code{"aluI"}, \code{"apaLI"}, \code{"apeKI"},
\code{"apoI"}, \code{"aseI"}, \code{"bamHI"}, \code{"bfaI"}, \code{"bgIII"},
\code{"bsaHI"}, \code{"bspDI"}, \code{"bstYI"}, \code{"claI"}, \code{"csp6I"},
\code{"ddeI"}, \code{"dpnII"}, \code{"eaeI"}, \code{"ecoRI"}, \code{"ecoRV"},
\code{"ecoT22I"}, \code{"haeIII"}, \code{"hindIII"}, \code{"hpaII"},
\code{"kpnI"}, \code{"mluCI"}, \code{"mseI"}, \code{"mspI"}, \code{"ncoI"},
\code{"ndeI"}, \code{"nheI"}, \code{"nlaIII"}, \code{"notI"}, \code{"nsiI"},
\code{"pstI"}, \code{"rsaI"}, \code{"sacI"}, \code{"sau3AI"}, \code{"sbfI"},
\code{"sexAI"}, , \code{"sgrAI"}, \code{"speI"}, \code{"sphI"}, \code{"taqI"},
\code{"xbaI"}, or \code{"xhoI"}.}

\item{renz_1}{(character) When a double digest was used,
provide the first restriction enzyme used.}

\item{renz_2}{(character) When a double digest was used,
provide the second restriction enzyme used (cut site occurs on the paired-end read).}

\item{adapter_1}{(character) Provide adaptor sequence that may occur on the
single-end read for filtering.}

\item{adapter_2}{(character) Provide adaptor sequence that may occur on the
paired-read for filtering.}

\item{adapter_mm}{(integer) Number of mismatches allowed in the adapter sequence.}

\item{retain_header}{(logical) Retain unmodified FASTQ headers in the output.
Default: \code{retain_header = FALSE}.}

\item{merge}{(logical) If no barcodes are specified,
merge all input files into a single output file.
Default: \code{merge = FALSE}.}

\item{filter_illumina}{(logical) Discard reads that have been marked by
Illumina's chastity/purity filter as failing.
Default: \code{filter_illumina = TRUE}.}

\item{disable_rad_check}{(logical) Disable checking if the RAD site is intact.
Default: \code{disable_rad_check = FALSE}.}

\item{len_limit}{(integer) Specify a minimum sequence length
(useful if your data has already been trimmed).
Default: \code{len_limit = NULL}.}

\item{barcode_dist_1}{(integer) The number of allowed mismatches when
rescuing single-end barcodes.
Default: \code{barcode_dist_1 = 1}.}

\item{barcode_dist_2}{(integer) The number of allowed mismatches when
rescuing paired-end barcodes.
Default: \code{barcode_dist_2 = NULL} (will default to barcode_dist_1).}

\item{parallel.core}{(optional) The number of core for parallel
programming.
Default: \code{parallel.core = parallel::detectCores() - 1}.}
}
\value{
For stacks specific output see \href{http://catchenlab.life.illinois.edu/stacks/comp/process_radtags.php}{process_radtags}.
}
\description{
Run \href{http://catchenlab.life.illinois.edu/stacks/}{STACKS}
\href{http://catchenlab.life.illinois.edu/stacks/comp/process_radtags.php}{process_radtags}
module inside R. This function was tested on single-end sequences only.
If you want to contribute with other types of RAD data, let me know.
}
\details{
\strong{Step 1. Individual naming}

Please take a moment to think about the way you want to name your individuals...
Here is my recipe:
\enumerate{
\item Include metadata: SPECIES, POPULATIONS or SAMPLING SITES, MATURITY, YEAR of sampling, numerical ID with 3 to 4 digits.
\item 3 letters in ALL CAPS: capital letters are easier to read and will reduce confusion for other
people in deciphering your handwritting or the font you've used. The 3 letters will keep it short.
\item only 1 type of separator: the dash (-): why? it's the easiest separator to avoid confusion.
Please avoid the underscore (_) as it will sometimes be impossible to tell
if it's a whitespace or an underscore in printd lists or even in some codes.

\strong{example:}

Following this convention: SPECIES-POP-MATURITY-YEAR-ID

My ids: STU-QUE-ADU-2017-0001, STU-ONT-JUV-2016-0002

\strong{Species: }Sturgeon

\strong{Sampling site: }Québec and Ontario

\strong{Year of sampling: } 2016 and 2017

\strong{MATURITY: } adult and juvenile

\strong{ID: } 2 samples 0001 and 0002
}

\strong{Step 2. project info file:}

Create a tab separated file (e.g. in MS Excel) with 3 columns named:
\code{LANES}, \code{BRACODES} and \code{INDIVIDUALS}.
For each individuals you've just created,
give the barcodes and lanes name.

\strong{REPLICATES ?}

You have replicates? Awesome. stackr makes it easy to keep track of replicates.
Use the same name for individual replicates. They will have different barcodes,
and can potentially be on different lanes. No problem. stackr will combine
fastq file at the end, keeping original replicates intact. However, stackr
will be appending integers (e.g. STU-QUE-ADU-2017-0001-1, STU-QUE-ADU-2017-0001-2)
at the end of the names you've chosen). Combined replicates
will have -R at the end (e.g STU-QUE-ADU-2017-0001-R for the combination of the 2 replicates.)
}
\examples{
\dontrun{
# library(stackr)
# If you haven't already build the folders to store all the files:
# stackr::build_stackr_workflow_dir()
#
# run a double digest process_radtags within R:
process.radtags.tuna <- stackr::run_process_radtags(
project.info = "02_project_info/project.info.tuna.tsv",
path.seq.lanes = "03_sequencing_lanes",
renz_1 = "pstI", renz_2 = "mspI",
adapter_1 = "CGAGATCGGAAGAGCGGG", adapter_mm = 2)
# remaining arguments are defaults, so carefully look at them in the doc.
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
\href{http://catchenlab.life.illinois.edu/stacks/comp/process_radtags.php}{process_radtags}.
}
