### Introduction

The run_analysis.r loads, puts together and processes the given data according to the course project's description. It creates a new independent data set which complies the principles of tidy data. 

### How it works

The script follows the main step-by-step description, but with one minor permutation. It seemed easier to me to perform step 4 along with step 1 and name variables with descriptive feature names from the file *features.txt*.

At step 1 the script loads test and train data sets. Each data set consists of three components:

    1. X_[test/train].txt which contains measurement feature vectors
    2. y_[test/train].txt which contains activity labels for each observation
    3. subject_[test/train].txt which contains subject labels for each observation

The script puts them together with appropriate descriptive names.

At step 2 the combined data set is filtered to retain only the measurements on the mean and standard deviation. I decided to include not only -mean() measurements but also -meanFreq() which corresponds to the values of mean frequency. 

At step 3 the script substitutes numeric activity labels with the descriptive strings from the file *activity_labels.txt*. I did it by factorizing the Activity column with new levels names. 

At step 5 the script perform "tidying" data via libraries reshaping2 and plyr. We reshape the data to transform it to narrow from, and then aggregate the resulting data set with the mean of each variable for each activity and each subject.

### Why the resulting data is tidy

The resulting data set meets the main three principles of tidy data

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

It depends on goals of your study what *observation* and *variable* terms mean. Based on the structure of the resulting data set I suggested that each observation is the aggregated value of the measurement grouped by subject and activity type. Respectively, variables are *Subject*, *Activity* and *Measurement*.

### References

 * David's Project FAQ -- https://class.coursera.org/getdata-009/forum/thread?thread_id=58
 * Tidy Data And The Assignment -- https://class.coursera.org/getdata-009/forum/thread?thread_id=192
 * Hadley Wickham, Tidy Data -- http://vita.had.co.nz/papers/tidy-data.pdf