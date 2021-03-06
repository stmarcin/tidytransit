% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spatial.R
\name{get_trip_geometry}
\alias{get_trip_geometry}
\title{Get all trip shapes for a given route and service.}
\usage{
get_trip_geometry(gtfs_sf_obj, trip_ids)
}
\arguments{
\item{gtfs_sf_obj}{tidytransit gtfs object with sf data frames}

\item{trip_ids}{trip_ids to extract shapes}
}
\value{
an sf dataframe for gtfs routes with a row/linestring for each trip
}
\description{
Get all trip shapes for a given route and service.
}
\examples{
data(gtfs_duke)
gtfs_duke <- gtfs_as_sf(gtfs_duke)
trips_sf <- get_trip_geometry(gtfs_duke, c("t_726295_b_19493_tn_41", "t_726295_b_19493_tn_40"))
plot(trips_sf[1,])
}
