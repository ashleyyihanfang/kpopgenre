
# Loading packages --------------------------------------------------------

library(spotifyr)
library(tidyverse)
library(genius)


# Entering Spotify access token ----------------------------------------------------

Sys.setenv(SPOTIFY_CLIENT_ID = '3aae041578b64519942b572adc41f54b')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '65a6e367b99440188274db79c1967af0')

token <- get_spotify_access_token()

# Getting my playlists ----------------------------------------------------

my_id <- '22ninnvunp2oxzypbp6gpvrty'

my_playlists <- get_user_playlists('22ninnvunp2oxzypbp6gpvrty')

# Getting two Kpop playlists ----------------------------------------------

kpop <- get_playlist_tracks("3gomCvuJDZ8G93g8HNGDXV")
kpop_features <- get_playlist_audio_features("22ninnvunp2oxzypbp6gpvrty", "3gomCvuJDZ8G93g8HNGDXV")
kpop2_features <- get_playlist_audio_features("22ninnvunp2oxzypbp6gpvrty", "37i9dQZF1DWTY99d0AYptp")

# Unnesting and Saving Raw CSV Files- Kpop --------------------------------------

kpop_features <- kpop_features %>% 
  unnest(track.artists) %>% 
  select(-c(track.album.artists, track.album.images, 
            track.album.available_markets, track.available_markets)) %>% 
  write_csv("data/Unprocessed/kpop_features_raw.csv")

# these columns are removed because they contain data frames instead of strings,
# and could not be saved in a flat file.
# these columns are also irrelevant to my data exploration

kpop2_features <- kpop2_features %>% 
  unnest(track.artists) %>% 
  select(-c(track.album.artists, track.album.images, 
            track.album.available_markets, track.available_markets)) %>% 
  write_csv("data/unprocessed/kpop2_features_raw.csv")

# Getting playlists for other 10 genres ---------------------------------------------

pop <- get_playlist_audio_features("22ninnvunp2oxzypbp6gpvrty", "37i9dQZF1DXau6DEOS07fE")

rnb <- get_playlist_audio_features("22ninnvunp2oxzypbp6gpvrty", "37i9dQZF1DWT2DKEIZ0ILA")

fna <- get_playlist_audio_features("22ninnvunp2oxzypbp6gpvrty", "37i9dQZF1DWYdLqwKCcDiy")

hiphop <- get_playlist_audio_features("22ninnvunp2oxzypbp6gpvrty", "37i9dQZF1DX4ykqMZqUn3L")

indie <- get_playlist_audio_features("22ninnvunp2oxzypbp6gpvrty", "37i9dQZF1DWTc5QDlvD7t0")

cng <- get_playlist_audio_features("22ninnvunp2oxzypbp6gpvrty", "37i9dQZF1DX5JHlV94wGBQ")

latin <- get_playlist_audio_features("22ninnvunp2oxzypbp6gpvrty", "2P3A4oybmznGl3rRXfH6YQ")

afropop <- get_playlist_audio_features("22ninnvunp2oxzypbp6gpvrty", "37i9dQZF1DXdD040nrEzxm")

rock <- get_playlist_audio_features("22ninnvunp2oxzypbp6gpvrty", "37i9dQZF1DX5gBZa9tnZTY")

country <- get_playlist_audio_features("22ninnvunp2oxzypbp6gpvrty", "37i9dQZF1DX3RCeShx2suK")

dance <- get_playlist_audio_features("22ninnvunp2oxzypbp6gpvrty", "37i9dQZF1DWYEA2z2jQnzS")


# Unnesting and saving raw data files ----------------------------------------------------------------

pop <- pop %>% 
  unnest(track.artists) %>% 
  select(-c(track.album.artists, track.album.images, 
            track.album.available_markets, track.available_markets)) %>% 
  write_csv("data/Unprocessed/pop_raw.csv")

rnb <- rnb %>% 
  unnest(track.artists) %>% 
  select(-c(track.album.artists, track.album.images, 
            track.album.available_markets, track.available_markets)) %>% 
  write_csv("data/Unprocessed/rnb_raw.csv")

fna <- fna %>% 
  unnest(track.artists) %>% 
  select(-c(track.album.artists, track.album.images, 
            track.album.available_markets, track.available_markets)) %>% 
  write_csv("data/Unprocessed/fna_raw.csv")

hiphop <- hiphop %>% 
  unnest(track.artists) %>% 
  select(-c(track.album.artists, track.album.images, 
            track.album.available_markets, track.available_markets)) %>% 
  write_csv("data/Unprocessed/hiphop_raw.csv")

indie <- indie %>% 
  unnest(track.artists) %>% 
  select(-c(track.album.artists, track.album.images, 
            track.album.available_markets, track.available_markets)) %>% 
  write_csv("data/Unprocessed/indie_raw.csv")

cng <- cng %>% 
  unnest(track.artists) %>% 
  select(-c(track.album.artists, track.album.images, 
            track.album.available_markets, track.available_markets)) %>% 
  write_csv("data/Unprocessed/cng_raw.csv")

latin <- latin %>% 
  unnest(track.artists) %>% 
  select(-c(track.album.artists, track.album.images, 
            track.album.available_markets, track.available_markets)) %>% 
  write_csv("data/Unprocessed/latin_raw.csv")

afropop <- afropop %>% 
  unnest(track.artists) %>% 
  select(-c(track.album.artists, track.album.images, 
            track.album.available_markets, track.available_markets)) %>% 
  write_csv("data/Unprocessed/afropop_raw.csv")

rock <- rock %>% 
  unnest(track.artists) %>% 
  select(-c(track.album.artists, track.album.images, 
            track.album.available_markets, track.available_markets)) %>% 
  write_csv("data/Unprocessed/rock_raw.csv")

country <- country %>% 
  unnest(track.artists) %>% 
  select(-c(track.album.artists, track.album.images, 
            track.album.available_markets, track.available_markets)) %>% 
  write_csv("data/Unprocessed/country_raw.csv")

dance <- dance %>% 
  unnest(track.artists) %>% 
  select(-c(track.album.artists, track.album.images, 
            track.album.available_markets, track.available_markets)) %>% 
  write_csv("data/Unprocessed/dance_raw.csv")


# Scraping kpop lyrics from genius ----------------------------------------

# selecting only the columns for artist and column name
kpop_artist_album <- kpop_combined %>% 
  select(artist.name, track.album.name) %>% 
  rename(artist = artist.name,
         album = track.album.name)

kpop_artist_album %>% write.csv("data/Unprocessed/kpop_artist_album.csv")

kpop_lyrics <- add_genius(kpop_artist_album, artist, album, type = "album")

# Checking how many album lyrics were successfully retrieved
kpop_lyrics %>% 
  count(artist, track_title)
# obtained lyrics for 307 tracks

# Tracks missing
lyrics_remaining <- anti_join(kpop_artist_album, kpop_lyrics) %>% 
  count(artist, album) %>% 
  distinct(artist, album) 
# Failed to get lyrics for 40 albums out of the list of 88


# Second try with remaining tracks
# A lot of these are singles, so I tried searching for "track" instead of "album"
kpop_lyrics2 <- add_genius(lyrics_remaining, artist, album, type = "track")

lyrics_remaining2 <- anti_join(lyrics_remaining, kpop_lyrics2) %>% 
  count(artist, album) %>% 
  distinct(artist, album) 
# 35 albums/singles still missing

# Writing to csv file so I can manually adjust track and artist names to match those on Genius
lyrics_remaining2 %>% write.csv("data/Unprocessed/lyrics_remaining2.csv")


# Third try after manually adjusting album and artist names (searching for "albums")

lyrics_remaining2 <- read.csv("data/Unprocessed/lyrics_remaining2_edited.csv")

kpop_lyrics3 <- add_genius(lyrics_remaining2, artist, album, type = "album")

lyrics_remaining3 <- anti_join(lyrics_remaining2, kpop_lyrics3) %>% 
  count(artist, album) %>% 
  distinct(artist, album) 
# 25 albums/singles still missing


# Fourth try (searching for "tracks")

kpop_lyrics4 <- add_genius(lyrics_remaining3, artist, album, type = "track")

# binding lyrics retrieved in the third and fourth try
kpop_lyrics4 <- kpop_lyrics3 %>% 
  select(-c(track_n, X)) %>% 
  rbind(kpop_lyrics4)

lyrics_remaining4 <- anti_join(lyrics_remaining2, kpop_lyrics4) %>% 
  count(artist, album) %>% 
  distinct(artist, album)
# 18 albums/singls still missing


# Manually adding all others

m1 <- genius_url("https://genius.com/Blackpink-as-if-its-your-last-lyrics")
m1 <- m1 %>% 
  mutate(artist = "BLACKPINK",
         album = "마지막처럼 (AS IF IT’S YOUR LAST)")

m2 <- genius_lyrics(artist = "Bol4", song = "bom")
m2 <- m2 %>% 
  mutate(artist = "BOL4",
         album = "나만, 봄 (Bom)")

m3 <- genius_lyrics(artist = "Bts-and-juice-wrld", song = "all-night")
m3 <- m3 %>% 
  mutate(artist = "BTS",
         album = "All Night")

m4 <- genius_album(artist = "BTS", album = "LOVE YOURSELF")
m4 <- m4 %>% 
  mutate(artist = "BTS",
         album = "LOVE YOURSELF") %>% 
  select(-track_n)

m5 <- genius_url("https://genius.com/Chung-ha-12-gotta-go-lyrics")
m5 <- m5 %>% 
  mutate(artist = "CHUNG HA",
         album = "벌써 12시 (Gotta Go)")

m6 <- genius_album(artist = "Exo", album = "Don-t-mess-up-my-tempo")
m6 <- m6 %>% 
  mutate(artist = "EXO",
         album = "Don't Mess Up My Tempo") %>% 
  select(-track_n)

m7 <- genius_url("https://genius.com/Exo-tempo-lyrics")
m7 <- m7 %>% 
  mutate(artist = "EXO",
         album = "Don't Mess Up My Tempo")

m8 <- genius_url("https://genius.com/Heize-we-dont-talk-together-lyrics") 
m8 <- m8 %>% 
  mutate(artist = "HEIZE",
         album = "We Don't Talk Together")

m9 <- genius_album(artist = "Izone", album = "Heart-iz")
m9 <- m9 %>% 
  mutate(artist = "IZ*ONE",
         album = "HEART*IZ") %>% 
  select(-track_n)

m10 <- genius_album(artist = "Izone", album = "Color-iz")
m10 <- m10 %>% 
  mutate(artist = "IZ*ONE",
         album = "COLOR*IZ") %>% 
  select(-track_n)

m11 <- genius_url("https://genius.com/K-da-pop-stars-lyrics")
m11 <- m11 %>% 
  mutate(artist = "K/DA",
         album = "POP/STARS")

m12 <- genius_url("https://genius.com/Kard-dumb-litty-lyrics")
m12 <- m12 %>% 
  mutate(artist = "KARD",
         album = "Dumb Litty")

m13 <- genius_album(artist = "Lee-hi", album = "24oc")
m13 <- m13 %>% 
  mutate(artist = "LEE HI",
         album = "24oc") %>% 
  select(-track_n)

m14 <- genius_album(artist = "Pentagon-kor", album = "Positive")
m14 <- m14 %>% 
  mutate(artist = "PENTAGON",
         album = "Positive") %>% 
  select(-track_n)

m15 <- genius_album(artist = "Pentagon-kor", album = "Sum-me-r")
m15 <- m15 %>% 
  mutate(artist = "PENTAGON",
         album = "SUM(ME:R)") %>% 
  select(-track_n)

m16 <- genius_album(artist = "Shinee", album = "The-story-of-light-epilogue")
m16 <- m16 %>% 
  mutate(artist = "SHINee",
         album = "‘The Story of Light’ Epilogue") %>% 
  select(-track_n)

m17 <- genius_url("https://genius.com/Sunmi-lalalay-lyrics")
m17 <- m17 %>% 
  mutate(artist = "SUNMI",
         album = "LALALAY")

m18 <- genius_album(artist = "Wanna-one", album = "1-1-0-nothing-without-you")
m18 <- m18 %>% 
  mutate(artist = "Wanna One",
         album = "1-1=0 (Nothing Without You)") %>% 
  select(-track_n)


# Binding lyrics from all five steps of mining
kpop_lyrics <- kpop_lyrics %>% 
  select(-track_n) %>% 
  rbind(kpop_lyrics2, kpop_lyrics4)

kpop_lyrics5 <- rbind(
  m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16, m17, m18
)

kpop_lyrics <- rbind(kpop_lyrics, kpop_lyrics5)

# Writing to CSV file
kpop_lyrics %>% write.csv("data/Processed/kpop_lyrics.csv")

?diamonds

