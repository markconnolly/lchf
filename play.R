require(readxl)


vo2datafile <- file.choose()
obsvo2 <- read_excel(vo2datafile, sheet=1, skip=4, col_names=FALSE)
names(obsvo2) <- trim(names(read_excel(vo2datafile, sheet=1, skip=2, col_names=TRUE)))
obsvo2[!is.na(obsvo2$Mark),]

obsvo2$point <- 0:(nrow(obsvo2)-1)

max(predict(loess(Rel.VO2 ~ point, data=obsvo2)))

max(predict(loess(Rel.VO2 ~ HR, data=obsvo2)))


require(ggplot2)
ggplot(obsvo2, aes(HR, Rel.VO2)) + geom_point() + geom_smooth(method = "loess")

obsvo2[with(obsvo2, Mark == "RER=0.85" & !is.na(Mark)),]
