#' Expands properties from the suspect list ADDITIONAL column
#' 
#' Gets all listed properties in the suspect list ADDITIONAL column
#' And adds the values as additional columns.
#' 
#' @param slist data frame from the open_suspectlist function
#' 
#' @return data frame with all additional information expanded.
#' 
#' #' @example 
#' slist <- open_suspectlist()
#' slist_expanded <- expand_additional(slist)

expand_additional <- function(slist) {
  add <- slist$ADDITIONAL
  i <- 0
  add_list <- lapply(add, function(x) reshape_additional(x))
  columns <- unique(unlist(lapply(add_list, function(x) x[,1])))
  columns <- columns[which(!is.na(columns) & columns != "NA")]
  add_df <- do.call(cbind, lapply(columns, function(x) do.call(c, lapply(1:length(add_list), function(y) {o <- paste(add_list[[y]][which(add_list[[y]][,1] == x),2], collapse = ";"); if (length(o) == 0) {o <- NA}; o}))))
  add_df <- as.data.frame(add_df)
  colnames(add_df) <- columns
  cbind(slist, add_df)
}

reshape_additional <- function(add) {
  if (is.null(add)) {return(data.frame(matrix(NA, ncol = 2, nrow = 1)))}
  if (add[1] == "") {return(data.frame(matrix(NA, ncol = 2, nrow = 1)))}
  x <- unlist(strsplit(add, split = ";"))
  x <- unlist(lapply(x, function(y) unlist(strsplit(sub(":", "::", y), split = "::"))))
  data.frame(matrix(x, ncol = 2, byrow = TRUE))
}