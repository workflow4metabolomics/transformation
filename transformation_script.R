## Etienne Thevenot
## W4M Core Development Team
## etienne.thevenot@cea.fr
## 2015-04-25

transformF <- function(datMN,
                       metC) {

    ## options

    optStrAsFacL <- options()[["stringsAsFactors"]]
    options(stringsAsFactors = FALSE)

    ## transformation

    switch(metC,
           log10 = {

               cat("\n'log10' transformation\n", sep="")

               if(length(which(datMN < 0)))
                   stop("The 'dataMatrix' contains negative values")

               zerMN <- datMN == 0

               ## Number of missing values
               nasN <- length(which(is.na(datMN)))
               cat("\nMissing values in the 'dataMatrix': ",
                   nasN,
                   " (",
                   round(nasN / cumprod(dim(datMN))[2] * 100),
                   "%)\n",
                   sep="")

               ## Number of zero values
               zerN <- length(which(zerMN))
               cat("\nZero values in the 'dataMatrix': ",
                   zerN,
                   " (",
                   round(zerN / cumprod(dim(datMN))[2] * 100),
                   "%)\n",
                   sep="")

               trfMN <- log10(1 + datMN)

           }) ## end of 'log10' method


    ## returning

    options(stringsAsFactors=optStrAsFacL)

    return(trfMN)

} ## end of transformF
