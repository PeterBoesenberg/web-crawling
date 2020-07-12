import(magrittr)
import(emayili)
import(config)

export("send_mail")

config <- config::get()
email <- envelope()
email <- email %>%
  from(config$mail$user) %>%
  to(config$error_mail)

smtp <- server(host = config$mail$host,
               port = config$mail$port,
               username = config$mail$user,
               password = config$mail$password)

send_mail <- function(subject, body) {
  email <- email %>% subject(subject)
  email <- email %>% text(body)
  smtp(email, verbose=TRUE)
}
