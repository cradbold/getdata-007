getdata-007
===========

Note: The data used in this project requires a license to be echoed; the run_analysis.R script begins with this license.

The script begins by securing the data, either directly from URL via download or by assuming the ZIP file is located in the current working directory.  From there, the script organizes the subsequent relative locations of data files.

The script immediately loads two sets of data, small tables containing headings for subsequent data and a table of activities by ids used in subsequent data, respectively.  Some minor formatting is performed.

Next, the script loads test data into a master table by combining test subject ids with activities and test data.  The activities were retrieved as factors via a join-merge on id between the raw test labels data and the aforementioned table of activities.  The test data was modified to include headings from the aforementioned table containing headings.

Next, the script loads train data into a master table using a process analogous to the previous loading process.

Finally, a unified master table is created by merging the rows of the test and train data -- by definition, they have the same columns.  A new data table is created from the unified master table by performing the mean function across two groups: subject (id) and activity.  That resultant data table was then written to file.

Cleanup was performed to ensure maximum available memory.

Note: some items may be commented-out but remain because they have value in development/debugging.