library(gmailr)
ques <- "0201"
gm_auth_configure(path = 'C:\\Users\\kogan\\OneDrive - Washington State University (email.wsu.edu)\\wsu-code-repos\\packages\\rquiz\\json\\credentials.json')
gm_auth()
my_threads <- gm_threads(search = "0201")
gm_thread(my_threads[[1]])
latest_thread <- lapply(gm_id(my_threads), gm_thread)
dput(latest_thread[[1]]$messages[[1]])
mes <- lapply(latest_thread, function(x) x$message)
latest_thread[[1]]$messages[[1]][[7]]$headers[[22]]$value
f <- function(x) {
  hdrs <- sapply(x$messages[[1]][[7]]$headers, function(y) y$name)
  ix <- which(hdrs == "Subject")
  x$messages[[1]][[7]]$headers[[ix]]$value
}
res <- sapply(latest_thread, f)
library(stringr)
tolower(trimws(str_replace(res, ques, "")))
