###############################
# check working directory
getwd()

#check if file exist or not

file.exists('data2')
file.exists

# Creat working directory
if(!file.exists("data")){
  dir.create("data")
}

setwd('./data')
getwd()
setwd('../')
getwd()


###############################
# if you download file import parameter of 
# this function is url, destfile, method

download.file()
#download file

fileurl <- "https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2020-financial-year-provisional/Download-data/annual-enterprise-survey-2020-financial-year-provisional-csv.csv"
download.file(fileurl, destfile = "./data/annural_enterprise_survey.csv", method= "curl")
list.files("./data")
cameradata <- read.csv("./data/annural_enterprise_survey.csv")
# check structure of data
str(cameradata)
datedownload <- date()
datedownload

###############################
# read file
cameradata <- read.table("./data/cameras.csv", sep = ',', header = TRUE)
head(cameradata)

#read.csv
cameradata <- read.csv("./data/cameras.csv")
head(cameradata)
library(data.table)
?fread
################################################################
# excel file
install.packages("xlsx")
library(xlsx)
cameradata <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, header=TRUE)
head(cameradata)
colIndex <- 2:3
rowIndex <- 1:4
cameradatasubset <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, colIndex = colIndex, rowIndex=rowindex)
cameradatasubset
#---------------------
install.packages("readxl")
library("readxl")
readxl_example()
xlsxexample <- readxl_example("datasets.xlsx")
diris <- read_excel(xlsxexample)
dd <- read_excel("cameras.xlsx")
#-------------------
# write in excel file
devtools::install_github("repensci/writexl")
library(writexl)
write_xlsx(df, "file_formated.xlsx")
#------------------
?read_excel()
# install.packages("openxlsx")
#########################################
# web scraping
#--------------
# reading webpage
install.packages(revest)
library(rvest)
#----------------
theurl <- "https://en.wikipedia.org/wiki/Brazil_national_football_team"
file <- read_html(theurl)

# read table from webpage
tables <- html_nodes(file, "table")
table <- html_table(tables[3], fill = TRUE)
print(table)
