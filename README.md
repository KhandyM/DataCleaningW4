# Readme 

This document describes the inner workings of `run_analysis.R`.

The code is separated into the following sections:

* Loading the required packages 
* Downloading the data
* Creating the data tables
* Manipulating the resulting data tables Including the aggregation
* Writing final data to CSV

## Loading the required packages

The following packages were necessary:
* dplyr
* data.table
* tidyr
* RCurl

## Downloading the data

This section downloads the given url to a local destination file. It also creates a `data` directory if it doesn't exist as well as unzipping the incoming file.


## Creating the data tables

This section reads dataset files from UCI HAR and assigns names and prefixes. Known names are "train" and "test". Known prefixes are "X", "y" and "subject".

Within the variable names the following manipulations are executed
* Leading t or f is replaced with time or frequency respectively
* Body remains unchanged
* Gravity remains unchanged
* Acc changed to Accelerometer
* std() changed to SD
* mean() changed to MEAN
* Gyro changed to Gyroscope
* Mag changed to Magnitude 

Meaning the original variables:
  $ subject                    
  $ activityName               
  $ activityNum                
  $ tBodyAcc-mean()-X          
  $ tBodyAcc-mean()-Y          
  $ tBodyAcc-mean()-Z          
  $ tBodyAcc-std()-X           
  $ tBodyAcc-std()-Y           
  $ tBodyAcc-std()-Z           
  $ tGravityAcc-mean()-X       
  $ tGravityAcc-mean()-Y       
  $ tGravityAcc-mean()-Z       
  $ tGravityAcc-std()-X        
  $ tGravityAcc-std()-Y        
  $ tGravityAcc-std()-Z        
  $ tBodyAccJerk-mean()-X      
  $ tBodyAccJerk-mean()-Y      
  $ tBodyAccJerk-mean()-Z      
  $ tBodyAccJerk-std()-X       
  $ tBodyAccJerk-std()-Y       
  $ tBodyAccJerk-std()-Z       
  $ tBodyGyro-mean()-X         
  $ tBodyGyro-mean()-Y         
  $ tBodyGyro-mean()-Z         
  $ tBodyGyro-std()-X          
  $ tBodyGyro-std()-Y          
  $ tBodyGyro-std()-Z          
  $ tBodyGyroJerk-mean()-X     
  $ tBodyGyroJerk-mean()-Y     
  $ tBodyGyroJerk-mean()-Z     
  $ tBodyGyroJerk-std()-X      
  $ tBodyGyroJerk-std()-Y      
  $ tBodyGyroJerk-std()-Z      
  $ tBodyAccMag-mean()         
  $ tBodyAccMag-std()          
  $ tGravityAccMag-mean()      
  $ tGravityAccMag-std()       
  $ tBodyAccJerkMag-mean()     
  $ tBodyAccJerkMag-std()      
  $ tBodyGyroMag-mean()        
  $ tBodyGyroMag-std()         
  $ tBodyGyroJerkMag-mean()    
  $ tBodyGyroJerkMag-std()     
  $ fBodyAcc-mean()-X          
  $ fBodyAcc-mean()-Y          
  $ fBodyAcc-mean()-Z          
  $ fBodyAcc-std()-X           
  $ fBodyAcc-std()-Y           
  $ fBodyAcc-std()-Z           
  $ fBodyAccJerk-mean()-X      
  $ fBodyAccJerk-mean()-Y      
  $ fBodyAccJerk-mean()-Z      
  $ fBodyAccJerk-std()-X       
  $ fBodyAccJerk-std()-Y       
  $ fBodyAccJerk-std()-Z       
  $ fBodyGyro-mean()-X         
  $ fBodyGyro-mean()-Y         
  $ fBodyGyro-mean()-Z         
  $ fBodyGyro-std()-X          
  $ fBodyGyro-std()-Y          
  $ fBodyGyro-std()-Z          
  $ fBodyAccMag-mean()         
  $ fBodyAccMag-std()          
  $ fBodyBodyAccJerkMag-mean() 
  $ fBodyBodyAccJerkMag-std()  
  $ fBodyBodyGyroMag-mean()    
  $ fBodyBodyGyroMag-std()     
  $ fBodyBodyGyroJerkMag-mean()
  $ fBodyBodyGyroJerkMag-std()

Become:


  $ subject                                       
  $ activityName                                  
  $ activityNum                                   
  $ timeBodyAccelerometer-MEAN()-X                
  $ timeBodyAccelerometer-MEAN()-Y                
  $ timeBodyAccelerometer-MEAN()-Z                
  $ timeBodyAccelerometer-SD()-X                  
  $ timeBodyAccelerometer-SD()-Y                  
  $ timeBodyAccelerometer-SD()-Z                  
  $ timeGravityAccelerometer-MEAN()-X             
  $ timeGravityAccelerometer-MEAN()-Y             
  $ timeGravityAccelerometer-MEAN()-Z             
  $ timeGravityAccelerometer-SD()-X               
  $ timeGravityAccelerometer-SD()-Y               
  $ timeGravityAccelerometer-SD()-Z               
  $ timeBodyAccelerometerJerk-MEAN()-X            
  $ timeBodyAccelerometerJerk-MEAN()-Y            
  $ timeBodyAccelerometerJerk-MEAN()-Z            
  $ timeBodyAccelerometerJerk-SD()-X              
  $ timeBodyAccelerometerJerk-SD()-Y              
  $ timeBodyAccelerometerJerk-SD()-Z              
  $ timeBodyGyroscope-MEAN()-X                    
  $ timeBodyGyroscope-MEAN()-Y                    
  $ timeBodyGyroscope-MEAN()-Z                    
  $ timeBodyGyroscope-SD()-X                      
  $ timeBodyGyroscope-SD()-Y                      
  $ timeBodyGyroscope-SD()-Z                      
  $ timeBodyGyroscopeJerk-MEAN()-X                
  $ timeBodyGyroscopeJerk-MEAN()-Y                
  $ timeBodyGyroscopeJerk-MEAN()-Z                
  $ timeBodyGyroscopeJerk-SD()-X                  
  $ timeBodyGyroscopeJerk-SD()-Y                  
  $ timeBodyGyroscopeJerk-SD()-Z                  
  $ timeBodyAccelerometerMagnitude-MEAN()         
  $ timeBodyAccelerometerMagnitude-SD()           
  $ timeGravityAccelerometerMagnitude-MEAN()      
  $ timeGravityAccelerometerMagnitude-SD()        
  $ timeBodyAccelerometerJerkMagnitude-MEAN()     
  $ timeBodyAccelerometerJerkMagnitude-SD()       
  $ timeBodyGyroscopeMagnitude-MEAN()             
  $ timeBodyGyroscopeMagnitude-SD()               
  $ timeBodyGyroscopeJerkMagnitude-MEAN()         
  $ timeBodyGyroscopeJerkMagnitude-SD()           
  $ frequencyBodyAccelerometer-MEAN()-X           
  $ frequencyBodyAccelerometer-MEAN()-Y           
  $ frequencyBodyAccelerometer-MEAN()-Z           
  $ frequencyBodyAccelerometer-SD()-X             
  $ frequencyBodyAccelerometer-SD()-Y             
  $ frequencyBodyAccelerometer-SD()-Z             
  $ frequencyBodyAccelerometerJerk-MEAN()-X       
  $ frequencyBodyAccelerometerJerk-MEAN()-Y       
  $ frequencyBodyAccelerometerJerk-MEAN()-Z       
  $ frequencyBodyAccelerometerJerk-SD()-X         
  $ frequencyBodyAccelerometerJerk-SD()-Y         
  $ frequencyBodyAccelerometerJerk-SD()-Z         
  $ frequencyBodyGyroscope-MEAN()-X               
  $ frequencyBodyGyroscope-MEAN()-Y               
  $ frequencyBodyGyroscope-MEAN()-Z               
  $ frequencyBodyGyroscope-SD()-X                 
  $ frequencyBodyGyroscope-SD()-Y                 
  $ frequencyBodyGyroscope-SD()-Z                 
  $ frequencyBodyAccelerometerMagnitude-MEAN()    
  $ frequencyBodyAccelerometerMagnitude-SD()      
  $ frequencyBodyAccelerometerJerkMagnitude-MEAN()
  $ frequencyBodyAccelerometerJerkMagnitude-SD()  
  $ frequencyBodyGyroscopeMagnitude-MEAN()        
  $ frequencyBodyGyroscopeMagnitude-SD()          
  $ frequencyBodyGyroscopeJerkMagnitude-MEAN()    
  $ frequencyBodyGyroscopeJerkMagnitude-SD()    

 Writing final data to CSV


