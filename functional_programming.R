new_counter <- function(n = 1, i = 1) {
  first <- TRUE
  start = n
  
  # list of functions returned in closure
  list(
    reset = function(){
      n <<- start
      first <<- TRUE
    },
    
    getnext = function() {
      if (first) {
        first <<- FALSE
        return(n)
      }
      n <<- n + i
      return(n)
    }
  )
}

