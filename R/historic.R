library(tidyverse)

data("ibge_codes")
code <- filter(ibge_codes, municipio == "Colina") %>%
  pull(codes)

historic <- function(code = NULL, render = FALSE){

  if(is.null(code)) stop("IBGE code needed. See `data('ibge_codes)`.")
  if(nchar(code) < 7) stop("Invalid code. See `data('ibge_codes)`.")

  base <- "https://servicodados.ibge.gov.br/api/v1/biblioteca?aspas=3&codmun="

  x <- httr::GET(paste0(base, code)) %>%
    xml2::read_html() %>%
    rvest::html_text() %>%
    jsonlite::fromJSON()

  nulo <- NA_character_

  df <- tibble(
    municipio = map_chr(x, "MUNICIPIO", .null = nulo),
    estado = map_chr(x, "ESTADO", .null = nulo),
    history = map_chr(x, "HISTORICO", .null = nulo),
    source_history = map_chr(x, "HISTORICO_FONTE", .null = nulo),
    administrative_history = map_chr(x, "FORMACAO_ADMINISTRATIVA",
                                     .null = nulo),
    locals = map_chr(x, "GENTILICO", .null = nulo)
  ) %>%
    tidyr::separate(estado, into = c("state", "uf"), sep = " - ")

  if(render == TRUE){
    glue::glue('<p>
             <b>Municipio:</b> {df$municipio}
             <br>
             <b>Estado:</b> {df$state}
             <br>
             <b>UF:</b> {df$uf}
             <br>
             <b>Locals:</b> {df$locals}
             <br>
             <b>Historia:</b> {df$history}
             <br>
             <b>Historia Administrativa:</b> {df$administrative_history}
             <br>
             <b>Fonte:</b> {df$source_history}
             </p>') %>%
      htmltools::HTML() %>%
      htmltools::html_print(background = "#F7F3E3")
  }

  df

}
