""" Email: code... I want to develop it further.. need more data to increase the efficiency...
Mention github link in email : https://github.com/sohomghosh/company_clustering
"""
Hello!

This is the file to start with. Link for the  GitHub repository is:- 
https://github.com/sohomghosh/company_clustering

Approach:-
Entity Recognition & Text Clustering are one of the challenging tasks in Text Analytics. In this repository, I am presenting few codes to deal with such challenges. The objective is to cluster companies based on their names. In order to do so two approaches are being used :- 1> Clustering based on Common subsequence of characters 2> Converting names of companies to character vectors (features). Clustering is done based on correlation between these vectors.
Firstly, as a pre-processing step the special characters and blank spaces have been removed using regular expressions.
	Method-1:
		Clustering based on common sequence of characters. Each of the names of the companies in the test set is compared with all the names of the companies 
	Method-2:
		Clustering based on correlation of feature vectors. Here, a feature set has been constructed from the names of the companies. The features are the frequency of occurence of characters.
	Challenges:
		Setting a optimal threshold for deciding to call it a match in both the methods is an interesting task. The sample being less in size results in less overlapping between train & test data.
		Higher values of threshold results in creation of many singleton clusters, whereas setting a low threshold (= 10, as done here in order to show case the probabilistic approach) results in different companies (like hcl services & akash services) getting clubbed together.

References:-
1) http://www.cs.umd.edu/~getoor/Tutorials/ER_VLDB2012.pdf
2) http://precog.iiitd.edu.in/Publications_files/Paridhi_Jain_Comprehensive_Report_Spring_2013.pdf
3) http://vldb.org/pvldb/vol5/p2018_lisegetoor_vldb2012.pdf 
4) https://cran.r-project.org/web/packages/qualV/index.html
5) https://cran.r-project.org/web/packages/stringdist/stringdist.pdf

PS: There is no specific reason to use 2 languages R, Python to do the task. This is just to showcase my skills.
------------------------------------------------------------------------------------------------------------

									#####INSTALLATION#####
Step_1: Install python 2.7 [preferably the Anaconda version from https://www.continuum.io/downloads]
#Please note: The "preprocess.py" file, the Traing file "company-clusters-sample.txt", the Test file "unmapped-sample.txt" should be present in the same directory

Step_2: Install R 3.3.2 [Link: https://cran.r-project.org/]
#In the R console write the following command to install the package qualV
install.packages("qualV")
setwd("<path_of_the_directory_containing_the_python_files_and_data_files>") #This is to set the working directory

									#####EXECUTION#####
Run the python file "preprocess.py" first. It will take the data files: "company-clusters-sample.txt" & "unmapped-sample.txt" as input, preprocess them and  generate 2 files titled "company-clusters-sample-preprocessed.csv" and "unmapped-sample-preprocessed.csv" as output.
This should be followed by the execution of R file "model_code.R". It will take the two above mentioned files as input and create 4 files : "updated_company_cluster_sample.csv","cluster_distribution.csv","updated_company_cluster_sample_v2.csv","cluster_distribution_v2.csv". These 4 files are the results.

									#####TESTING#####
The new words (name of companies) are assigned to clusters with certain probability. Refer to file "cluster_distribution.csv","cluster_distribution_v2.csv" for details.
The updated list of companies (updated variant file) and the clusters they belong to are present in "updated_company_cluster_sample.csv","updated_company_cluster_sample_v2.csv".
To test this program against new set of inputs please provide it a new test file "unmapped-sample.txt" in the same format.

NOTE: Please train the algorithm with more data before testing it to evaluate its efficiency correctly
------------------------------------------------------------------------------------------------------------

									#####ASSESSMENT & CLOSING THOUGHTS#####
Issues- The complexity of the algorithm needs to be reduced. Presently it takes high time to compute. It needs to be optimized. Here the samples are traversed linearly. It takes O(n) time. This can be reduced to O(log(n)) by sorting the data and using binary search on that.  

FUTURE WORKS:- Common terms like "services", "private", "limited" may be removed for better results.
Removing white spaces and special characters in the very first step makes it difficult for restoring back the original string.
Machine learning algorithms for probabilistic classification may be used for assigning clusters.
The output of the above methods may be ensembled to produce better results.