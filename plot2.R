##################################################################
# source-file: plot2.R
#
#          Plotting Power Consumption II
#
# Source: Exploratory Data Analysis via Coursera and JHU,
#         Assigment 01
#
#
# What this file does:
#     A. download data from UCI Machine Learning Repository
#     B. read data into R
#     C. inspects / recodes data
#     D. plot the time series data to produce plot2.png
#
# Output:
#    1. plot2.png - a histogram 
#
# Author(s) : Lachlan Deer (LD)
#
# Contact: @lachlandeer
#
# Edit History:
# 2016-01-22 - LD - Created File
##################################################################

setwd("~/../Dropbox (Personal)/TeachingAndLearning/Coursera/DataScience/4_ExpDataAnalysis/Assignment/ExData_Plotting1")
getwd( )

## ----- A. Get Data ----- ##

# download from online
file.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
file.destination <- 'power.consumption.zip'
download.file( file.url, file.destination )

# unzip
source.file <- unzip( file.destination, list = TRUE )$Name
unzip( file.destination )
file.remove( file.destination )
rm( file.url )
rm( file.destination )


## ----- B. Load Data and save as Rda format ----- ##

Power.data <- read.table( source.file, header = TRUE, sep = ';', na.strings = '?' )
save( Power.data, file = 'Power.data.RData' )
file.remove( source.file )
rm( source.file )


## ----- C. Inspect and Recode Data ----- ##

# Renaming Variables
new.names <- gsub( '_', '.', names(Power.data)  ) # convert "_" to "."
new.names <- tolower( new.names )                 # convert all names to lower case   
names( Power.data ) <- new.names                  # write over the sames
rm( new.names )

# recode dates and times
Power.data$date <- as.Date( Power.data$date, '%d/%m/%Y' )
Power.data$date.time <- strptime( 
  paste(
    Power.data$date,
    Power.data$time
  ),
  format="%Y-%m-%d %H:%M:%S"
)

# Subset data for what we need
Power.data <- subset( Power.data, date == '2007-02-01' | date == '2007-02-02' ) 

## ----- D. Generate Time Series ----- ##

png( 'plot2.png' ) 
plot(Power.data$date.time, 
        Power.data$global.active.power, 
        type='l', 
        xlab = '', 
        ylab = 'Global Active Power (kilowatts)' 
        ) 
dev.off() 
