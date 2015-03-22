README FOR tidy.txt and run_analysis.R

The purpose of the course project was to use raw data from the Human Activity Recognition Using Smartphones Dataset 
to create and independent tidy dataset which could be used for downstream analysis.

This project was completed using the statistical programming language R, and the script for this project is contained in the executable run_analysis.R

Ultimately, 10299 rows and 561 variables are distilled into an independent tidy dataset of 180 rows and 81 variables.

As described in more detailed in codebook.txt, 2 of the 81 variables correspond to the activity and subject.  The other 79 correspond the variables of interest,
which represent data collected by accelerometers inside Samsung Galaxy 2 smart phones worn by project participants.  

In short, there is one row of 79 averaged measurements for each of the 30 subjects for each of the six activities (described in more detail in codebook.txt)


Processing the data:

A 5 step process was used to process the original data into the independent and tidy dataset contained in tidy.txt

(From the assignment instructions and described in more detail comments contained within run_analysis.R)
You should create one R script called run_analysis.R that does the following. 
 
1. Merge the training and the test sets to create one data set.

	Fairly straightforward, used rbind() to combine the rows of the train and test sets

2. Extract only the measurements on the mean and standard deviation for each measurement. 

	From the original vector of 561 column names, only needed the names which corresponded
	to a mean or standard deviation.
	
	In seperate processes, used grep1() to identify column names containing the text "mean()" and "std()"
	
	Of the 561 original variable names, 79 satisfied these conditions
	
	The variable names from mean and std were combined into one vector called "two"
	

3. Use descriptive activity names to name the activities in the data set

	For this step, the qdap package was used.  qdap was used because it contained a handy
	function called lookup() which acts like "vlookup()" in Microsoft Excel.
	
	For each of the activities, labeled 1-6, the activity description were populated over 
	from the labels contained within activity_labels.txt 

4. Appropriately label the data set with descriptive variable names.

	The goal of this step is simply to replace the original column names of two
	Which prior to this step are labled V1, V2, V3, V43, etc. with their corresponding 
	descriptive names, i.e. tBodyAcc-mean()-Y, tGravityAcc-mean()-Y, etc.

5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject. 

	For this step, the dplyr package was used.  dplr was used because it contained a couple functions in particular
	which makes it much easier to transform the original data frame into an independent tidy dataset for submission.
	
	In particular, group_by() was used to group the data frame "two" by activitydesc and subject.  The result was stored in the object "five"
	
	Then, summarise_each() was used to aggregate the data frame "five" by the mean of each of the 79 variables by activity and by subject.
	
	The final substep for step 5 is to officially create tidy.txt for submission.  
	
tidy.txt is tidy since there is only one observation per row, each variable forms a column, and there is only one type of observation in this file, that is, accelerometer measurements.


More info regarding the r script used contained within the comments of run_analysis.R

More info regarding the variables of interest tidy.txt contained within codebook.txt

Original README for original data below citation



CITATION:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 
21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.




ORIGINAL README CONTAINED WITH ORIGINAL DATA SET BELOW
======================================================================================================================================================================================================
======================================================================================================================================================================================================


==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
