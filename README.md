*This README should be reviewed alongside the run_analysis.R script where each section of code is explained below.*

The script begins with a commented version of the required data license for all publications (public github repo)

1. The script begins by securing the data, either directly from URL via download or by assuming the ZIP file is located in the current working directory.  From there, the script organizes the subsequent relative locations of data files.

2. The script then loads a data table containing headings for subsequent data.  It reduces the headings to a single vector so that it can be easily bound to a later table.

3. The script then loads a data table of activities by ids used in later data.  Some minor formatting is performed to label table headings and coerce the values as factors.

4. Next, the script loads test data into a master table by combining test subject ids with activities and test data.  The activities were retrieved via a join-merge on id between the raw test labels data and the aforementioned table of activities.  The test data was modified to include headings from the aforementioned table containing headings.

5. Next, the script loads train data into a master table using a process analogous to the previous loading process.

6. A unified master table is created by merging the rows of the test and train data -- by definition, they have the same columns.

7. A new data table is created from the unified master table by performing the mean function across two groups: subject (id) and activity.  The column headings of this new table are updated to reflect average values.  The resultant data table is then written to file.

8. Cleanup was performed to ensure maximum available memory.

*Note: some items may be commented-out but remain because they have value in development/debugging.*