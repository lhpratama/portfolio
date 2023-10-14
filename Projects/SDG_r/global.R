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
options(scipen = 100) # supaya output tidak menampilkan notasi ilmiah (10-e10)
library(reshape2) # for melt function
library(sf)
library(rnaturalearth)
library(countrycode)

# membaca data
index <- read.csv("data_input/sdg_index_2000-2022.csv")
report <- read.csv("data_input/sustainable_development_report_2023.csv")