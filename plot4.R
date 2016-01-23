##################################################################
# source-file: plot4.R
#
#          Plotting Power Consumption IV
#
# Source: Exploratory Data Analysis via Coursera and JHU,
#         Assigment 01
#
#
# What this file does:
#     A. download data from UCI Machine Learning Repository
#     B. read data into R
#     C. inspects / recodes data
#     D. plot the multiple plots of plot4.png
#
# Output:
#    1. plot4.png - a histogram 
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

png( 'plot4.png' )
par(mfrow=c(2,2)) # set up 2 by 2 environment

# right-top
# time series of active power
plot(Power.data$date.time,
     Power.data$global.active.power,
     type='l',
     xlab = '',
     ylab = 'Global Active Power (kilowatts)'
)
# left-top
# time series of voltage
plot(Power.data$date.time,
     Power.data$voltage,
     type = 'l',
     xlab = "datetime"
)
# right - bottom
# time series sub-metering
plot(Power.data$date.time,
     Power.data$sub.metering.1,
     type = 'l',
     xlab = '',
     ylab = 'Energy sub metering'
)
lines(Power.data$date.time,
      Power.data$sub.metering.2,
      type = 'l',
      col = 'red'
)
lines(Power.data$date.time,
      Power.data$sub.metering.3,
      type = 'l',
      col = 'blue'
)
legend('topright',
       lty = c(1, 1, 1),
       col = c('black', 'blue', 'red'),
       legend = c('Metering 1', 'Metering 2', 'Metering 3')
)

# left-bottom
# time series of reactive power
plot(Power.data$date.time,
     Power.data$global.reactive.power,
     type = 'l',
     xlab = "datetime"
)
dev.off()
