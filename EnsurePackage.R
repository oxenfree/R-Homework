EnsurePackage <- function(x) {
  x <- as.character(x)
  
  if (!require(x, character.only = T)) {
    install.packages(pkgs = x, repos = "http://cran.r-project.org")
    require(x, character.only = T)
  }
}