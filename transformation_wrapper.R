#!/usr/bin/Rscript --vanilla --slave --no-site-file


library(batch) ## necessary for parseCommandArgs function
args = parseCommandArgs(evaluate=FALSE)
## interpretation of arguments given in command line as an R list of objects

source_local <- function(fname){
    argv <- commandArgs(trailingOnly = FALSE)
    base_dir <- dirname(substring(argv[grep("--file=", argv)], 8))
    source(paste(base_dir, fname, sep="/"))
}

## Import the different functions
source_local("transformation_script.R")


##----------------
## Example
##----------------

runExampleL <- FALSE

if(runExampleL) { ## example of arguments

    ## prefix file in
    pfxFilInpC <- "data/input/sacuri_"                       ## 'sacuri'
    ## pfxFilInpC <- gsub("sacuri", "suvimax", pfxFilInpC)   ## 'suvimax'
    ## pfxFilInpC <- gsub("sacuri", "bisphenol", pfxFilInpC) ## 'bisphenol'

    argLs <- list(dataMatrix_in = paste0(pfxFilInpC, "dataMatrix.tsv"),
                  method = c("log10")[1])

    ## prefix file out
    pfxFilOutC <- gsub("input", "output",
                       gsub("dataMatrix.tsv", "", argLs[["dataMatrix_in"]]))
    ## "output/sacuri_"

    argLs <- c(argLs,
               list(dataMatrix_out = paste0(pfxFilOutC, "dataMatrix.tsv"),
                    information = paste0(pfxFilOutC, "information.txt")))

    stopifnot(file.exists("data/output"))

} else {

    argLs <- parseCommandArgs(evaluate=FALSE)

}


##----------------
## Script
##----------------

## options

strAsFacL <- options()[["stringsAsFactors"]]
options(stringsAsFactors=FALSE)

## constants

metVc <- c("log10") ## available methods

## starting

sink(argLs[["information"]])

cat("\nStarting the 'Transformation' module: ",
    format(Sys.time(), "%a %d %b %Y %X"), "\n", sep="")

## loading

datMN <- t(as.matrix(read.table(argLs[["dataMatrix_in"]],
                                check.names = FALSE,
                                header = TRUE,
                                row.names = 1,
                                sep = "\t")))

metC <- argLs[["method"]]

if(!(metC %in% c("log10"))) {
    cat("Transformation method must be in: '", paste(metVc, collapse = "', '"), "'", sep="")
    sink()
    stop("See error above")
}

## script

datMN <- transformF(datMN=datMN, ## dataMatrix
                    metC=metC)  ## transformation method

## saving

datDF <- cbind.data.frame(dataMatrix = colnames(datMN),
                          as.data.frame(t(datMN)))
write.table(datDF,
            file = argLs[["dataMatrix_out"]],
            quote = FALSE,
            row.names = FALSE,
            sep = "\t")

## ending

cat("\nEnd of 'Transformation' Galaxy module call: ",
    format(Sys.time(), "%a %d %b %Y %X"), "\n", sep = "")

sink(NULL)

options(stringsAsFactors = strAsFacL)

rm(list = ls())
