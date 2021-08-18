get_suspectlist <- function(destfile = paste("PFAS Suspect List", Sys.Date(), ".xlsx", sep = "")) {
  url <- "https://data.nist.gov/od/ds/mds2-2387/PFAS%20Suspect%20List_v1_2.xlsx"
  download.file(url, destfile, mode = "wb")
  if (file.exists(destfile)) {
    print(paste("The PFAS Suspect List has been successfully downloaded to", destfile))
  }
}