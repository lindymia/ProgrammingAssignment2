## Usage example:

## Initialise matrix.
# > x <- matrix(1:4, nrow=2, ncol=2)
## Set matrix and inverse matix.
# > m <- makeCacheMatrix(x)
## Computes and print the inverse of the matrix returned by makeCacheMatrix() 
# > s <- cacheSolve(m)
# > print(s)
#      [,1] [,2]
# [1,]   -2  1.5
# [2,]    1 -0.5
## Retrieve and print the inverse from the cache since the inverse of the matrix has been been 
## calculated (and the matrix has not changed).  Seeing message "Getting cached data." 
## showed that the matrix was retrieved from the matrix.  
# > s <- cacheSolve(m)
# Getting cached data.
# > print(s)
#      [,1] [,2]
# [1,]   -2  1.5
# [2,]    1 -0.5

## makeCacheMatrix creates a matrix object that can cache its inverse.  This 
## function does the following.
# 1. Set value of the matrix.
# 2. Get value of the matrix.
# 3. Set value of inverse of the matrix.
# 4. Get value of inverse of the matrix.
makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    # Store matrix x in memory.  Inverse is NULL.
    set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  # Get matrix from memory and return.
  get <- function() x
  # Set matrix of inverse.
  setinverse <- function(inverse) inv <<- inverse
  # Get matrix of inverse.
  getinverse <- function() inv
  # Return list of set and get functions.
  list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}


## The following function computes the inverse of the matrix returned by makeCacheMatrix.  
## If the inverse has already been calculated (and the matrix has not changed), then the 
## cacheSolve() should retrieve the inverse from the cache.
cacheSolve <- function(x, ...) {
  # Get inverse matrix.
  inv <- x$getinverse()
  # If inverse matrix is not NULL then return stored value.
  if(!is.null(inv)) {
    message("Getting cached data.")
    return(inv)
  }
  # If inverse was not cacluated, calculate, store and return. 
  data <- x$get()
  inv <- solve(data)
  x$setinverse(inv)
  inv
}
