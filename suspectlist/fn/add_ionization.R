add_ionization <- function(slist, ionstate = c("M-H", "M-H2O+H", "M+H", "M+K", "M+Na", "M+NH4")) {
  H_plus = 1.0072767
  Na_plus = 22.9892213
  K_plus = 38.9631585
  H2O = 18.01056
  NH4 = 18.0338
  ionstate <- sort(ionstate)
  possible_states <- c("M-H", "M-H2O+H", "M+H", "M+K", "M+Na", "M+NH4")
  if (length(which(ionstate %in% possible_states)) != length(ionstate)) {return("Those are not acceptable ion states.")}
  masses <- slist$FIXEDMASS
  netcharge <- slist$NETCHARGE
  ionized <- data.frame(masses)
  if ("M-H" %in% ionstate) {
    ionized <- cbind(ionized, "M-H_mz" = masses - (netcharge + 1)*H_plus, "M-H_state" = paste("M-", (netcharge + 1), "H", sep = ""), "M-H_FORMULA" = sapply(1:nrow(slist), function(x) ionize_formula(slist$FORMULA[x], adduct = "-H", deltachange = netcharge[x] + 1)))
  }
  if ("M+H" %in% ionstate) {
    ionized <- cbind(ionized, "M+H_mz" = masses + (-netcharge + 1)*H_plus, "M+H_state" = paste("M+", (-netcharge + 1), "H", sep = ""), "M+H_FORMULA" = sapply(1:nrow(slist), function(x) ionize_formula(slist$FORMULA[x], adduct = "+H", deltachange = -netcharge[x] + 1)))
  }
  if ("M+Na" %in% ionstate) {
    ionized <- cbind(ionized, "M+Na_mz" = masses + (-netcharge + 1)*Na_plus, "M+Na_state" = paste("M+", (-netcharge + 1), "Na", sep = ""), "M+Na_FORMULA" = sapply(1:nrow(slist), function(x) ionize_formula(slist$FORMULA[x], adduct = "+Na", deltachange = -netcharge[x] + 1)))
  }
  if ("M+K" %in% ionstate) {
    ionized <- cbind(ionized, "M+K_mz" = masses + (-netcharge + 1)*K_plus, "M+K_state" = paste("M+", (-netcharge + 1), "K", sep = ""), "M+K_FORMULA" = sapply(1:nrow(slist), function(x) ionize_formula(slist$FORMULA[x], adduct = "+K", deltachange = -netcharge[x] + 1)))
  }
  if ("M-H2O+H" %in% ionstate) {
    ionized <- cbind(ionized, "M-H2O+H_mz" = masses - H2O + (-netcharge + 1)*H_plus, "M-H2O+H_state" = paste("M-H2O+", (-netcharge + 1), "H", sep = ""), "M-H2O+H_FORMULA" = sapply(1:nrow(slist), function(x) ionize_formula(slist$FORMULA[x], adduct = "-H2O+H", deltachange = -netcharge[x] + 1)))
  }
  if ("M+NH4" %in% ionstate) {
    ionized <- cbind(ionized, "M+NH4_mz" = masses + (-netcharge + 1)*NH4, "M+NH4_state" = paste("M+", (-netcharge + 1), "NH4", sep = ""), "M+NH4_FORMULA" = sapply(1:nrow(slist), function(x) ionize_formula(slist$FORMULA[x], adduct = "+NH4", deltachange = -netcharge[x] + 1)))
  }
  ionized <- ionized[,-1]
  cbind(slist, ionized)
}

extract_elements <- function(composition.str) {
  single.elem <- gregexpr("[A-Z]", composition.str)[[1]]
  double.elem <- gregexpr("[A-Z][a-z]", composition.str)[[1]]
  single.elem <- single.elem[! single.elem %in% double.elem]
  if (length(single.elem) > 0) {
    elements <- substring(composition.str, single.elem, single.elem)
  }
  if (double.elem[1] != -1) {
    elements <- c(elements, substring(composition.str, double.elem, double.elem + 1))
  }
  ecounts <- rep(1, length(elements))
  nums <- gregexpr("[0-9]+", composition.str)[[1]]
  nums.count <- attr(nums, "match.length")
  for (i in 1:length(nums)) {
    if (substr(composition.str, nums[i] - 1, nums[i] - 1) %in% elements) {
      ecounts[which(elements == substr(composition.str, nums[i] - 1, nums[i] - 1))] <- substr(composition.str, nums[i], nums[i] + nums.count[i] - 1)
    }
    if (substr(composition.str, nums[i] - 2, nums[i] - 1) %in% elements) {
      ecounts[which(elements == substr(composition.str, nums[i] - 2, nums[i] - 1))] <- substr(composition.str, nums[i], nums[i] + nums.count[i] - 1)
    }
  }
  results <- c()
  results$elements <- elements
  results$counts <- as.integer(ecounts)
  results
}

collapse_ecomp <- function(ecomp) {
  if (length(ecomp$elements) == 0) {return(NA)}
  paste(sapply(1:length(ecomp$elements), function(x) {if (ecomp$counts[x] > 0) {o <- paste(ecomp$elements[x], ecomp$counts[x], sep = "")}; if (ecomp$counts[x] <= 0) {o <- ""}; o}), collapse = "")
}

ionize_formula <- function(formula, adduct = "+H", deltachange = 1) {
  possible_adducts = c("+H", "-H", "+K", "+NH4", "-H2O+H", "+Na")
  if (!adduct %in% possible_adducts) {return("FORMULA_ERROR")}
  if (deltachange == 0) {return(formula)}
  elist <- extract_elements(formula)
  if (adduct == "+H") {
    if ("H" %in% elist$elements) {
      elist$counts[which(elist$elements == "H")] <- elist$counts[which(elist$elements == "H")] + deltachange
    }
    if (!"H" %in% elist$elements) {
      elist$elements <- c(elist$elements, "H")
      elist$counts <- c(elist$counts, deltachange)
    }
  }
  if (adduct == "-H") {
    if ("H" %in% elist$elements) {
      elist$counts[which(elist$elements == "H")] <- elist$counts[which(elist$elements == "H")] - deltachange
    }
    if (!"H" %in% elist$elements) {
      return("FORMULA_ERROR")
    }
  }
  if (adduct == "+Na") {
    if ("Na" %in% elist$elements) {
      elist$counts[which(elist$elements == "Na")] <- elist$counts[which(elist$elements == "Na")] + deltachange
    }
    if (!"Na" %in% elist$elements) {
      elist$elements <- c(elist$elements, "Na")
      elist$counts <- c(elist$counts, deltachange)
    }
  }
  if (adduct == "+K") {
    if ("K" %in% elist$elements) {
      elist$counts[which(elist$elements == "K")] <- elist$counts[which(elist$elements == "K")] + deltachange
    }
    if (!"K" %in% elist$elements) {
      elist$elements <- c(elist$elements, "K")
      elist$counts <- c(elist$counts, deltachange)
    }
  }
  if (adduct == "+NH4") {
    if ("N" %in% elist$elements & "H" %in% elist$elements) {
      elist$counts[which(elist$elements == "N")] <- elist$counts[which(elist$elements == "N")] + deltachange
      elist$counts[which(elist$elements == "H")] <- elist$counts[which(elist$elements == "H")] + 4*deltachange
    }
    if ("N" %in% elist$elements & !"H" %in% elist$elements) {
      elist$counts[which(elist$elements == "N")] <- elist$counts[which(elist$elements == "N")] + deltachange
      elist$elements <- c(elist$elements, "H")
      elist$counts <- c(elist$counts, 4*deltachange)
    }
    if (!"N" %in% elist$elements & "H" %in% elist$elements) {
      elist$counts[which(elist$elements == "H")] <- elist$counts[which(elist$elements == "H")] + 4*deltachange
      elist$elements <- c(elist$elements, "N")
      elist$counts <- c(elist$counts, deltachange)
    }
  }
  if (adduct == "-H2O+H") {
    if ("O" %in% elist$elements & "H" %in% elist$elements) {
      if (elist$counts[which(elist$elements == "H")] < 2) {return("FORMULA_ERROR")}
      if (elist$counts[which(elist$elements == "O")] < 1) {return("FORMULA_ERROR")}
      elist$counts[which(elist$elements == "O")] <- elist$counts[which(elist$elements == "O")] - 1
      elist$counts[which(elist$elements == "H")] <- elist$counts[which(elist$elements == "H")] - 2 + deltachange
    }
    if ("O" %in% elist$elements & !"H" %in% elist$elements) {
      return("FORMULA_ERROR")
    }
    if (!"O" %in% elist$elements & "H" %in% elist$elements) {
      return("FORMULA_ERROR")
    }
    if (!"O" %in% elist$elements & !"H" %in% elist$elements) {
      return("FORMULA_ERROR")
    }
  }
  collapse_ecomp(elist)
}