# Gettign and Cleaning Data Course Project

this script code is consist of below functions

* **getColName**: it get columns name and number include "mean()" and "std()" by using grep function
* **getData** : It is main function get result.
* **getDataSet** 
	- argument: Test set and Train set have same directory structure. So, I wrote code get argument "test" or "train" and use it for file name to `read.table` function
	- After reading X_test(train), y_test(train) bind all columns
	- And change to long type by using `melt`
* **labelToDesc**: It changes labels to readable
