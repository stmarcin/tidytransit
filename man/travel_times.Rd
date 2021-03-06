% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/raptor.R
\name{travel_times}
\alias{travel_times}
\title{Calculate shortest travel times from a stop to all reachable stops}
\usage{
travel_times(filtered_stop_times, from_stop_name,
  departure_time_range = 3600, max_transfers = NULL,
  max_departure_time = NULL, return_DT = FALSE)
}
\arguments{
\item{filtered_stop_times}{stop_times data.table (with transfers and stops tables as
attributes) created with \code{\link[=filter_stop_times]{filter_stop_times()}} where the
deparuture time has been set.}

\item{from_stop_name}{stop name from which travel times should be calculated. A vector
with multiple names is accepted.}

\item{departure_time_range}{All departures within this range in seconds after the first
departure of \code{filtered_stop_times} are considered for
journeys.}

\item{max_transfers}{The maximimum number of transfers}

\item{max_departure_time}{Either set this parameter or \code{departure_time_range}. Only
departures before \code{max_departure_time} are used. Accepts
"HH:MM:SS" or seconds as numerical value.}

\item{return_DT}{travel_times() returns a data.table if TRUE. Default is FALSE which
returns a tibble/tbl_df.}
}
\value{
A table with travel times to all stops reachable from \code{from_stop_name} and their
corresponding journey departure and arrival times.
}
\description{
Function to calculate the shortest travel times from a stop (give by \code{from_stop_name})
to all other stops of a feed. \code{filtered_stop_times} needs to be created before with
\code{\link[=filter_stop_times]{filter_stop_times()}}.
}
\details{
This function allows easier access to \code{\link[=raptor]{raptor()}} by using stop names instead of ids and
returning shortest travel times by default.
}
\examples{
\donttest{
nyc_path <- system.file("extdata", "google_transit_nyc_subway.zip", package = "tidytransit")
nyc <- read_gtfs(nyc_path)

# Use journeys departing after 7 AM with arrival time before 9 AM on 26th June
stop_times <- filter_stop_times(nyc, "2018-06-26", 7*3600, 9*3600)

tts <- travel_times(stop_times, "34 St - Herald Sq")
tts <- tts \%>\% filter(travel_time <= 3600)

# travel time to Queensboro Plaza is 810 seconds, 13:30 minutes
tts \%>\% filter(stop_name == "Queensboro Plaza") \%>\% dplyr::pull(travel_time) \%>\% hms::hms()

# plot a simple map showing travel times to all reachable stops
# this can be expanded to isochron maps
library(ggplot2)
ggplot(tts) + geom_point(aes(x=stop_lon, y=stop_lat, color = travel_time))
}
}
