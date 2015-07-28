if(!require("stringr")) install.packages("stringr", repos="http://cran.rstudio.com")
template <- readLines("WebTechnologies.ctv")
pattern <- "pkg>[A-Za-z0-9]+|pkg>[A-Za-z0-9]+\\.[A-Za-z0-9]+|pkg>[A-Za-z0-9]+\\.[A-Za-z0-9]+\\.[A-Za-z0-9]+"
out <- paste0(template, collapse = " ")
pkgs <- stringr::str_extract_all(out, pattern)[[1]]
pkgs <- unique(gsub("^pkg>", "", pkgs))
priority <- c('httr','RCurl','jsonlite','shiny','XML')
pkgs <- pkgs[ !pkgs %in% priority] # remove priority packages
pkgs <- lapply(as.list(sort(pkgs)), function(x) list(package=x))
output <- 
c(paste0('<CRANTaskView>
  <name>WebTechnologies</name>
  <topic>Web Technologies and Services</topic>
  <maintainer email="scott@ropensci.org">Scott Chamberlain, Thomas Leeper, Patrick Mair, Karthik Ram, Christopher Gandrud</maintainer>
  <version>',Sys.Date(),'</version>'), 
  '  <info>',
  paste0("    ",template), 
  '  </info>',
  '  <packagelist>',
  # list priority packages explicitly
  paste0('    <pkg priority="core">', priority, '</pkg>', collapse = "\n"),
  # add all other packages from `pkgs`
  paste0('    <pkg>', unlist(unname(pkgs)), '</pkg>', collapse = "\n"),
  '  </packagelist>',
  '  <links>',
  '    <a href="https://github.com/ropensci/opendata">Open Data TaskView</a>',
  '  </links>',
  '</CRANTaskView>')

writeLines(output, "WebTechnologies.ctv")