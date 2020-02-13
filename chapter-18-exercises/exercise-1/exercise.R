# load relevant libraries
library("httr")
library("jsonlite")

# Be sure and check the README.md for complete instructions!


# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source("apikey.R")

# Create a variable `movie_name` that is the name of a movie of your choice.
movie_name <- "Parasite"
key_param <- list(
  "api-key" = nyt_key,
  "movie_name" = movie_name
)
# Construct an HTTP request to search for reviews for the given movie.
base <-"https://api.nytimes.com/svc/movies/v2/"
endpoint <- "reviews/search.json"
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie_name` variable as the search query!

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
get <- GET(paste0(base, endpoint), query = key_param)
print(get)
body <- fromJSON(content(get, "text"))
print(body)
# What kind of data structure did this produce? A data frame? A list?
# list

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
names(body)
info <- body$reviews
# Flatten the movie reviews content into a data structure called `reviews`
reviews <- flatten(body)

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
most_recent <- top_n(info, 1)
headline <- pull(most_recent, headline)
short_summary <- info$short_summary

# Create a list of the three pieces of information from above. 
# Print out the list.
