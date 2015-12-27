This is the README file for the course assignment for Getting and Cleaning Data course

The data set is found in the zip file at this link: [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

I used a few resources to help me do this assignment, especially
  [Hadley Wickham's guide to tidy data](http://vita.had.co.nz/papers/tidy-data.pdf) and 
  [thoughtfulbloke's hints](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/).
  I also used a lot of google and the lecture notes to try to figure out how to get R to do what I was trying to get it to do.
  
My code is not elegant.  I am not an experienced programmer and I had to break things down into chunks to be able to even begin to try to get this assignment right.  I don't like using underscores in my variable names so that is why they are all clunked together.  I also hate using the assignment arrow when the equals sign works perfectly well.  I followed the discussion pertaining to this in the class forums and besides style, I don't see any reason to waste keystrokes on the arrow when the same thing is accomplished by the equals sign.  Since the assignment doesn't give style points, I hope that won't be held against me when it comes to peer grading.

I set my working directory as the Documents folder on my C: drive.  The run_analysis.R script assumes that you have downloaded the data set, unzipped it, and placed all the relevant files in your working directory.  I ignored the Inertial Signals folders in both the test and train folders so there is no need to place those files in your working directory.

In the repo you will find the run_analysis.R file which performs the steps required by the assigment, the CodeBook.md file which describes each variable.

My script works as described below.  This was the easiest way for me to attack the program, but I'm sure it looks like a complete kludge to what I'm assuming is everyone else taking this class who are undoubtedly much smarter than I am.
  1. I started with all the files copied into my working directory with no changes made to them whatsoever.
  2. The script loads the plyr package to make it easier to split the final dataframe and find the means at the end of the assignment.
  3. Then it reads the test data into the workspace.
  4. Then it reads the training data into the workspace.
  5. Then it joins the training and test tables.
  6. Then it creates the activity ID label vector.
  7. Then it creates the subject ID vector.
  8. Then it gets the variable names from the features.txt file and adds them to the test and training data combined table.
  9. Then it uses the grep function to narrow the table down to only variables containing mean and std in their names.
  10. Then it replaces the integers representing the activity IDs with the descriptions of the activities.
  11. Then it joins the subject ID, activity ID, and combined test and training data into one table using cbind.
  12. Then it changes the variable names to remove parenthesis and make them more readable such as substituting full words for abbreviations.
  13. Then it uses ddplyr to split the dataframe and calculate the means of the columns with mean and std values.
  14. Then it writes the resulting tidy data to a text file.

I also uploaded my text file containing the tidy data to this repo in case I had to link to it due to difficulties with how it looked when I uploaded the file directly.  It looks fine in Notepad++ and when I read it back into R but for some reason directly uploading the file makes it not look right.  All the variables are clumped together at the top in several rows with the observations below, also clumped together.

Thanks for reading.  Please go easy on me on the grading.
