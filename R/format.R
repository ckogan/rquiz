#' Conversion of string dates from python gmail api to R format
#' @export
rquiz_convdate <- function(dates) {
  time_zone_adj <- as.numeric(sapply(str_split(dates, "[+|-]"), last))/100
  # Remove day name
  dates <- dmy_hms(substr(dates, 6, 26))
  dates + hours(time_zone_adj - 7)
}

#' Extract email address from unformatted email address
#' @export
to_emails <- function(emails) {
  str_extract(emails,"[^\x3c]+[@][^\x3e]+")
}
