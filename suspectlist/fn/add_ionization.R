add_ionization <- function(slist, ionstate = c("M-H", "M-H2O+H", "M+H", "M+K", "M+Na" )) {
  H_plus = 1.0072767
  Na_plus = 22.9892213
  K_plus = 38.9631585
  H2O = 18.01056
  ionstate <- sort(ionstate)
  possible_states <- c("M-H", "M-H2O+H", "M+H", "M+K", "M+Na" )
  if (length(which(ionstate %in% possible_states)) != length(ionstate)) {return("Those are not acceptable ion states.")}
  masses <- slist$FIXEDMASS
  netcharge <- slist$NETCHARGE
  ionized <- data.frame(masses)
  if ("M-H" %in% ionstate) {
    ionized <- cbind(ionized, "M-H_mass" = masses - (netcharge + 1)*H_plus, "M-H_state" = paste("M-", (netcharge + 1), "H", sep = ""))
  }
  if ("M+H" %in% ionstate) {
    ionized <- cbind(ionized, "M+H_mass" = masses + (-netcharge + 1)*H_plus, "M+H_state" = paste("M+", (-netcharge + 1), "H", sep = ""))
  }
  if ("M+Na" %in% ionstate) {
    ionized <- cbind(ionized, "M+Na_mass" = masses + (-netcharge + 1)*Na_plus, "M+Na_state" = paste("M+", (-netcharge + 1), "Na", sep = ""))
  }
  if ("M+K" %in% ionstate) {
    ionized <- cbind(ionized, "M+K_mass" = masses + (-netcharge + 1)*K_plus, "M+K_state" = paste("M+", (-netcharge + 1), "K", sep = ""))
  }
  if ("M-H2O+H" %in% ionstate) {
    ionized <- cbind(ionized, "M-H2O+H_mass" = masses - H2O + (-netcharge + 1)*H_plus, "M-H2O+H_state" = paste("M-H2O+", (-netcharge + 1), "H", sep = ""))
  }
  ionized <- ionized[,-1]
  cbind(slist, ionized)
}