#Function to get the 2D Descriptive properties of all compounds, based on their SMILES structure
#This function requires the installation of RDKit (https://www.rdkit.org/) and the tidychem R Package
#For description of all descriptors, go to https://www.rdkit.org/docs/GettingStartedInPython.html#list-of-available-descriptors

library(tidychem)

get_properties <- function(suspectlist) {
  smiles <- suspectlist$SMILES
  parsed <- lapply(smiles, parse_smiles)
  cbind(suspectlist, do.call(rbind, lapply(parsed, desc_2d)))
}