quiz1 <- function() {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(url,destfile = "./data/2006housing.csv", method="curl")
    x <- read.csv("./data/2006housing.csv")
    print(strsplit(names(x),"wgtp"))
}

quiz2 <- function() {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    dest <- "./data/gdp.csv"
    download.file(url,destfile = dest, method="curl")
    x <- read.csv(dest, skip=4)
    gdp <- as.numeric(gsub(",","",x[,5]))
    print(mean(gdp[1:194],ra.rm=TRUE))
}

quiz3 <- function() {
    quiz2()
    dest <- "./data/gdp.csv"
    x <- read.csv(dest, skip=4)
    print(grep("^United",x[,4]))
    
}

quiz4 <- function() {
    quiz2()
    x <- read.csv("./data/gdp.csv")
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
    dest <- "./data/eduData.csv"
    download.file(url,destfile = dest, method="curl")
    y <- read.csv("./data/eduData.csv")
    z <- merge(x,y,by.x="X",by.y="CountryCode")
    f <- z[c(grep("*[Ff]iscal*",z[,19])),19]
    print(length(grep("*[Jj]une*",f)))   
}

quiz5 <- function() {
    library(quantmod)
    amzn <- getSymbols("AMZN",auto.assign=FALSE)
    sampleTime = index(amzn)
    y2012 <- subset(sampleTimes, sampleTimes > as.Date("2012-01-01","%Y-%m-%d") &
            sampleTimes < as.Date("20130101","%Y%m%d"))
    timedf <- data.frame(date=c(y2012))
    timedf$days <- weekdays(as.Date(y2012))
    print(sum(timedf$days =="Monday"))
}