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
