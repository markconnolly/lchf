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
