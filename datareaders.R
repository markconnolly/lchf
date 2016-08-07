rbind.read.csvs <- function(fnames, ...) { 
  # rbinds a collection of files into a data frame
  #
  # Args:
  #   fnames: A vector of file names.
  #
  # Returns:
  #   a data frame with data from all the files
  #
  #
  # example
  #     directory="."
  #     id=1:332
  #     fnames <- paste(directory,"/",sprintf("%03d", id),".csv",sep="")
  #     pollutants <- rbind.read.csvs(fnames)
  
  list_of_data_frames <- lapply(fnames, FUN=read.csv, ...)   
  
  return(do.call('rbind', list_of_data_frames))
}

# Predictors
#     HR heart rate
#     VO₂ max
#     height
#     weight
#     fat mass
#     lean mass
#     fat:lean
#     gender
#     age
#     RPE

# Responses
# FA oxidation rate
# body composition (body fat percentage)
# mood
# metabolic indices
#     ME (metabolic efficiency) point (switch from FA to CHO)
#     RER (respiratory exchange ratio) proxy for ME point (hyp: reached at higher HR)
#     65% VO₂  max is peak fat burning
#     RPE (Borg Rating Perceived Exertion) (hyp: increase at each stage)
#     body composition (hyp: fat:lean mass declines) 
#     VO₂  max
#     mood return to baseline

# Repeated measures one-way anova
# Tukey's HSD 