library(shiny)

options(scipen = 9999)
rm(list = ls())
gc()


runApp(appDir = getwd(), port = 8888, host = "0.0.0.0")
