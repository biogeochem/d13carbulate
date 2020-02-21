#' Calculate d13C Carbonate Species using d13C-DIC, pH, and Temperature
#'
#' This function calculates the d13C for all dissolved inorganic carbon species given the measured pH, DIC concentration, and water temperature.
#' @keywords d13C-DIC carbonate speciation isotopes
#' @author Pieter J. K. Aukes
#' @param df Your dataframe with values
#' @param temp_col_C Name of column with your measured water temperature (in celsius)
#' @param d13C_DIC_col Name of column with your d13C of DIC (per mille PDB)
#' @param DIC_col_mg.L Name of column that contains your measured dissolved inorganic carbon concentration (mg C/L)
#' @param CO3_col_uM Name of column that contains your measured/calculated carbonate concentrations (umol C/L)
#' @param HCO3_col_uM Name of column that contains your measured/calculated bicarbonate concentrations (umol C/L)
#' @param CO2_col_uM Name of column that contains your measured/calculated dissolved carbon dioxide concentrations (umol C/L)
#' @examples
#' water.df <- d13carbulate(water.df, 'Temp_C', 'd13C_DIC_permille', 'DIC_mgC.L', 'calc_CO3_uM', 'calc_HCO3_uM', 'calc_CO2_uM')


d13carbulate <- function(df, temp_col_C, d13C_DIC_col, DIC_col_mg.L, CO3_col_uM, HCO3_col_uM, CO2_col_uM){

  # conversion and naming functions:
  DIC_uM <- df[[DIC_col_mg.L]]*(1000/12.01);
  temp_C <- df[[temp_col_C]];
  d13C_DIC <- df[[d13C_DIC_col]];
  CO3_uM <- df[[CO3_col_uM]];
  HCO3_uM <- df[[HCO3_col_uM]];
  CO2_uM <- df[[CO2_col_uM]];


  # d13C fractionation factors based on Campeau et al. 2017, who references Zhang et al. 1994
  ebg <- (-0.1141 * temp_C) + 10.78 ;
  edg <- (0.0049 * temp_C) - 1.31 ;
  edb <- edg - ebg ;
  ecg <- (-0.052 * temp_C) + 7.22 ;
  ecb <- (ecg - ebg) / (1 + (edb * (10^-3))) ;

  # calcuate d13C based on d13C-DIC, DIC, carbonate species
  df$calc_d13C_HCO3_permille <- ((d13C_DIC * DIC_uM) - ((edb * CO2_uM) + (ecb * CO3_uM))) / (((1 + (edb * (10^-3))) * CO2_uM) + HCO3_uM + ((1 + (ecb * (10^-3))) * CO3_uM)) ;

  df$calc_d13C_CO2_permille <- df$calc_d13C_HCO3_permille - (1 + (edb * (10^-3))) + edb ;

  df$calc_d13C_CO3_permille <- df$calc_d13C_HCO3_permille - (1 + (ecb * (10^-3))) + ecb ;

  return(df)

}
