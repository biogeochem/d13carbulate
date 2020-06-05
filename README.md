d13carbulate <img src="man/figures/d13carbulate_logo.png" width="120" align="right" />
======================================================================================

This package calculates the δ<sup>13</sup>C values for all dissolved
carbonate species within a water sample (CO2<sub>(aq)</sub>,
HCO<sub>3</sub><sup>-</sup>, and CO<sub>3</sub><sup>2-</sup>) from pH,
total DIC concentration, water temperature, and concentrations of the
carbonate species. Check out the other package
[`carbulate`](https://github.com/biogeochem/carbulate) to calculate
concentrations for all dissolved carbonate species (from DIC, pH, and
water temperature).

Installation
------------

    library(devtools)
    devtools::install_github("biogeochem/d13carbulate")

Parameters
----------

`d13carbulate(df, temp_col_C, d13C_DIC_col, DIC_col_mg.L, CO3_col_uM, HCO3_col_uM, CO2_col_uM)`

`df` - Your dataframe with values  
`temp_col_C` - Name of column with your measured water temperature (in
Celsius)  
`d13C_DIC_col` Name of column with your d13C of DIC (per mille PDB)  
`DIC_col_mg.L` Name of column that contains your measured dissolved
inorganic carbon concentration (mg C/L)  
`CO3_col_uM` - Name of column that contains your measured/calculated
carbonate concentrations (umol C/L)  
`HCO3_col_uM` - Name of column that contains your measured/calculated
bicarbonate concentrations (umol C/L)  
`CO2_col_uM` - Name of column that contains your measured/calculated
dissolved carbon dioxide concentrations (umol C/L)

Example
-------

This is how you would input this function to add the carbonate species
to the dataframe `water.df`:

`water.df <- d13carbulate(water.df, 'Temp_C', 'd13C_DIC_permille', 'DIC_mgC.L', 'calc_CO3_uM', 'calc_HCO3_uM', 'calc_CO2_uM')`
