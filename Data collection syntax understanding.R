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
######################################
# Database
# sql
install.packages("RSQLite")
library(RSQLite)
data("mtcars")
mtcars$car_names <- rownames(mtcars)
rownames(mtcars) <- c()
head(mtcars)
getwd()
setwd("./data")
getwd()
# create database
# create connection
conn <- dbConnect(RSQLite::SQLite(),"carsDB.db")
# write the mtcars dataset into a table name mtcars_data
dbWriteTable(conn, "cars_data",mtcars)
#list all the table in database
dbListTables(conn)
# quick access of function
dbListFields(conn,"cars_data")
dbReadTable(conn, "cars_data")
#--------------
#airpassenger dataset
getwd()
setwd("./data")
library(RSQLite)
library(help="datasets")
air <- datasets::AirPassengers
air

air
conn_air <- dbConnect(RSQLite::SQLite(),"airpassenger.db")
dbWriteTable(conn=conn_air,"air_passenger",air_p)
dbListTables(conn_air)
dbListFields(conn_air,"air_passenger")
dbReadTable(conn_air, "air_passenger")
data(AirPassengers)
AirPassengers$years<- rownames(AirPassengers)
#------------------------------
dbGetQuery(conn, "SELECT * FROM cars_data LIMIT 5")

dbGetQuery(conn,"SELECT car_names, hp,cyl FROM cars_data
           where car_names LIKE 'M%' AND cyl IN (6,8)" )

dbGetQuery(conn,"SELECT cyl, AVG(hp) As 'average_hp',AVG(mpg) As 'average_mpg' FROM cars_data
           GROUP BY cyl
           ORDER BY Average_hp")

avg_HPCyl <- dbGetQuery(conn,"SELECT cyl, AVG(hp) As 'average_hp' FROM cars_data
                        GROUP BY cyl
                        ORDER BY average_hp")
avg_HPCyl
class(avg_HPCyl)
#--------------------------------
# parameterized query (when we doing filter so get input from user)
# insert variables
mpg <- 8
cyl<- 4
result <- dbGetQuery(conn, 'SELECT car_names, mpg, cyl FROM cars_data WHERE mpg >= ? AND cyl >= ?', params=c(mpg,cyl))
result
#---------------
# 
# visualize the table before deletion
dbGetQuery(conn, "SELECT * FROM cars_data LIMIT 5")
#delete data
# delete something from column on some condition
dbExecute(conn, "DELETE FROM cars_data WHERE car_names='Mazda RX4 Wag'")

# visualize the new table
dbGetQuery(conn, "SELECT * FROM cars_data LIMIT 5")

# inset data
dbExecute(conn, "INSERT INTO cars_data VALUES
          (21.0,6,160.0,110,3.90,2.620,16.46,0,1,4,4,'Mazda RX4')")

# check result
dbGetQuery(conn, "SELECT * FROM cars_data")
#------------------------
#SQLite other function
# you can fetch all the result
res <- dbSendQuery(conn,"SELECT*FROM cars_data WHERE cyl=6")
dbFetch(res)

# clear the result
dbClearResult(res)

# chunk at a time
res <- dbSendQuery(conn,"SELECT*FROM cars_data WHERE cyl=8")
while(!dbHasCompleted(res)){
  chunk <- dbFetch(res, n=5)
  print(nrow(chunk))
}

# clear the result
dbClearResult(res)

dbDisconnect(conn)
#------------------------------------------
# mysql
install.packages("RMySQL")
library('RMySQL')
ucscdb <- dbConnect(MySQL(),user ="genome", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscdb,"show databases"); dbDisconnect(ucscdb)
result
#------------------
# connecting to a Database
hg19 <- dbConnect(MySQL(),user="genome",db="hg19",
                  host="genome-mysql.cse.ucsc.edu")
alltables <- dbListTables(hg19)
length(alltables)
alltables[1:10]
#list of field in a list
dbListFields(hg19, "affyU133Plus2")
# count
dbGetQuery(hg19, "select count(*) from affyU133Plus2")

affyData <- dbReadTable(hg19,"affyU133Plus2")
head(affyData)
# select a specific subset
install.packages("dbConnect")
library('dbConnect')
query <- dbSendPreparedQuery(hg19,"SELECT * FROM affyU133Plus2 WHERE misMatches between 1 and 5")
affyMis <- fetch(query); quantile(affyMis$misMatches)
affyMis

affyMisSmall <- fetch(query,n=10); dbClearResult(query)
dim(affyMisSmall)
dbDisconnect(hg19)

####################################################################
# create data table
#using data.frame()
library(data.table)
DF <- data.frame(x = rnorm(9), y =rep(c("a","b","c"), each =3), z = rnorm(9))
head(DF,3)

# using data table
library(data.table)
DT <- data.table(x = rnorm(9), y =rep(c("a","b","c"), each =3), z = rnorm(9))
head(DF,3)

#using tables() function give you details of all tables which exixt in a memory
tables()
#---------------------------------
# calculate value for variables with expression
DT[,list(mean(x),sum(z))]

DT[,table(y)]

table(DF$y)

# add new column
DT[,w:=z^2]
head(DT)
# logic operation
DT[,a:= x>0]
head(DT)
#----------------
# merge data table

DT1 <- data.table(x=c('a','a','dt1'), y=1:3)
DT1

DT2 <- data.table(x=c('a','b','dt2'),z=5:7)
DT2

setkey(DT1,x);setkey(DT2,x)

merge(DT1, DT2)
#-----
data.table::fsort(DT1)
##########################################
# subsetting and sorting
set.seed(13435)
x <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
x
x[,1]
x[,"var1"]
x[1:2,"var2"]


x <- x[sample(1:5),];x$var2[c(1,3)]=NA
x
#---------------------
#logial operator
x[(x$var1 <= 3 & x$var3 > 11),]

x[(x$var1 <= 3 | x$var3 > 15),]

#---------
sort(x, decreasing = FALSE,na.last = TRUE):
sort(x$var3)
sort(x$var3, decreasing = TRUE)
# ordering function
x
x[order(x$var1),]
x[order(x$var1,x$var3),]

################################
# dealing with missing or null values
# we will look missing value with three perspective
# 01
# check na valuse exist
x <- c (1:4, NA, 6:7, NA)
x
is.na(x)

df <- data.frame(col=c(1:3,NA),col2 = c("this",NA,"is","text"),
                 col3=c(TRUE,FALSE,TRUE,TRUE),col4=c(2.5,4.2,3.2,NA), stringsAsFactors = FALSE)
is.na(df)
is.na(df$col3)
# to identify NA value location
which(is.na(x))
which(is.na(df))
sum(is.na(df))
colSums(is.na(df))
which(is.na(df$col4))
# 02
# recode/ impute NA value
x <- c (1:4, NA, 6:7, NA)
x
x[is.na(x)] <- mean(x,na.rm = TRUE)
x
x <- round(x,2)
x

df <- data.frame(col1=c(1:3,99),col2= c(2.5,4.2,99,3.2))
df
df[df==99] <- NA
df
#--------------------
df <- data.frame(col=c(1:3,NA),col2 = c("this",NA,"is","text"),
                 col3=c(TRUE,FALSE,TRUE,TRUE),col4=c(2.5,4.2,3.2,NA), stringsAsFactors = FALSE)
df
df$col4[is.na(df$col4)] <- mean(df$col4,na.rm = TRUE)
df
#03
# exclude missing values
x <- c(1:4, NA,6:7, NA)
mean(x)
mean(x,na.rm = TRUE)

# some times we drop the rows of missing values
df
# check all dataset which have or not na values
complete.cases(df)
# return only that rows which not have na vlaues
df[complete.cases(df),]
# return only that rows which have na values on 
df[!complete.cases(df),]

na.omit(df)
########################################
# exercise
dr<- datasets::airquality
dr
sum(is.na(dr))
colSums(is.na(dr))
dr$Ozone[is.na(dr$Ozone)] <- mean(dr$Ozone,na.rm = TRUE)
dr
colSums(is.na(dr))
dr$Solar.R[is.na(dr$Solar.R)] <- mean(dr$Solar.R,na.rm = TRUE)
colSums(is.na(dr))
dt <- dr<- datasets::airquality
dt
sum(is.na(dt))
colSums(is.na(dt))
f <- na.omit(dr)
colSums(is.na(f))
#####################################
# split data into a vectors
sp <- InsectSprays
sp
tapply(sp, sp$spray, sum)
#------------------
# implement split function based on spray col
spins <- split(InsectSprays$count,InsectSprays$spray)
spins
sprcount <- lapply(spins, sum)
sprcount
unlist(sprcount)
sapply(spins,sum)
##########################################
#merge/join data frame
# column wise merge use 
cbind()
# row wise merge
rbind()
#-----------
df1 <- data.frame(LETTERS, dfindex=1:26)
df2 <- data.frame(letters, dfindex=c(1:10,15,20,22:35))
df1
df2
# return rows when there is match in both table

merge(df1,df2)
# return all rows
merge(df1,df2,all = TRUE)
names(df1) <- c("alpha","lotsanumbers")
df1
# return
merge(df1,df2,by.x = "lotsanumbers",by.y = "dfindex")

########################################
# tidyverse
install.packages("dplyr")
install.packages("tidyr")
install.packages("tidyverse")
setwd("./data")
getwd()
#read file
msleep <- read.csv("msleep-200908-125135.csv")
head(msleep)
colnames(msleep)
#----------------------------------
library(tidyr)
library(dplyr)
#select
sleeptime <- dplyr::select(msleep, ï..name,sleep_total)
head(sleeptime)
# filter based on rows
dplyr::filter(msleep, order == "Carnivora")
# group it is use to group data based on catagorical
msleep <- read.csv("./data/msleep-200908-125135.csv")
head(msleep)
group <- group_by(msleep, genus,na.rm=TRUE)
group
levels(group$genus)
# mutate use to create new variable in a dataframe
mtcars_n <- mtcars
head(mtcars_n)
mtcars_n <- mutate(mtcars, mpg_cyl=mpg*cyl)
head(mtcars_n)
##########################
# pipline function %>%
# use to chain together functions and execute
library(datasets)
library(dplyr)
head(mtcars)
mtcars %>% group_by(cyl) %>% summarise(mean=mean(disp),n=n())

sub_m <- mtcars %>% select(mpg,cyl,disp,hp,gear,carb) %>% mutate(dispxhp = disp*hp)
names(sub_m)

table(sub_m$carb)

sub_m <- mtcars %>% select(mpg,cyl,disp,hp,gear,carb) %>% filter(carb %in% c(4,2,1))
head(sub_m)
table(sub_m$carb)

?n()
mtcars %>%
  select(mpg,cyl,disp,hp,gear,carb) %>%
  filter(carb %in% c(4,2,1)) %>%
  group_by(cyl) %>%
  summarise(hp_mean=mean(hp), disp_mean= mean(disp),n=n())

#--------------------------------------
# tidyr
# use for data manipulation
library(tidyr)
df <- data.frame(x=c("a:1","a:2","c:4","d:4"))
df
#separate
df %>% separate(x,c("key","values"), ":") %>% str

# spreade
# spread is categorical variable across other variables
data <- data.frame(variable1=rep(LETTERS[1:3],each=3),
                   variable2=rep(paste0("factor",c(1,2,3)),3),
                   num=1:9)
head(data)
spread(data, variable2, num)
# gather()
# use to group together data as key value pairs
library(dplyr)
library(tidyr)
head(iris)
mini_iris <- iris %>% group_by(Species) %>% slice(1)
head(mini_iris)
mini_iris %>% gather(key="flower_att",value =  "measurement", -Species)

# unite
# it use to merge data
library(datasets)
head(mtcars)
merged <- unite(mtcars,"vs_am", c("vs","am"))
head(merged)
#####################################
# dealing with text file
cameradata <- read.csv("./data/cameras.csv")
head(cameradata)
names(cameradata)
# tolower() function use to convert string into lower case
tolower(names(cameradata))
#-------------------------------------
# string split function
# good for automaticallu spilting variables
splitnames <- strsplit(names(cameradata),"\\.")
splitnames
splitnames[[5]]
splitnames[[6]]
splitnames[[6]][1]
# column rename 
firstelement <- function(x){x[1]}
sapply(splitnames,firstelement)
#--------------------------------------
# text mining library
install.packages("RColorBrewer")
library(NLP)
library(RColorBrewer)
library(wordcloud)
library(tm)
sentence <- c('this is mu 1st try example.','A person is nice','we can divide 10 with 2','Ahmed is Gentle man')
txt <- VCorpus(VectorSource(sentence))
txt
txt_data <- tm_map(txt, stripWhitespace)
txt_data
txt_data <- tm_map(txt_data,tolower)
txt_data 
txt_data <- tm_map(txt_data, removeNumbers)

#--------------------------


txt_data
txt_data <- tm_map(txt_data,removePunctuation)
txt_data
txt_data <- tm_map(txt_data, removeWords, stopwords("english"))
txt_data
# use define words to remove
txt_data <- tm_map(txt_data, removeWords, c("and", "the", "with"))
txt_data

df <- data.frame(cln_text= unlist(txt_data), stringsAsFactors = F)
df$ln_text
library(wordcloud)
wordcloud(txt_data)
#-------------------------------------
d <- read.csv('./data/cameras.csv')
head(d)
names(d)
# create wordcloud visual
library(wordcloud)
wd <- d$street
wd
wordcloud(wd,scale = c(10,0.5),random.order = FALSE,
          rot.per = 0.35, use.r.layout = FALSE,
          colors = brewer.pal(20,"Dark2"))
