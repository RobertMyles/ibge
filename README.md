
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ibge

The idea of `ibge` is to download and make available (in a tidy format)
the data from the IBGE [Cidades](https://cidades.ibge.gov.br/) project.

There is a dataset of municipio codes, names and UFs included.

``` r
library(ibge)
data("ibge_codes")
head(ibge_codes)
#> # A tibble: 6 x 4
#>     codes municipio            uf    municipio_ascii     
#>     <int> <chr>                <chr> <chr>               
#> 1 1100015 Alta Floresta DOeste RO    Alta Floresta DOeste
#> 2 1100023 Ariquemes            RO    Ariquemes           
#> 3 1100031 Cabixi               RO    Cabixi              
#> 4 1100049 Cacoal               RO    Cacoal              
#> 5 1100056 Cerejeiras           RO    Cerejeiras          
#> 6 1100064 Colorado do Oeste    RO    Colorado do Oeste
```

## Usage

The function `historic()` returns a one-line dataframe of information on
the municipality selected. Since this may be of limited use, it also
prints out a HTML page of the same information (in an interactive
session only). If using RStudio, this will appear in the Viewer pane.
This function returns data in the original Portuguese.  
For example, let’s learn a little about *Nova Olinda do Norte*, in
Amazonas state (I hope you’ve brushed up on your Brazilian Portuguese).

``` r
library(dplyr)

filter(ibge_codes, municipio == "Nova Olinda do Norte") %>% 
  pull(codes) %>% 
  historic()
#> # A tibble: 1 x 7
#>   municipio  state  uf    history  source_history  administrative_h… locals
#>   <chr>      <chr>  <chr> <chr>    <chr>           <chr>             <chr> 
#> 1 Nova Olin… Amazo… AM    "O nome… Biblioteca Vir… "Elevado à categ… olind…
```

Something like the following should appear in your Viewer pane:

<img src="https://i.imgur.com/5JriErp.png">
