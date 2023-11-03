# ---- (1) LIBRARY & SETUP ----
# library & read data
library(DT)
library(flexdashboard)
library(dplyr)
library(ggplot2) # visualisasi
library(scales) # untuk tampilan digit (memberikan koma dll)
library(glue)
library(plotly) 
library(lubridate) # working with datetime
library(leaflet) #install package leaflet for map plotting
options(scipen = 100) # supaya output tidak menampilkan notasi ilmiah (10-e10)

# membaca data
police <- read.csv("data_input/police_cleaned.csv", stringsAsFactors = T)