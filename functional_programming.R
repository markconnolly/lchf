counter_factory <- function(x = 0, inc = 1) {
    first <- TRUE
    function() {
      if (first) {
        first <<- FALSE
        return(x)
      }
      x <<- x + inc
      return(x)
    }
  }