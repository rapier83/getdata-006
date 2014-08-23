#code book

This script is consist of four columns.

* The first two columns from `activity_label.txt`, and `subject_test.txt` `./train` and `./test` folder.
* Third columns is type of variable. original name is `features_info.txt` and columns name is changed
	- "t" change to "Time" and f change to "Fast Fourie Transform applied" They will be after "|"
	- other terms change readable words. For example, "BodyAcc" changes to "Body Acceleration" 
	- "mean" and "stardard derivative" is on head of sentence. It changes to "Mean of ..." or "Stardard derivative of ..."
	- X,Y,Z change to "...-axis"
	- Jerk to Jerk signal and Mag to Euclidean norm, if there no word, then nothing.
