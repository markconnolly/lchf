vo2filenames <- choose.files(filters=matrix(c("Excel", "*.xls*")))
compfilenames <- choose.files(filters=matrix(c("Excel", "*.xls*")))

ingestvo2 <- function(afilename) {
  require(readxl)
  parts <- unlist(strsplit(basename(afilename)," "))
  columns <- data.frame("subj" = parts[1],
                        "testnumber" = parts[2],
                        "testdate" = as.Date(parts[3],format="%m%d%y")
                        )
  obsvo2 <- read_excel(afilename, sheet=1, skip=4, col_names=FALSE)
  names(obsvo2) <- trim(names(read_excel(vo2datafile, sheet=1, skip=2, col_names=TRUE)))
  return(cbind(columns,obsvo2))
}
