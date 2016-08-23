require(ggplot2)

ingestvo2 <- function(afilename) {
  require(readxl)
  require(gdata)
  parts <- unlist(strsplit(basename(afilename)," "))
  columns <- data.frame("subj" = parts[1],
                        "testnumber" = parts[2],
                        "testdate" = as.Date(parts[3],format="%m%d%y")
                        )
  obsvo2 <- read_excel(afilename, sheet=1, skip=4, col_names=FALSE)
  names(obsvo2) <- trim(names(read_excel(afilename, sheet=1, skip=2, col_names=TRUE)))
  return(cbind(columns,obsvo2))
}

excelfilter <- matrix(c("Excel", "*.xls*"), ncol=2)

# vo2filenames <- choose.files(filters=excelfilter)
# compfilenames <- choose.files(filters=excelfilter)

# list_of_data_frames <- lapply(vo2filenames, FUN=ingestvo2)

# vo2 <- do.call('rbind', list_of_data_frames)

# ggplot(data=vo2, aes(x=HR, y=Rel.VO2, col=subj)) + geom_point() + facet_wrap(~ subj) + geom_smooth()