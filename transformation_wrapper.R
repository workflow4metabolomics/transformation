#!/usr/bin/Rscript --vanilla --slave --no-site-file


library(batch) ## parseCommandArgs

source_local <- function(fname){
    argv <- commandArgs(trailingOnly = FALSE)
    base_dir <- dirname(substring(argv[grep("--file=", argv)], 8))
    source(paste(base_dir, fname, sep="/"))
}

source_local("transformation_script.R")



rssVsGalL <- FALSE

if(rssVsGalL) { ## for running with R outside the Galaxy environment during development of the script

    ## 'example' input dir
    exaDirInpC <- "example/input"

    argLs <- list(dataMatrix_in = file.path(exaDirInpC, "dataMatrix.tsv"),
                  method = c("log2", "log10")[1])

    ## 'example' output dir
    exaDirOutC <- gsub("input", "output", exaDirInpC)

    argLs <- c(argLs,
               list(dataMatrix_out = file.path(exaDirOutC, "dataMatrix.tsv"),
                    information = file.path(exaDirOutC, "information.txt")))

    stopifnot(file.exists(exaDirOutC))

} else
    argLs <- parseCommandArgs(evaluate=FALSE)


##------------------------------
## Initializing
##------------------------------

## options
##--------

strAsFacL <- options()[["stringsAsFactors"]]
options(stringsAsFactors=FALSE)

## constants
##----------

modNamC <- "Transformation" ## module name
metVc <- c("log2", "log10") ## available methods

## log file
##---------

sink(argLs[["information"]])

cat("\nStart of the '", modNamC, "' module: ",
    format(Sys.time(), "%a %d %b %Y %X"), "\n", sep="")

## loading
##--------

datMN <- t(as.matrix(read.table(argLs[["dataMatrix_in"]],
                                check.names = FALSE,
                                header = TRUE,
                                row.names = 1,
                                sep = "\t")))

metC <- argLs[["method"]]

## checking
##---------

if(!(metC %in% metVc)) {
    cat("Transformation method must be either '", paste(metVc, collapse = "', '"), "'\n", sep="")
    sink()
    stop("See error above")
}


##------------------------------
## Computation
##------------------------------


datMN <- transformF(datMN = datMN, ## dataMatrix
                    metC = metC)  ## transformation method


##------------------------------
## Ending
##------------------------------


## saving
##-------

datDF <- cbind.data.frame(dataMatrix = colnames(datMN),
                          as.data.frame(t(datMN)))
write.table(datDF,
            file = argLs[["dataMatrix_out"]],
            quote = FALSE,
            row.names = FALSE,
            sep = "\t")

## ending
##-------

cat("\nEnd of the '", modNamC, "' Galaxy module call: ",
    format(Sys.time(), "%a %d %b %Y %X"), "\n", sep = "")

sink()

options(stringsAsFactors = strAsFacL)

rm(list = ls())
