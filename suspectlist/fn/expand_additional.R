expand_additional <- function(slist) {
  add <- slist$ADDITIONAL
  i <- 0
  add_list <- lapply(add, function(x) matrix(unlist(strsplit(sub(":", "::", unlist(strsplit(x, ";"))), split = "::")), ncol = 2, byrow = TRUE))
  columns <- unique(unlist(lapply(add_list, function(x) x[,1])))
  columns <- columns[which(!is.na(columns))]
  add_df <- do.call(cbind, lapply(columns, function(x) sapply(1:length(add_list), function(y) {o <- add_list[[y]][which(add_list[[y]][,1] == x),2]; if (length(o) == 0) {o <- NA}; o})))
  colnames(add_df) <- columns
  cbind(slist, add_df)
}