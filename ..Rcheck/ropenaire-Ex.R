pkgname <- "ropenaire"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('ropenaire')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("roa_projects")
### * roa_projects

flush(stderr()); flush(stdout())

### Name: roa_projects
### Title: Get EC projects
### Aliases: roa_projects

### ** Examples

roa_projects(org = "UGOE")



### * <FOOTER>
###
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
