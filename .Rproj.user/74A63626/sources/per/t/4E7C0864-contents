library(rvest)

#---- Pesquisa no google ----

html <- read_html(x = "http://www.tre-rs.jus.br/eleitor/titulo-e-situacao-eleitoral/locais-de-votacao", encoding = "UTF-8")

html %>% 
  html_nodes(x = ., css = '#texto-conteudo > div > iframe')

session <- html_session(url = 'http://capa.tre-rs.jus.br/apps/locais/')

form <- read_html(x = 'http://capa.tre-rs.jus.br/apps/locais/') %>% 
  html_form() %>% 
  `[[`(1) %>% 
  set_values(municipio = 'PORTO ALEGRE')

new_url <- httr::submit_geturl(session, form)


#---- dummy ----

html <- read_html(x = 'http://capa.tre-rs.jus.br/apps/locais/index.php?acao=municipio&localidade=7994&nome=PORTO%20ALEGRE', 
                  encoding = 'LATIN1')

html %>% 
  html_node(css = '#textoConteudo > div') %>%
  html_node(css = '#corpo') %>%
  html_node(css = '.apps') 

html %>% 
   %>%
  

