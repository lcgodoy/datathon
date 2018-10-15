library(rvest)
library(RSelenium)

cDr <- wdman::chrome(port = 4444L, verbose = F)
remDr <- remoteDriver(browserName = "chrome", port = 4444L)

#---- Open URL ---

remDr$open()
remDr$navigate('http://capa.tre-rs.jus.br/apps/locais/')

#---- Campo para inserir municipio ----

html <- read_html('http://capa.tre-rs.jus.br/apps/locais/'
                  )
#---- Get options ----

options_municipios <- read_html('http://capa.tre-rs.jus.br/apps/locais/') %>% 
  html_nodes(x = ., xpath = '//*[@id="municipio"]/option') %>% 
  html_text() %>%
  gsub(pattern = '\r\n', replacement = '', x = .) %>% 
  trimws() %>%
  data.frame(Municipio = .) %>% 
  dplyr::bind_cols({
    read_html(municipio$getCurrentUrl()[[1]]) %>% 
      html_nodes(x = ., xpath = '//*[@id="municipio"]/option') %>% 
      html_attr(x = ., name = 'value') %>% 
      data.frame(Codigo = .)
  }) 

options_municipios %>% 
  head()

municipio$sendKeysToElement(sendKeys = list(value = options_municipios$Codigo[options_municipios$Municipio == 'PORTO ALEGRE']))
municipio$setElementAttribute(attributeName = 'value', value = options_municipios$Codigo[options_municipios$Municipio == 'PORTO ALEGRE'])

#---- Pesquisa no google ----

html <- read_html(x = "http://www.tre-rs.jus.br/eleitor/titulo-e-situacao-eleitoral/locais-de-votacao", 
                  encoding = "UTF-8")

html %>% 
  html_nodes(x = ., css = '#texto-conteudo > div > iframe') 

session <- html_session(url = 'http://capa.tre-rs.jus.br/apps/locais/')

form <- session %>% 
  html_form() %>% 
  `[[`(1) %>% 
  set_values(municipio = 'PORTO ALEGRE')

new_url <- submit_form(session, form, submit = '')

#---- dummy ----

html <- read_html(x = 'http://capa.tre-rs.jus.br/apps/locais/index.php?acao=municipio&localidade=7994&nome=PORTO%20ALEGRE', 
                  encoding = 'LATIN1')

html %>% 
  html_node(css = '#textoConteudo > div') %>%
  html_node(css = '#corpo') %>%
  html_node(css = '.apps') 
