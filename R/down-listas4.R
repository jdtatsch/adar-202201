# 1. Buscar no moodle os alunos que postaram repositorio da #atividade,
#    incluindo os alunos de topicos da pós

# 2. colar links no vetor abaixo

library(tidyverse)

names_github <- function(repos){
  # repos = links
  nomes <- fs::path_dir(repos)
  nomes <- unlist(str_split(nomes, "resolucao"))[c(TRUE, FALSE)]
  nomes <- fs::path_file(nomes)
  nomes
}
  
  
links <- c(
  "https://github.com/GuilhermeTorma/resolucao-lista4-adar/archive/refs/heads/main.zip",
  "https://github.com/Gabriel-WH/resolucao-lista4-adar/archive/refs/heads/main.zip",
  # ppgmet
  "https://github.com/rodrigo-s-pereira/resolucao-lista4-adar/archive/refs/heads/main.zip"
)
#

down_lists <- function(links) {
  
  purrr::walk(
    links,
    function(ifile) {
      # ifile = links[1]
      fs::dir_create(here::here("Rmd", names_github(ifile)), recurse = TRUE)
      
      lista_num <- stringr::str_extract(ifile, "lista[0-9]") %>% readr::parse_number()
      lista_num <- glue::glue("lista{lista_num}-adar-")
      
      dest_file <- 
        here::here(
          "Rmd", 
          names_github(ifile),
          paste0(
            lista_num,
            names_github(ifile),
            ".zip"
          )
        )
      
      download.file(ifile, destfile = dest_file)
      unzip(dest_file, exdir = dirname(dest_file),
            junkpaths = TRUE # para extrair so o arquivo sem a str de diretorios
            )
      
    }
  )
}

down_lists(links)