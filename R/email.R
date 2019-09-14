#' @export
pull_question <- function(search, oauth_path, sid_file) {
  sid <- read.csv(sid_file, stringsAsFactors = F)
  gm_auth_configure(path = oauth_path)
  threads <- gm_threads(search = search)
  threads <- lapply(gm_id(threads), gm_thread)
  info <- lapply(threads, email_info)
  do.call(rbind, info) %>%
    left_join(sid)
}

#' @export
email_info <- function(thread) {
  hdrs <- thread$messages[[1]]$payload$headers
  hdr_names <- sapply(hdrs, function(y) y$name)
  ix_subject <- which(hdr_names == "Subject")
  ix_from <- which(hdr_names == "From")
  ix_date <- which(hdr_names == "Date")
  fr <- to_emails(hdrs[[ix_from]]$value)
  dt <- rquiz_convdate(hdrs[[ix_date]]$value)
  data.frame(subject = hdrs[[ix_subject]]$value, email = fr, date = dt, stringsAsFactors = F)
}
