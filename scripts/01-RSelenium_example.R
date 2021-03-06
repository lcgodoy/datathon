# Example RSelenium

require(RSelenium)

cDr <- wdman::chrome(port = 4444L, verbose = F)
remDr <- remoteDriver(browserName = "chrome", port = 4444L)

#---- IDH - Wikipedia ----

# Abre o navegador

remDr$open()

remDr$navigate("https://pt.wikipedia.org/wiki/Lista_de_munic%C3%ADpios_do_Brasil_por_IDH")

tabela_idh <- remDr$findElement(using = 'css selector', 
                                value = '#mw-content-text > div > table.wikitable.sortable.jquery-tablesorter')

(tabela_idh <- tabela_idh$getElementAttribute(attrName = 'outerHTML'))

(tabela_idh <- XML::htmlTreeParse(tabela_idh[[1]], useInternalNodes = T, encoding = "UTF-8"))

(tabela_idh <- XML::readHTMLTable(doc = tabela_idh, header = T, which = 1, as.data.frame = T))

saveRDS(object = tabela_idh, file = 'data/tab_rsel.rds')
