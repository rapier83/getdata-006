# Check Folder and Text file 
if(!file.exists("./UCI HAR Dataset") |
                !file.exists("./UCI HAR Dataset/test") |
                !file.exists("./UCI HAR Dataset/train")
                ) {
    stop("No data Folder!")
}

if(!file.exists("./UCI HAR Dataset")){
    dir.create("./UCI HAR Dataset")
    if(!file.exists("./UCI HAR Dataset/*.txt")) {
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      destfile = "./UCI HAR Dataset.zip",
                      method="curl")
        unzip("./UCI HAR Dataset.zip")
        
    }
}

# Extract the measurements
# on the mean and standard deviation in the features
getColName <- function(path="./UCI HAR Dataset/features.txt") {
    feature <- read.table(path)
    mean_col <- grep("*mean\\(\\)*",feature$V2)
    std_col <- grep("*std\\(\\)*",feature$V2)
    colsNum <- sort(c(mean_col,std_col))
    colsName <- feature$V2[colsNum]
    return(list(colsNum=colsNum, colsName=colsName))
}

#merge test and traing set
getData <- function() {
    df <- rbind(getDataSet("test"),getDataSet("train"))
    # write.table(df, file="data.txt",row.name=FALSE)
    # print("File exported : ./data.txt")
    return(df)
}

getDataSet <- function(type=character()) {
    if (!(type %in% c("test","train"))) {
        stop(paste("there's no type of","\"",type,"\""))
    }
    col <- getColName()
    col$colsName <- as.character(col$colsName)
    for (i in 1:length(col$colsName)) {
        col$colsName[i] <- labelToDesc(col$colsName[i])
    }
    
    filename <- c(paste("./UCI HAR Dataset/",type,"/X_",type,".txt",sep=""),
                  paste("./UCI HAR Dataset/",type,"/y_",type,".txt",sep=""),
                  paste("./UCI HAR Dataset/",type,"/subject_",type,".txt",sep="")
    )
    labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    
    #read X_
    x <- read.table(filename[1])[,col$colsNum]
    
    #read y_ and apply label
    y <- read.table(filename[2])
    y_Labeled <- lapply(y,function(x) labels[y[x,],][2])
    
    # Bind all columns and conver to skinny set
    s <- read.table(filename[3])
    df <- as.data.frame(cbind(y_Labeled,s,x))
    colnames(df) <- c("Activity","Subject",as.character(col$colsName))
    df <- melt(df,id=c("Activity","Subject"))
    df[,3] <- as.character(df[,3])
    return(df)
}

labelToDesc <- function(l) {

    ifelse(substr(l,1,1) == "t",fft <- " | Time",
            ifelse(substr(l,1,1) == "f",fft <- " | Fast Fourie Transform applied",
                   fft <- "")
    )
            
    ifelse(substr(l,nchar(l),nchar(l)) == "X", axis <- " X-axis",
           ifelse(substr(l,nchar(l),nchar(l)) == "Y",axis <- " Y-axis",
                  ifelse(substr(l,nchar(l),nchar(l)) == "Z",axis <- " Z-axis",
                         axis <- "")
           )
    )
    
    
    ifelse(grepl("*BodyAcc*",l) == TRUE, type <- "Body Acceleration",
           ifelse(grepl("*GravityAcc",l) == TRUE, type <- "Gravity Acceleration",
                  ifelse(grepl("*BodyGyro*",l) == TRUE, type <- "Body Gryo",
                         type <- "")
           )
    )
    
    ifelse(grepl("*mean\\(\\)*",l) == TRUE, cal <- "Mean of ",
           ifelse(grepl("*std\\(\\)*",l) == TRUE, cal <- "Standard Derivative of ",
                  cal <- "")
    )
    
    ifelse(grepl("*Jerk*",l) == TRUE, jerk <- " Jerk signal",jerk <- "")
    ifelse(grepl("*Mag*",l) == TRUE, mag <- " Euclidean norm", mag <- "")
    
    return(paste(cal, type, jerk, mag, axis, fft, sep = ""))
}
