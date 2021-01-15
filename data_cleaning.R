

# Loading packages --------------------------------------------------------

library(spotifyr)
library(tidyverse)
library(genius)
library(tidytext)
library(SnowballC)

# Cleaning- Kpop-------------------------------------------------------------

kpop_features <- read.csv("data/Unprocessed/kpop_features_raw.csv")

kpop2_features <- read.csv("data/Unprocessed/kpop2_features_raw.csv")

kpop_features <- kpop_features %>% 
  distinct(track.name, .keep_all = TRUE) %>% # removing duplicates
  top_n(n = 50, wt = track.popularity) %>% # selecting the top 50 tracks based on popularity
  arrange(desc(track.popularity)) # arrange in descending popularity
  
kpop2_features <- kpop2_features %>% 
  distinct(track.name, .keep_all = TRUE) %>% 
  top_n(n = 50, wt = track.popularity) %>% 
  arrange(desc(track.popularity))

# Joining two kpop datasets (from two playlists) --------------------------------------------

kpop_combined <- kpop_features %>% 
  full_join(kpop2_features) %>% 
  distinct(track.name, .keep_all = TRUE) %>% 
  mutate(genre = "kpop") %>% # adding new column "genre"# removing duplicates
  select(c(danceability, energy, key, loudness, speechiness, acousticness, instrumentalness, 
           liveness, valence, tempo, time_signature, name, track.name, track.popularity, 
           track.album.album_type, track.album.name, key_name, mode_name, key_mode
  ))

# I manually classified all artists based on types 
kpop_combined$type = c("boy group", "girl group", "girl group", "girl group", "girl group",
                       "boy group", "girl group", "female solo", "boy group", "boy group", 
                       "boy group", "male solo", "girl group", "girl group", "female solo",
                       "girl group", "female solo", "girl group", "boy group", "boy group", 
                       "girl group", "boy group", 
                       "girl group", "girl group", "female solo", "boy group", "girl group",
                       "girl group", "female solo", "girl group", "female solo", "boy group",
                       "girl group", "boy group", "boy band", "male solo", "boy group", 
                       "girl group", "boy group", "girl group", "girl group", "boy group",
                       "girl group", "girl group", "female solo", "girl group", "boy group",
                       "male solo", "girl group", "boy group", "male solo", "male solo", 
                       "female solo", "male solo", "boy group", "girl group", "boy group", 
                       "girl group", "male solo", "boy group", "boy group", "boy group", 
                       "female solo", "girl group", "boy band", "female solo", "boy group",
                       "boy group", "girl group", "male solo", "boy group", "girl group",
                       "boy group", "mixed group", "boy group", "boy group", "boy group",
                       "female solo", "boy group", "girl group", "boy group", "boy group",
                       "male solo", "girl group", "male solo", "boy group", "boy group",
                       "girl group")

# re-ordering columns
kpop_combined <- kpop_combined[c(12, 13, 16, 15, 14, 20, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
                                 17, 18, 19)]

# re-naming columns for convenience
kpop_combined <- kpop_combined %>% 
  rename(artist.name = name,
         popularity = track.popularity,
         album.type = track.album.album_type,
         album.name = track.album.name) %>% 
  write_csv("data/Processed/kpop_combined.csv")
  

# Cleaning raw data for other genres -------------------------------------------------------------

# procedures are same as kpop
pop <- read_csv("data/Unprocessed/pop_raw.csv")

pop <- pop %>% 
  distinct(track.name, .keep_all = TRUE) %>% 
  top_n(n = 50, wt = track.popularity) %>% 
  arrange(desc(track.popularity)) %>% 
  mutate(genre = "pop")

rnb <- read_csv("data/Unprocessed/rnb_raw.csv")

rnb <- rnb %>% 
  distinct(track.name, .keep_all = TRUE) %>% 
  top_n(n = 50, wt = track.popularity) %>% 
  arrange(desc(track.popularity)) %>% 
  mutate(genre = "rnb")

fna <- read_csv("data/Unprocessed/fna_raw.csv")

fna <- fna %>% 
  distinct(track.name, .keep_all = TRUE) %>% 
  top_n(n = 50, wt = track.popularity) %>% 
  arrange(desc(track.popularity)) %>% 
  mutate(genre = "fna")

hiphop <- read_csv("data/Unprocessed/hiphop_raw.csv")

hiphop <- hiphop %>% 
  distinct(track.name, .keep_all = TRUE) %>% 
  top_n(n = 50, wt = track.popularity) %>% 
  arrange(desc(track.popularity)) %>% 
  mutate(genre = "hiphop")

indie <- read_csv("data/Unprocessed/indie_raw.csv")

indie <- indie %>% 
  distinct(track.name, .keep_all = TRUE) %>% 
  top_n(n = 50, wt = track.popularity) %>% 
  arrange(desc(track.popularity)) %>% 
  mutate(genre = "indie")

cng <- read_csv("data/Unprocessed/cng_raw.csv")

cng <- cng %>% 
  distinct(track.name, .keep_all = TRUE) %>% 
  top_n(n = 50, wt = track.popularity) %>% 
  arrange(desc(track.popularity)) %>% 
  mutate(genre = "cng")

latin <- read_csv("data/Unprocessed/latin_raw.csv")

latin <- latin %>% 
  distinct(track.name, .keep_all = TRUE) %>% 
  top_n(n = 50, wt = track.popularity) %>% 
  arrange(desc(track.popularity)) %>% 
  mutate(genre = "latin")

afropop <- read_csv("data/Unprocessed/afropop_raw.csv")

afropop <- afropop %>% 
  distinct(track.name, .keep_all = TRUE) %>% 
  top_n(n = 50, wt = track.popularity) %>% 
  arrange(desc(track.popularity)) %>% 
  mutate(genre = "afropop")

rock <- read_csv("data/Unprocessed/rock_raw.csv")

rock <- rock %>% 
  distinct(track.name, .keep_all = TRUE) %>% 
  top_n(n = 50, wt = track.popularity) %>% 
  arrange(desc(track.popularity)) %>% 
  mutate(genre = "rock")

country <- read_csv("data/Unprocessed/country_raw.csv")

country <- country %>% 
  distinct(track.name, .keep_all = TRUE) %>% 
  top_n(n = 50, wt = track.popularity) %>% 
  arrange(desc(track.popularity)) %>% 
  mutate(genre = "country")

dance <- read_csv("data/Unprocessed/dance_raw.csv")

dance <- dance %>% 
  distinct(track.name, .keep_all = TRUE) %>% 
  top_n(n = 50, wt = track.popularity) %>% 
  arrange(desc(track.popularity)) %>% 
  mutate(genre = "dance")

# joining top 50 tracks for all genres ----------------------------------------------------------

# top 50 tracks for kpop
kpop_top50 <- kpop_combined %>% 
  select(-type) %>% 
  top_n(n = 50, wt = popularity) %>% 
  arrange(desc(popularity)) %>% 
  mutate(genre = "kpop")

alltracks <- rbind(pop, rnb, hiphop, indie, cng, fna, latin, 
                   afropop, rock, country, dance) %>% 
  distinct(track.name, .keep_all = TRUE) %>% 
  select(c(danceability, energy, key, loudness, speechiness, acousticness, instrumentalness, 
           liveness, valence, tempo, time_signature, name, track.name, track.popularity, 
           track.album.album_type, track.album.name, key_name, mode_name, key_mode, genre
  )) %>%
  rename(artist.name = name,
         popularity = track.popularity,
         album.type = track.album.album_type,
         album.name = track.album.name)

alltracks <- rbind(alltracks, kpop_top50)

alltracks <- alltracks[c(12, 13, 16, 15, 14, 20, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
                         17, 18, 19)]

alltracks %>% write.csv("data/Processed/alltracks.csv")

# Preparing lyrics dataset for word clouds -------------------------------------------

lyrics <- read_csv("data/Processed/kpop_lyrics.csv")

# creating unigrams, i.e. dissecting all lyrics into individual words
lyric_unigrams <- lyrics %>% 
  distinct(artist, track_title, line, .keep_all = TRUE) %>% 
  unnest_tokens(word, lyric)

word_count <- lyric_unigrams %>% 
  count(word, sort = TRUE) %>% 
  mutate(word = reorder(word, n)) %>% 
  ungroup()

word_count %>% 
  write_csv("data/Unprocessed/word_count.csv")

# I tried many packages to remove stop words but few worked with Korean words
# Even with the few that did, it was not very successful and a lot of meaningless words remain
# In the end I just manually removed stop words

# setting font so Korean words appear normally in word clouds
par(family="AppleGothic")

lyrics_ko <- read_csv("data/Unprocessed/word_count_ko.csv")

lyrics_eng <- read_csv("data/Unprocessed/word_count_eng.csv")




