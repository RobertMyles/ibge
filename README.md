
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ibge

ibge is a work in progress. The idea is to download and make available
(in a tidy format) the data from the IBGE
[Cidades](https://cidades.ibge.gov.br/) project.

As this is A WIP, contributions are welcome. GET requests for this are
quite straightforward.

Proof of concept:

``` r

library(dplyr) # pipe
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

x <- httr::GET("https://servicodados.ibge.gov.br/api/v1/biblioteca?aspas=3&codmun=280030") %>% 
  xml2::read_html() %>% 
  rvest::html_text() %>% 
  jsonlite::fromJSON()

library(purrr)

df <- tibble(
  municipio = map_chr(x, "MUNICIPIO", .null = NA_character_), 
  estado = map_chr(x, "ESTADO", .null = NA_character_),
  history = map_chr(x, "HISTORICO", .null = NA_character_),
  source_history = map_chr(x, "HISTORICO_FONTE", .null = NA_character_),
  administrative_history = map_chr(x, "FORMACAO_ADMINISTRATIVA", .null = NA_character_),
  locals = map_chr(x, "GENTILICO", .null = NA_character_)
  ) %>% 
  tidyr::separate(estado, into = c("state", "uf"), sep = " - ")

df
#> # A tibble: 1 x 7
#>   municipio state  uf    history  source_history  administrative_h… locals
#>   <chr>     <chr>  <chr> <chr>    <chr>           <chr>             <chr> 
#> 1 Aracaju   Sergi… SE    "Logo a… Aracaju (SE). … "Distrito criado… araca…
```

There is a dataset of municipio codes, names and UFs included.

``` r
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
