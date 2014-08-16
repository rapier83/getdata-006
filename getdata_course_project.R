if(!file.exists("./dataset")){
    dir.create("./dataset")
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                  destfile = "./dataset.zip",
                  method="curl")
    unzip("./dataset.zip")
}
