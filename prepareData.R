require(ggplot2)
require(readxl)
require(gdata)
require(tidyr)
require(knitr)

citPkgs <- c(names(sessionInfo()$otherPkgs), "base") 

write_bib(citPkgs, file="lchf.bib")

excelfilter <- matrix(c("Excel", "*.xls*"), ncol=2)

ingestvo2 <- function(afilename) {
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

fuel <- subset(vo2data, subj==cursubj)[,c("%Fat","%Carbs","HR", "Rel.VO2")]
fuel_long <- gather(fuel, percentage, `%KCal / min`, c(`%Fat`,`%Carbs`))

fatfromhrloess <- 
  loess(data=fuel[order(fuel$HR),], `%Fat` ~ HR)
predictedfat <- 
  data.frame(HR=c(min(fuel$HR):max(fuel$HR)))
predictedfat$fat <- 
  predict(loess(data=fuel,`%Fat` ~ HR), 
          newdata = predictedfat)
crossover <- 
  predictedfat$HR[which.min(abs(predictedfat$fat - 50))]


ggplot(data=fuel_long,aes(x=HR,y=`%KCal / min`,colour=percentage)) + 
  geom_point() + 
  geom_smooth() +
  geom_vline(xintercept = hrat50) +
  ggtitle(paste("crossover for subject",subject)) + 
  geom_vline(xintercept = crossover) +
  geom_label(x=crossover, y=labely, label=paste("predicted HR at 50%",crossover,"bpm"))

  




ggplot(data=hr, aes(x=HR, y=Rel.VO2)) + 
       geom_point() + 
       geom_smooth() +
       ggtitle(paste("Rel.VO2 ~ Heartrate for subject",cursubj))

labely <- max(hr$fat) - mean(hr$fat)/2

ggplot(data=hr, aes(x=HR, y=fat, col="Fat")) + 
       geom_point() + 
       geom_smooth() +
       geom_point(aes(x=HR,y=carbs,col="Carbs")) + 
       geom_smooth(aes(x=HR,y=carbs,col="Carbs")) + 
       #ylab("%KCal / min") +
       ggtitle(paste("crossover for subject",cursubj)) + 
       geom_vline(xintercept = crossover) +
       geom_label(x=crossover, y=labely, label=paste("predicted HR at 50%\n",round(crossover),"bpm"))


