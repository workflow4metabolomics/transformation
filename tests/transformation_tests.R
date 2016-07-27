library(RUnit)

wrapperF <- function(argVc) {

        source("../transformation_script.R")


#### Start_of_testing_code <- function() {}


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

topEnvC <- environment()
flagC <- "\n"

## functions
##----------

flgF <- function(tesC,
                 envC = topEnvC,
                 txtC = NA) { ## management of warning and error messages

    tesL <- eval(parse(text = tesC), envir = envC)

    if(!tesL) {

        sink(NULL)
        stpTxtC <- ifelse(is.na(txtC),
                          paste0(tesC, " is FALSE"),
                          txtC)

        stop(stpTxtC,
             call. = FALSE)

    }

} ## flgF

## log file
##---------

sink(argVc[["information"]])

cat("\nStart of the '", modNamC, "' module: ",
    format(Sys.time(), "%a %d %b %Y %X"), "\n", sep="")

## loading
##--------

datMN <- t(as.matrix(read.table(argVc[["dataMatrix_in"]],
                                check.names = FALSE,
                                header = TRUE,
                                row.names = 1,
                                sep = "\t")))

metC <- argVc[["method"]]

## checking
##---------

flgF("metC %in% metVc", txtC = paste0("Transformation method must be either '", paste(metVc, collapse = "', '"), "'"))


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
            file = argVc[["dataMatrix_out"]],
            quote = FALSE,
            row.names = FALSE,
            sep = "\t")

## ending
##-------

cat("\nEnd of the '", modNamC, "' Galaxy module call: ",
    format(Sys.time(), "%a %d %b %Y %X"), "\n", sep = "")

sink()

options(stringsAsFactors = strAsFacL)


#### End_of_testing_code <- function() {}


    return(list(datDF = datDF))

    rm(list = ls())

}

exaDirOutC <- "output"
file.exists(exaDirOutC) || dir.create(exaDirOutC)

tesArgLs <- list(input_log10 = c(method = "log10",
                     .chkC = "checkEqualsNumeric(outLs[['datDF']]['HMDB03072', 'HU_021'], 4.817089, tolerance = 1e-6)"))

for(tesC in names(tesArgLs))
    tesArgLs[[tesC]] <- c(tesArgLs[[tesC]],
                          dataMatrix_in = file.path(unlist(strsplit(tesC, "_"))[1], "dataMatrix.tsv"),
                          dataMatrix_out = file.path(exaDirOutC, "dataMatrix.tsv"),
                          information = file.path(exaDirOutC, "information.txt"))

for(tesC in names(tesArgLs)) {
    print(tesC)
    outLs <- wrapperF(tesArgLs[[tesC]])
    if(".chkC" %in% names(tesArgLs[[tesC]]))
        stopifnot(eval(parse(text = tesArgLs[[tesC]][[".chkC"]])))
}

message("Checks successfully completed")
