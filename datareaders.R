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

# Predictors/covariates?
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
# https://www.r-bloggers.com/r-tutorial-series-one-way-repeated-measures-anova/
# In a repeated measures ANOVA, we instead treat each level of our independent variable
# as if it were a variable, thus placing them side by side as columns. Hence, rather
# than having one vertical column for voting interest, with a second column for age, 
# we have three separate columns for voting interest, one for each age level



# Tukey's HSD 


