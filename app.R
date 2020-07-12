library(RSelenium)
library(stringr)
library(modules)
library(config)

mail <- modules::use("mail.R")

# open chrome and navigate to page
rD <- rsDriver(chromever = '83.0.4103.39')
remDr <- rD[["client"]]
remDr$maxWindowSize(winHand = "current")
remDr$navigate('https://www.google.de/')
Sys.sleep(3)

# Start google search - works fine, no error sent
tryCatch({
  search_field = remDr$findElements('name','q')
  search_field[[1]]$clickElement()
  search_field[[1]]$sendKeysToElement(list('r error handling',key='enter'))
}, error=function(e){ mail$send_mail("Crawling error","Search-input error")})


# can't click result-stats, since google recognizes this script as a robot
# -> throw an error and send an email
tryCatch({
  result_stats = remDr$findElements('id','result-stats')
  result_stats[[1]]$clickElement()
}, error=function(e){ mail$send_mail("Crawling error","Stats click error")})

