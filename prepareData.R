require(ggplot2)

excelfilter <- matrix(c("Excel", "*.xls*"), ncol=2)

ingestvo2 <- function(afilename) {
  require(readxl)
  require(gdata)
  parts <- unlist(strsplit(basename(afilename)," "))
  columns <- data.frame("subj" = as.numeric(parts[1]),
                        "testnumber" = as.numeric(parts[2]),
                        "testdate" = as.Date(parts[3],format="%m%d%y")
                        ) 
  obsvo2 <- read_excel(afilename, sheet=1, skip=4, col_names=FALSE)
  names(obsvo2) <- trim(names(read_excel(afilename, sheet=1, skip=2, col_names=TRUE)))
  obsvo2$interval <- 0:(nrow(obsvo2) - 1)
  return(cbind(columns,obsvo2))
}


list_of_data_frames <- lapply(choose.files(filters = excelfilter,
                                          caption = "Select VO2 files to combine"), 
                              FUN=ingestvo2)

vo2 <- do.call('rbind', list_of_data_frames)

manualmeasures <- read_excel(choose.files(filters = excelfilter,
                               multi = FALSE,
                               caption = "Select the manual measures file"))

vo2data <- merge(vo2, manualmeasures, 
                 by.x=c("subj","testnumber"), 
                 by.y=c("Subject","Test Number"), 
                 all.x=TRUE)

vo2data$subj = as.factor(vo2data$subj)


cursubj <- "123456"

ggplot(data=subset(vo2data,subj==cursubj), aes(x=HR, y=Rel.VO2, col=subj)) + 
       geom_point() + 
       geom_smooth() +
       ggtitle(paste("Rel.VO2 ~ Heartrate for subject",cursubj))


ggplot(data=subset(vo2data,subj==cursubj), aes(x=HR, y=`%Fat`,col="Fat")) + 
       geom_point() + 
       geom_smooth() +
       geom_point(aes(x=HR,y=`%Carbs`,col="Carbs")) + 
       geom_smooth(aes(x=HR,y=`%Carbs`,col="Carbs")) + 
       ylab("Calorie source (%)") +
       ggtitle(paste("crossover for subject",cursubj))


