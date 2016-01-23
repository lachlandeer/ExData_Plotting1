##################################################################
# source-file: plot3.R
#
#          Plotting Power Consumption III
#
# Source: Exploratory Data Analysis via Coursera and JHU,
#         Assigment 01
#
#
# What this file does:
#     A. download data from UCI Machine Learning Repository
#     B. read data into R
#     C. inspects / recodes data
#     D. plot the multiple time series data to produce plot3.png
#
# Output:
#    1. plot3.png - a histogram 
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
file.destination <- 'Power.data.zip'
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

## ----- D. Generate Multiple Time Series ----- ##

png( 'plot3.png' )

# submetering 1
plot(Power.data$date.time,
     Power.data$sub.metering.1,
     type = 'l',
     xlab = '',
     ylab = 'Energy sub metering'
)
# submetering 2
lines(Power.data$date.time,
      Power.data$sub.metering.2,
      type = 'l',
      col = 'red'
)
#submetering 3
lines(Power.data$date.time,
      Power.data$sub.metering.3,
      type = 'l',
      col = 'blue'
)
#add legend
legend('topright',
       lty = c(1, 1, 1),
       col = c('black', 'blue', 'red'),
       legend = c('Metering 1', 'Metering 2', 'Metering 3') )
dev.off()