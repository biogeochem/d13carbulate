#' Calculate d13C Carbonate Species using d13C-DIC, pH, and Temperature
#'
#' This function calculates the d13C for all dissolved inorganic carbon species given the measured pH, DIC concentration, and water temperature.
#' @keywords d13C-DIC carbonate speciation isotopes
#' @author Pieter J. K. Aukes
#' @param dat Your dataframe with values
#' @param temp_col_C Name of column with your measured water temperature (in celsius)
#' @param d13C_DIC_col Name of column with your d13C of DIC (per mille PDB)
#' @param DIC_col_mg.L Name of column that contains your measured dissolved inorganic carbon concentration (mg C/L)
#' @param CO3_col_uM Name of column that contains your measured/calculated carbonate concentrations (umol C/L)
#' @param HCO3_col_uM Name of column that contains your measured/calculated bicarbonate concentrations (umol C/L)
#' @param CO2_col_uM Name of column that contains your measured/calculated dissolved carbon dioxide concentrations (umol C/L)
#' @examples
#' water.dat <- d13carbulate(water.dat, 'Temp_C', 'd13C_DIC_permille', 'DIC_mgC.L', 'calc_CO3_uM', 'calc_HCO3_uM', 'calc_CO2_uM')


d13carbulate <- function(dat, temp_col_C, d13C_DIC_col, DIC_col_mg.L, CO3_col_uM, HCO3_col_uM, CO2_col_uM){

  # conversion and naming functions:
  DIC_uM <- dat[[DIC_col_mg.L]]*(1000/12.01);
  temp_C <- dat[[temp_col_C]];
  d13C_DIC <- dat[[d13C_DIC_col]];
  CO3_uM <- dat[[CO3_col_uM]];
  HCO3_uM <- dat[[HCO3_col_uM]];
  CO2_uM <- dat[[CO2_col_uM]];


  # d13C fractionation factors based on Campeau et al. 2017, who references Zhang et al. 1994
  ebg <- (-0.1141 * temp_C) + 10.78 ;
  edg <- (0.0049 * temp_C) - 1.31 ;
  edb <- edg - ebg ;
  ecg <- (-0.052 * temp_C) + 7.22 ;
  ecb <- (ecg - ebg) / (1 + (edb * (10^-3))) ;

  # calcuate d13C based on d13C-DIC, DIC, carbonate species
  dat$calc_d13C_HCO3_permille <- ((d13C_DIC * DIC_uM) - ((edb * CO2_uM) + (ecb * CO3_uM))) / (((1 + (edb * (10^-3))) * CO2_uM) + HCO3_uM + ((1 + (ecb * (10^-3))) * CO3_uM)) ;

  dat$calc_d13C_CO2_permille <- dat$calc_d13C_HCO3_permille - (1 + (edb * (10^-3))) + edb ;

  dat$calc_d13C_CO3_permille <- dat$calc_d13C_HCO3_permille - (1 + (ecb * (10^-3))) + ecb ;

  return(dat)

}
