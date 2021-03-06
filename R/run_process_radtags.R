#' @name run_process_radtags
#' @title Run STACKS process_radtags module
#' @description Run \href{http://catchenlab.life.illinois.edu/stacks/}{STACKS}
#' \href{http://catchenlab.life.illinois.edu/stacks/comp/process_radtags.php}{process_radtags}
#' module inside R. This function was tested on single-end sequences only.
#' If you want to contribute with other types of RAD data, let me know.

#' @param project.info (character, path) Path to the project info file.
#' The file is tab separated and as 3 columns named: \code{LANES}, \code{BRACODES}
#' and \code{INDIVIDUALS}. See details for more info.

#' @param path.seq.lanes (character, path) Path to sequencing lanes if
#' processing single-end sequences.
#' Same as \code{f} in STACKS command line.
#' Default: \code{path.seq.lanes = "03_sequencing_lanes"}.
#' @param i (character) Input file type, either \code{"fastq"}, \code{"gzfastq"},
#' \code{"bam"}, or \code{bustard}. Default: \code{i = "guess"}.
#' @param o (character, path) Path to output the processed files.
#' Default:\code{o = "04_process_radtags"}.
#' @param y (character) Output file type: \code{"fastq"}, \code{"gzfastq"},
#' \code{"fasta"}, or \code{gzfasta}. Default: \code{y = "guess"} (match input type).
#' @param first.pe.input (character, path) First input file in a set of
#' paired-end sequences. Default:\code{first.pe.input = NULL}.
#' @param second.pe.input (character, path) Second input file in a set of
#' paired-end sequences. Default:\code{second.pe.input = NULL}.



#' @param c (logical) Clean data, remove any read with an uncalled base.
#' Default:\code{c = TRUE}.
#' @param q (logical) Discard reads with low quality scores.
#' Default:\code{q = TRUE}.
#' @param r (logical) Rescue barcodes and RAD-Tags.
#' Default:\code{r = TRUE}.

#' @param t (integer) Truncate final read length to this value.
#' Default:\code{t = 90}.

#' @param D (logical) Capture discarded reads to a file.
#' Default:\code{D = FALSE}.
#' @param E (character) Specify how quality scores are encoded,
#' \code{"phred33"} for Illumina 1.8+/Sanger or \code{"phred64"} for Illumina 1.3-1.5.
#' Default:\code{E = "phred33"}.

#' @param w (double) Set the size of the sliding window as a fraction of the
#' read length, between 0 and 1.
#' Default:\code{W = 0.15}.

#' @param s (integer) Set the score limit.
#' If the average score within the sliding window drops below this value,
#' the read is discarded (default 10).
#' Default:\code{s = 10}.


#' @param barcode_inline_null (logical) Barcode is inline with sequence,
#' occurs only on single-end read.
#' Default:\code{barcode_inline_null = TRUE}.
#' @param barcode_index_null Barcode is provided in FASTQ header
#' (Illumina i5 or i7 read).
#' Default:\code{barcode_index_null = FALSE}.
#' @param barcode_null_index Barcode is provded in FASTQ header
#' (Illumina i7 read if both i5 and i7 read are provided).
#' Default:\code{barcode_null_index = FALSE}.
#' @param barcode_inline_inline Barcode is inline with sequence,
#' occurs on single and paired-end read.
#' Default:\code{barcode_inline_inline = FALSE}.
#' @param barcode_index_index Barcode is provded in FASTQ header
#' (Illumina i5 and i7 reads).
#' Default:\code{barcode_index_index = FALSE}.
#' @param barcode_inline_index Barcode is inline with sequence on single-end
#' read and occurs in FASTQ header (from either i5 or i7 read).
#' Default:\code{barcode_inline_index = FALSE}.
#' @param barcode_index_inline Barcode occurs in FASTQ header
#' (Illumina i5 or i7 read) and is inline with single-end sequence
#' (for single-end data) on paired-end read (for paired-end data).
#' Default:\code{barcode_index_inline = FALSE}.

#' @param enzyme (character) Provide the restriction enzyme used
#' (cut site occurs on single-end read).
#' If double-digest use: \code{enzyme = NULL}.
#' Currently supported enzymes include:
#' \code{"aciI"}, \code{"ageI"}, \code{"aluI"}, \code{"apaLI"}, \code{"apeKI"},
#' \code{"apoI"}, \code{"aseI"}, \code{"bamHI"}, \code{"bfaI"}, \code{"bgIII"},
#' \code{"bsaHI"}, \code{"bspDI"}, \code{"bstYI"}, \code{"claI"}, \code{"csp6I"},
#' \code{"ddeI"}, \code{"dpnII"}, \code{"eaeI"}, \code{"ecoRI"}, \code{"ecoRV"},
#' \code{"ecoT22I"}, \code{"haeIII"}, \code{"hindIII"}, \code{"hpaII"},
#' \code{"kpnI"}, \code{"mluCI"}, \code{"mseI"}, \code{"mspI"}, \code{"ncoI"},
#' \code{"ndeI"}, \code{"nheI"}, \code{"nlaIII"}, \code{"notI"}, \code{"nsiI"},
#' \code{"pstI"}, \code{"rsaI"}, \code{"sacI"}, \code{"sau3AI"}, \code{"sbfI"},
#' \code{"sexAI"}, , \code{"sgrAI"}, \code{"speI"}, \code{"sphI"}, \code{"taqI"},
#' \code{"xbaI"}, or \code{"xhoI"}.
#' @param renz_1 (character) When a double digest was used,
#' provide the first restriction enzyme used.
#' @param renz_2 (character) When a double digest was used,
#' provide the second restriction enzyme used (cut site occurs on the paired-end read).
#' @param adapter_1 (character) Provide adaptor sequence that may occur on the
#' single-end read for filtering.
#' @param adapter_2 (character) Provide adaptor sequence that may occur on the
#' paired-read for filtering.
#' @param adapter_mm (integer) Number of mismatches allowed in the adapter sequence.
#' @param retain_header (logical) Retain unmodified FASTQ headers in the output.
#' Default: \code{retain_header = FALSE}.
#' @param merge (logical) If no barcodes are specified,
#' merge all input files into a single output file.
#' Default: \code{merge = FALSE}.
#' @param filter_illumina (logical) Discard reads that have been marked by
#' Illumina's chastity/purity filter as failing.
#' Default: \code{filter_illumina = TRUE}.
#' @param disable_rad_check (logical) Disable checking if the RAD site is intact.
#' Default: \code{disable_rad_check = FALSE}.

#' @param len_limit (integer) Specify a minimum sequence length
#' (useful if your data has already been trimmed).
#' Default: \code{len_limit = NULL}.
#' @param barcode_dist_1 (integer) The number of allowed mismatches when
#' rescuing single-end barcodes.
#' Default: \code{barcode_dist_1 = 1}.
#' @param barcode_dist_2 (integer) The number of allowed mismatches when
#' rescuing paired-end barcodes.
#' Default: \code{barcode_dist_2 = NULL} (will default to barcode_dist_1).

#' @param parallel.core (optional) The number of core for parallel
#' programming.
#' Default: \code{parallel.core = parallel::detectCores() - 1}.


#' @rdname run_process_radtags
#' @export
#' @importFrom stringi stri_join stri_replace_all_fixed stri_sub stri_detect_fixed
#' @importFrom dplyr mutate filter distinct
#' @importFrom purrr keep walk pwalk pmap
#' @importFrom tibble data_frame

#' @return For stacks specific output see \href{http://catchenlab.life.illinois.edu/stacks/comp/process_radtags.php}{process_radtags}.
#'
#'


#' @details
#' \strong{Step 1. Individual naming}
#'
#' Please take a moment to think about the way you want to name your individuals...
#' Here is my recipe:
#' \enumerate{
#' \item Include metadata: SPECIES, POPULATIONS or SAMPLING SITES, MATURITY, YEAR of sampling, numerical ID with 3 to 4 digits.
#' \item 3 letters in ALL CAPS: capital letters are easier to read and will reduce confusion for other
#' people in deciphering your handwritting or the font you've used. The 3 letters will keep it short.
#' \item only 1 type of separator: the dash (-): why? it's the easiest separator to avoid confusion.
#' Please avoid the underscore (_) as it will sometimes be impossible to tell
#' if it's a whitespace or an underscore in printd lists or even in some codes.
#'
#' \strong{example:}
#'
#' Following this convention: SPECIES-POP-MATURITY-YEAR-ID
#'
#' My ids: STU-QUE-ADU-2017-0001, STU-ONT-JUV-2016-0002
#'
#' \strong{Species: }Sturgeon
#'
#' \strong{Sampling site: }Québec and Ontario
#'
#' \strong{Year of sampling: } 2016 and 2017
#'
#' \strong{MATURITY: } adult and juvenile
#'
#' \strong{ID: } 2 samples 0001 and 0002
#' }
#'
#' \strong{Step 2. project info file:}
#'
#' Create a tab separated file (e.g. in MS Excel) with 3 columns named:
#' \code{LANES}, \code{BRACODES} and \code{INDIVIDUALS}.
#' For each individuals you've just created,
#' give the barcodes and lanes name.
#'
#' \strong{REPLICATES ?}
#'
#' You have replicates? Awesome. stackr makes it easy to keep track of replicates.
#' Use the same name for individual replicates. They will have different barcodes,
#' and can potentially be on different lanes. No problem. stackr will combine
#' fastq file at the end, keeping original replicates intact. However, stackr
#' will be appending integers (e.g. STU-QUE-ADU-2017-0001-1, STU-QUE-ADU-2017-0001-2)
#' at the end of the names you've chosen). Combined replicates
#' will have -R at the end (e.g STU-QUE-ADU-2017-0001-R for the combination of the 2 replicates.)



#' @examples
#' \dontrun{
#' # library(stackr)
#' # If you haven't already build the folders to store all the files:
#' # stackr::build_stackr_workflow_dir()
#' #
#' # run a double digest process_radtags within R:
#' process.radtags.tuna <- stackr::run_process_radtags(
#' project.info = "02_project_info/project.info.tuna.tsv",
#' path.seq.lanes = "03_sequencing_lanes",
#' renz_1 = "pstI", renz_2 = "mspI",
#' adapter_1 = "CGAGATCGGAAGAGCGGG", adapter_mm = 2)
#' # remaining arguments are defaults, so carefully look at them in the doc.
#' }


#' @seealso
#' \href{http://catchenlab.life.illinois.edu/stacks/comp/process_radtags.php}{process_radtags}.

#' @references Catchen JM, Amores A, Hohenlohe PA et al. (2011)
#' Stacks: Building and Genotyping Loci De Novo From Short-Read Sequences.
#' G3, 1, 171-182.
#' @references Catchen JM, Hohenlohe PA, Bassham S, Amores A, Cresko WA (2013)
#' Stacks: an analysis tool set for population genomics.
#' Molecular Ecology, 22, 3124-3140.

# run_process_radtags ----------------------------------------------------------
run_process_radtags <- function(
  project.info,
  path.seq.lanes = "03_sequencing_lanes",
  i = "guess",
  o = "04_process_radtags",
  y = "guess",
  first.pe.input = NULL,
  second.pe.input = NULL,
  c = TRUE,
  q = TRUE,
  r = TRUE,
  t = 90,
  D = FALSE,
  E = "phred33",
  w = 0.15,
  s = 10,
  barcode_inline_null = TRUE,
  barcode_index_null = FALSE,
  barcode_null_index = FALSE,
  barcode_inline_inline = FALSE,
  barcode_index_index = FALSE,
  barcode_inline_index = FALSE,
  barcode_index_inline = FALSE,
  enzyme = NULL,
  renz_1 = NULL,
  renz_2 = NULL,
  adapter_1 = NULL,
  adapter_2 = NULL,
  adapter_mm = NULL,
  retain_header = FALSE,
  merge = FALSE,
  filter_illumina = TRUE,
  disable_rad_check = FALSE,
  len_limit = NULL,
  barcode_dist_1 = 1,
  barcode_dist_2 = NULL,
  parallel.core = parallel::detectCores() - 1
) {
  cat("#######################################################################\n")
  cat("#################### stackr::run_process_radtags ######################\n")
  cat("#######################################################################\n")
  timing <- proc.time()


  # Check directory ------------------------------------------------------------
  if (!dir.exists(o)) dir.create(o)
  if (!dir.exists("09_log_files")) dir.create("09_log_files")
  if (!dir.exists("02_project_info")) dir.create("02_project_info")
  if (!dir.exists("08_stacks_results")) dir.create("08_stacks_results")


  # Date and time --------------------------------------------------------------
  file.date <- stringi::stri_replace_all_fixed(
    Sys.time(),
    pattern = " EDT", replacement = "") %>%
    stringi::stri_replace_all_fixed(
      str = .,
      pattern = c("-", " ", ":"), replacement = c("", "@", ""),
      vectorize_all = FALSE) %>%
    stringi::stri_sub(str = ., from = 1, to = 13)


  # Import project info file ---------------------------------------------------
  message("Importing project info")
  project.info.file <- readr::read_tsv(file = project.info, col_types = "ccc")

  # Manage duplicate ID
  message("Scanning for duplicate IDs...")
  duplicate.id <- project.info.file %>%
    dplyr::group_by(INDIVIDUALS) %>%
    dplyr::tally(.) %>%
    dplyr::filter(n > 1 & !is.na(INDIVIDUALS))

  if (nrow(duplicate.id) > 0) {
    duplicate.id <- duplicate.id %>%
      dplyr::distinct(INDIVIDUALS) %>%
      dplyr::inner_join(project.info.file, by = "INDIVIDUALS") %>%
      dplyr::group_by(INDIVIDUALS) %>%
      dplyr::mutate(REPLICATES = seq(1, n()))
  } else {
    duplicate.id <- project.info.file %>%
      dplyr::mutate(REPLICATES = rep(NA, n()))
  }

  # Manage horrible sequencing lanes names
  short.name.lanes <- project.info.file %>%
    dplyr::ungroup(.) %>%
    dplyr::distinct(LANES) %>%
    dplyr::arrange(LANES) %>%
    dplyr::mutate(
      LANES_SHORT = stringi::stri_join(rep("LANE"), stringi::stri_pad_left(
        str = seq(1, nrow(.)), width = 2, pad = "0"), sep = "_")
    )

  project.info.file <- project.info.file %>%
    dplyr::left_join(duplicate.id, by = c("INDIVIDUALS", "BARCODES", "LANES")) %>%
    dplyr::left_join(short.name.lanes, by = c("LANES")) %>%
    dplyr::arrange(LANES_SHORT, INDIVIDUALS) %>%
    dplyr::mutate(
      INDIVIDUALS_REP = ifelse(!is.na(REPLICATES), stringi::stri_paste(INDIVIDUALS, REPLICATES, sep = "-"), INDIVIDUALS),
      REPLICATES = stringi::stri_replace_na(str = REPLICATES, replacement = 0)
    ) %>%
    dplyr::select(LANES, LANES_SHORT, BARCODES, INDIVIDUALS, INDIVIDUALS_REP, REPLICATES) %>%
    dplyr::filter(!is.na(INDIVIDUALS)) %>%
    dplyr::filter(!is.na(BARCODES)) %>%
    dplyr::arrange(LANES_SHORT, INDIVIDUALS)

  readr::write_tsv(
    project.info.file,
    stringi::stri_join("02_project_info/project.info.", file.date, ".tsv"))

  sample.per.lanes <- project.info.file %>%
    dplyr::group_by(LANES_SHORT) %>%
    dplyr::tally(.) %>%
    dplyr::arrange(LANES_SHORT)
  # write_tsv(sample.per.lanes, "sample.per.lanes.tsv")

  # get the list of sequencing lane present in the folder
  # lane.list <- list.files(path = path.seq.lanes, full.names = TRUE)
  # check lanes in project info file and directory
  lane.names <- list.files(path = path.seq.lanes, full.names = FALSE)
  lanes.todo <- unique(project.info.file$LANES)
  no.problem <- unique(lanes.todo %in% lane.names)
  if (!no.problem || length(no.problem) > 1) stop("Lane names don't match between project info file and lanes in folder...")
  lane.list <- stringi::stri_join(path.seq.lanes, "/", lanes.todo)

  process_radtags_lane <- function(
    lane.list,
    project.info.file = project.info.file,
    path.seq.lanes = "03_sequencing_lanes",
    i = "guess",
    o = "04_process_radtags",
    y = "guess",
    first.pe.input = NULL,
    second.pe.input = NULL,
    c = TRUE,
    q = TRUE,
    r = TRUE,
    t = 90,
    D = FALSE,
    E = "phred33",
    w = 0.15,
    s = 10,
    barcode_inline_null = TRUE,
    barcode_index_null = FALSE,
    barcode_null_index = FALSE,
    barcode_inline_inline = FALSE,
    barcode_index_index = FALSE,
    barcode_inline_index = FALSE,
    barcode_index_inline = FALSE,
    enzyme = NULL,
    renz_1 = NULL,
    renz_2 = NULL,
    adapter_1 = NULL,
    adapter_2 = NULL,
    adapter_mm = NULL,
    retain_header = FALSE,
    merge = FALSE,
    filter_illumina = TRUE,
    disable_rad_check = FALSE,
    len_limit = NULL,
    barcode_dist_1 = 1,
    barcode_dist_2 = NULL
  ) {
    # lane.list <- "03_sequencing_lanes/HI.2385.001.GQ20141028-1_R1.fastq.gz" # test
    f <- lane.list

    # generate a barcode file for the lane -------------------------------------
    lane.todo <- stringi::stri_replace_all_fixed(
      str = lane.list,
      pattern = stringi::stri_join(path.seq.lanes, "/"),
      replacement = "", vectorized_all = FALSE)

    info <- dplyr::ungroup(project.info.file) %>%
      dplyr::filter(LANES == lane.todo)

    lane.short <- unique(info$LANES_SHORT)

    barcode.file <- info %>%
      dplyr::select(BARCODES, INDIVIDUALS_REP)

    b <- stringi::stri_join("02_project_info/barcodes_id", "_", lane.short, ".txt")

    # if (is.null(problem.samples)) {
    #   b <- stringi::stri_join("02_project_info/barcodes_id", "_", lane.short, ".txt")
    # } else {
    #   b <- stringi::stri_join("02_project_info/barcodes_id", "_", lane.short, "_problem_samples",".txt")
    # }
    readr::write_tsv(barcode.file, b, col_names = FALSE)

    # process_radtags_options --------------------------------------------------
    f <- stringi::stri_join("-f ", shQuote(f))

    if (i == "guess") {
      i <- ""
    } else {
      i <- stringi::stri_join("-i ", shQuote(i))
    }

    if (y == "guess") {
      y <- ""
    } else {
      y <- stringi::stri_join("-y ", shQuote(y))
    }


    # if (is.null(p)) {
    #   p <- ""
    # } else {
    #   p <- stringi::stri_join("-p ", shQuote(p))
    # }

    # if (is.null(P)) {
    #   P <- ""
    # } else {
    #   P <- stringi::stri_join("-P ", shQuote(P))
    # }

    # if (is.null(I)) {
    #   I <- ""
    # } else {
    #   I <- stringi::stri_join("-I ", shQuote(I))
    # }

    if (is.null(first.pe.input)) {
      first.pe.input <- ""
    } else {
      first.pe.input <- stringi::stri_join("-1 ", shQuote(first.pe.input))
    }

    if (is.null(second.pe.input)) {
      second.pe.input <- ""
    } else {
      second.pe.input <- stringi::stri_join("-2 ", shQuote(second.pe.input))
    }

    temp.dir <- stringi::stri_join(o, lane.short, sep = "/")
    dir.create(temp.dir)
    o <- stringi::stri_join("-o ", shQuote(temp.dir))

    b <- stringi::stri_join("-b ", shQuote(b))

    if (c) {
      c <- stringi::stri_join("-c ")
    } else {
      c <- ""
    }

    if (q) {
      q <- stringi::stri_join("-q ")
    } else {
      q <- ""
    }

    if (r) {
      r <- stringi::stri_join("-r ")
      rescue.barcodes <- TRUE
    } else {
      r <- ""
      rescue.barcodes <- FALSE
    }

    t <- stringi::stri_join("-t ", t)

    E <- stringi::stri_join("-E ", shQuote(E))

    if (D) {
      D <- stringi::stri_join("-D ")
    } else {
      D <- ""
    }

    w <- stringi::stri_join("-w ", w)
    s <- stringi::stri_join("-s ", s)


    # if (h) {
    #   h <- stringi::stri_join("-h ")
    # } else {
    #   h <- ""
    # }

    # BARCODES OPTIONS -----------------------------------------------------------
    if (barcode_inline_null) {
      barcode_inline_null <- "--inline_null"
    } else {
      barcode_inline_null <- ""
    }

    if (barcode_index_null) {
      barcode_index_null <- "--index_null"
    } else {
      barcode_index_null <- ""
    }

    if (barcode_null_index) {
      barcode_null_index <- "--null_index"
    } else {
      barcode_null_index <- ""
    }

    if (barcode_inline_inline) {
      barcode_inline_inline <- "--inline_inline"
    } else {
      barcode_inline_inline <- ""
    }

    if (barcode_index_index) {
      barcode_index_index <- "--index_index"
    } else {
      barcode_index_index <- ""
    }

    if (barcode_inline_index) {
      barcode_inline_index <- "--inline_index"
    } else {
      barcode_inline_index <- ""
    }

    if (barcode_index_inline) {
      barcode_index_inline <- "--index_inline"
    } else {
      barcode_index_inline <- ""
    }

    # Restriction enzyme options--------------------------------------------------

    if (is.null(enzyme)) {
      enzyme <- ""
    } else {
      enzyme <- stringi::stri_join("-e ", shQuote(enzyme))
    }

    if (is.null(renz_1)) {
      renz_1 <- ""
    } else {
      renz_1 <- stringi::stri_join("--renz_1 ", shQuote(renz_1))
    }

    if (is.null(renz_2)) {
      renz_2 <- ""
    } else {
      renz_2 <- stringi::stri_join("--renz_2 ", shQuote(renz_2))
    }

    #  Adapter options: ------------------------------------------------------------
    if (is.null(adapter_1)) {
      adapter_1 <- ""
    } else {
      adapter_1 <- stringi::stri_join("--adapter_1 ", shQuote(adapter_1))
    }

    if (is.null(adapter_2)) {
      adapter_2 <- ""
    } else {
      adapter_2 <- stringi::stri_join("--adapter_2 ", shQuote(adapter_2))
    }

    if (is.null(adapter_mm)) {
      adapter_mm <- ""
    } else {
      adapter_mm <- stringi::stri_join("--adapter_mm ", adapter_mm)
    }

    # Output options--------------------------------------------------------------
    if (retain_header) {
      retain_header <- stringi::stri_join("--retain_header")
    } else {
      retain_header <- ""
    }

    if (merge) {
      merge <- stringi::stri_join("--merge")
    } else {
      merge <- ""
    }
    # Advanced options -----------------------------------------------------------

    if (filter_illumina) {
      filter_illumina <- stringi::stri_join("--filter_illumina")
    } else {
      filter_illumina <- ""
    }
    if (disable_rad_check) {
      disable_rad_check <- disable_rad_check("--disable_rad_check")
    } else {
      disable_rad_check <- ""
    }

    if (is.null(len_limit)) {
      len_limit <- ""
    } else {
      len_limit <- stringi::stri_join("--len_limit ", len_limit)
    }

    if (rescue.barcodes) {
      barcode.dist.1 <- barcode_dist_1
      barcode_dist_1 <- stringi::stri_join("--barcode_dist_1 ", barcode_dist_1)
      if (is.null(barcode_dist_2)) {
        barcode_dist_2 <- barcode.dist.1
      }
      barcode_dist_2 <- stringi::stri_join("--barcode_dist_2 ", barcode_dist_2)
    }

    command.arguments <- paste(
      f, i, y,
      # p, P, I,
      first.pe.input, second.pe.input,
      o, b, c, q, r, t, E, D, w, s,
      barcode_inline_null,
      barcode_index_null,
      barcode_null_index,
      barcode_inline_inline,
      barcode_index_index,
      barcode_inline_index,
      barcode_index_inline,
      enzyme, renz_1, renz_2,
      adapter_1, adapter_2, adapter_mm,
      retain_header, merge,
      filter_illumina, disable_rad_check, len_limit,
      barcode_dist_1, barcode_dist_2
    )
    # log file -----------------------------------------------------------------
    process.radtags.log.file <- stringi::stri_join("09_log_files/process_radtags_", lane.short, "_", file.date, ".log")

    # running the command ------------------------------------------------------
    system2(command = "process_radtags", args = command.arguments, stderr = process.radtags.log.file)

    # results --------------------------------------------------------------------

    # Importing log file created by stacks to summarise and rename
    log.file <- list.files(path = temp.dir, pattern = "process_radtags", full.names = TRUE)

    # lane statistics
    lanes.stats <- readr::read_tsv(
      file = log.file,
      col_names = c("DESCRIPTION", "READS"),
      col_types = "ci",trim_ws = TRUE, skip = 6, n_max = 7) %>%
      dplyr::mutate(
        DESCRIPTION = stringi::stri_replace_all_fixed(
          str = DESCRIPTION,
          pattern = " ",
          replacement = "_", vectorized_all = FALSE),
        DESCRIPTION = stringi::stri_trans_toupper(str = DESCRIPTION),
        LANES_SHORT = rep(lane.short, n())
      ) %>%
      dplyr::group_by(LANES_SHORT) %>%
      tidyr::spread(data = ., key = DESCRIPTION, value = READS)

    # save lane stats
    readr::write_tsv(
      x = lanes.stats,
      path = stringi::stri_join(
        "08_stacks_results/",
        stringi::stri_join("process_radtags_", lane.short, "_stats"), ".tsv"))

    # barcode stats
    temp.file <- suppressWarnings(suppressMessages(readr::read_table(file = log.file, col_names = FALSE)))
    skip.number <- which(stringi::stri_detect_fixed(
      str = temp.file$X1,
      pattern = "Barcode\tFilename\tTotal\tNoRadTag\tLowQuality\tRetained")) - 1

    barcodes.stats <- suppressMessages(
      suppressWarnings(
        readr::read_delim(
          log.file,
          delim = "\t",
          skip = skip.number,
          n_max = nrow(barcode.file),
          col_names = TRUE,
          progress = interactive()) %>%
          dplyr::mutate(LANES_SHORT = rep(lane.short, n()))))


    # rename and move log file in log folder
    new.log.file.name <- stringi::stri_join(
      "09_log_files/process_radtags_summary_log_", lane.short, ".log")
    file.rename(from = log.file, to = new.log.file.name)

    # save barcodes stats
    barcode.res.list.name <- stringi::stri_join(
      "process_radtags_", lane.short, "_barcodes_stats")
    readr::write_tsv(
      x = barcodes.stats,
      path = stringi::stri_join("08_stacks_results/", barcode.res.list.name, ".tsv"))
  } # end process_radtags_lane


  # run in parallel ------------------------------------------------------------
  message("Running process_radtags in parallel")
  message("    for progress, look in the different log files generated")
  process.radtags.results <- .stackr_parallel_mc(
    X = lane.list,
    FUN = process_radtags_lane,
    mc.preschedule = FALSE,
    mc.silent = FALSE,
    mc.cleanup = TRUE,
    mc.cores = parallel.core,
    path.seq.lanes = path.seq.lanes,
    project.info.file = project.info.file,
    i = i,
    o = o,
    y = y,
    first.pe.input = first.pe.input,
    second.pe.input = second.pe.input,
    c = c,
    q = q,
    r = r,
    t = t,
    D = D,
    E = E,
    w = w,
    s = s,
    barcode_inline_null = barcode_inline_null,
    barcode_index_null = barcode_index_null,
    barcode_null_index = barcode_null_index,
    barcode_inline_inline = barcode_inline_inline,
    barcode_index_index = barcode_index_index,
    barcode_inline_index = barcode_inline_index,
    barcode_index_inline = barcode_index_inline,
    enzyme = enzyme,
    renz_1 = renz_1,
    renz_2 = renz_2,
    adapter_1 = adapter_1,
    adapter_2 = adapter_2,
    adapter_mm = adapter_mm,
    retain_header = retain_header,
    merge = merge,
    filter_illumina = filter_illumina,
    disable_rad_check = disable_rad_check,
    len_limit = len_limit,
    barcode_dist_1 = barcode_dist_1,
    barcode_dist_2 = barcode_dist_2
  ) %>%
    dplyr::bind_rows(.) %>%
    `colnames<-`(stringi::stri_trans_toupper(str = colnames(.))) %>%
    `colnames<-`(stringi::stri_replace_all_fixed(
      str = colnames(.),
      pattern = " ",
      replacement = "_", vectorize_all = FALSE)) %>%
    dplyr::select(
      INDIVIDUALS_REP = FILENAME, TOTAL,
      NO_RADTAG = NORADTAG, LOW_QUALITY = LOWQUALITY, RETAINED)

  # transfer the fq.gz file from the separate folder into a new folder

  # get the names of the folder
  folder.list <- list.files(path = o, full.names = TRUE)
  folder.list

  destination.folder <- o

  transfer_folder_individuals_fq <- function(folder.list) {
    fq.names <- list.files(path = folder.list)

    transfer_individual_fq <- function(fq.names) {
      fq.names.full.path <- stringi::stri_join(folder.list, fq.names, sep = "/")

      # move to destination folder
      new.fq.path <- stringi::stri_join(destination.folder, fq.names, sep = "/")
      file.rename(from = fq.names.full.path, to = new.fq.path)
    }
    purrr::walk(.x = fq.names, .f = transfer_individual_fq)
  }
  purrr::walk(.x = folder.list, .f = transfer_folder_individuals_fq)

  #Remove foldes of lanes
  remove_lane_folder <- function(folder.list) {
    file.remove(folder.list)
  }
  purrr::walk(.x = folder.list, .f = remove_lane_folder)

  # combine replicates in a new fq file-----------------------------------------
  # message("Scanning for replicates...")
  project.info.file <- project.info.file %>%
    dplyr::mutate(FQ_FILES = stringi::stri_join(INDIVIDUALS_REP, ".fq.gz")) %>%
    dplyr::inner_join(process.radtags.results, by = "INDIVIDUALS_REP")

  readr::write_tsv(
    project.info.file,
    stringi::stri_join("02_project_info/project.info.", file.date, ".tsv"))

  # replicates
  replicates <- project.info.file %>%
    dplyr::filter(REPLICATES >= 1) %>%
    dplyr::arrange(INDIVIDUALS_REP) %>%
    dplyr::distinct(INDIVIDUALS_REP, .keep_all = TRUE)

  replicate.presence <- nrow(replicates)

  if (replicate.presence > 0) {
    replicates.sum <- replicates %>%
      dplyr::group_by(INDIVIDUALS) %>%
      dplyr::summarise(
        TOTAL = sum(TOTAL),
        NO_RADTAG = sum(NO_RADTAG),
        LOW_QUALITY = sum(LOW_QUALITY),
        RETAINED = sum(RETAINED)
      ) %>%
      dplyr::mutate(
        INDIVIDUALS_REP = stringi::stri_join(INDIVIDUALS, "-R"),
        LANES = rep("multiple", n()),
        LANES_SHORT = rep("multiple", n()),
        BARCODES = rep("multiple", n()),
        FQ_FILES = stringi::stri_join(INDIVIDUALS_REP, ".fq.gz"),
        REPLICATES = rep("R", n())
      )

    replicate.individual <- unique(replicates$INDIVIDUALS)

    message("Replicate individuals: ", length(replicate.individual))

    # combine fq files of replicates ---------------------------------------------
    message("Combining replicates...")
    combine_replicates_fq <- function(replicate.individual, replicates) {
      # replicate.individual <- "TA-BAF-001"

      # isolate the replicates
      rep.info <- dplyr::filter(replicates, INDIVIDUALS == replicate.individual)

      # isolate the first replicates
      rep1.fq <- dplyr::filter(rep.info, REPLICATES == 1)
      rep1.fq.path <- stringi::stri_join(o, "/", rep1.fq$FQ_FILES)

      # Create a new fq
      new.fq.path <- stringi::stri_join(o, "/", rep1.fq$INDIVIDUALS, "-R", ".fq.gz")
      file.create(new.fq.path)

      # get the fq to combined in a vector
      fq.files.to.combined <- rep.info$FQ_FILES
      # fq.files.to.combined

      combine_all_rep <- function(fq.files.to.combined, new.fq.path) {
        # fq.files.to.combined <- "HOM-NORTH-BRA-14-1.fq.gz"
        fq <- stringi::stri_join(o, "/", fq.files.to.combined)
        # fq
        file.append(file1 = new.fq.path, file2 = fq)
      }

      purrr::walk(.x = fq.files.to.combined,
                  .f = combine_all_rep, new.fq.path = new.fq.path)
    }

    purrr::walk(.x = replicate.individual,
                .f = combine_replicates_fq, replicates = replicates)

    # combine replicate sum with project.info
    # project.info.file$REPLICATES <- as.character(project.info.file$REPLICATES)

    project.info.file <- dplyr::bind_rows(project.info.file, replicates.sum) %>%
      dplyr::arrange(INDIVIDUALS, INDIVIDUALS_REP)

    message("In project info file:
    replicates have integer (e.g. id-1, id-2, etc.) appended to the original name
    combined replicates have \"-R\" appended to the original name")
  } else {
    message("Replicate individuals: 0")
  }

  # Add SQL_ID column for ustacks ----------------------------------------------
  project.info.file.sqlid <- project.info.file %>%
    dplyr::arrange(INDIVIDUALS_REP) %>%
    dplyr::mutate(
      SQL_ID = seq(1, n()),
    )
  message("Updating info file with SQL ID")

  # With Amazon
  # project.info.file.sqlid <- project.info.file.sqlid %>%
  #   dplyr::mutate(
  #     INSTANCE_NUMBER = factor(
  #       cut(x = 1:n(), breaks = instance.number, labels = FALSE))
  #   )
  new.info.file.name <- stringi::stri_join("02_project_info/project.info.", file.date, ".tsv")
  readr::write_tsv(project.info.file.sqlid, new.info.file.name)
  message("New project info, see: ", new.info.file.name)
  timing <- proc.time() - timing
  message("\nComputation time: ", round(timing[[3]]), " sec")
  cat("############################## completed ##############################\n")
  res <- list(project.info = project.info.file.sqlid,
              sample.per.lanes = sample.per.lanes)
  return(res)
} #End run_process_radtags
