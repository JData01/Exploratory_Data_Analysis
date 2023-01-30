library(dplyr)

# LOADING THE DATA
# “Individual household electric power consumption Data Set”
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

df <- data.frame(read.csv("household_power_consumption.txt",sep=";"))
# info on the dataframe
# head(df)
# dim(df) #[1] 2075259    9   
# make sure the columns are in the right format
df <- mutate(df, Date= as.Date(Date, format="%d/%m/%Y"))
# df <- mutate(df, Time= strptime(Time, format="%H:%M:%S")) #??????
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Global_intensity <- as.numeric(as.character(df$Global_intensity))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
# str(df)

# subset the dataframe between 2007-02-01 and 2007-02-02
df_2007 <- df[df$Date >= "2007-02-01" & df$Date <= "2007-02-02", ]
df_2007["date.time"] <- as.POSIXct(paste(df_2007$Date, df_2007$Time), format="%Y-%m-%d %H:%M:%S")
# head(df_2007)

# MAKING PLOTS

# PLOT 4
png(file="Plot4.png",width=480, height=480)
par(mfrow=c(2,2))
plot(df_2007$date.time, df_2007$Global_active_power, type = "l", lty = 1, xlab="", ylab="Global Active Power")
plot(df_2007$date.time, df_2007$Voltage, type = "l", lty = 1, xlab="datetime", ylab="Voltage")
plot(df_2007$date.time, df_2007$Sub_metering_1, type = "l", lty = 1, col="black", xlab="", ylab="Energy sub metering")
lines(df_2007$date.time, df_2007$Sub_metering_2, type = "l", lty = 1, col="red")
lines(df_2007$date.time, df_2007$Sub_metering_3, type = "l", lty = 1, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, box.lty=0)
plot(df_2007$date.time, df_2007.2$Global_reactive_power, type = "l", lty = 1, lwd=1, xlab="datetime", ylab="Global Active Power")
dev.off()