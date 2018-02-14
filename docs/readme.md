## Date Dec 08 2017

The project that I have chosen for the course suppliement in algorithm in bioinformatics is based on pathology Atlas data. Directly lifted from the main page, the major task that have to completed are as follows:

* Download data on survival times for liver cancer patients as well as expression data from their sequenced tumors.
* For each transcript, create a survival analysis model, using the lifelines package.  Here each transcript can be tested using, for instance, a Cox’s Proportional Hazard model. Test each transcript by itself as a potential prognostic marker for the survival of the patients.
* As before, apply multiple hypothesis corrections to your calculated p-values.
* Report the number of expression levels that you find prognostic for the survival of the patients in the cohort as a function of q-value.

Now the major of the task will be updated in the notebook associated with this page.

The first thing is to break dowm the task in hands to smaller tasks and completeing it before jumping into finalized analysis.

#### Understanding the data format:
    
    First of all the file is provided as the txt files and contains the following information in it. 
    The txt file consists of the different types of TCGA ids along with the along with the metadata that consists of information such as gender, Race, stage of cancer, Living days, and gene expression data.
    
    A general skim through the file gives the infomation that there is around 19572 genes with different expression data. 
    
#### pseudo code for the tasks
    First thing to do is read the files in python as dataframe files.
    Then to seperate out the genes expression  data from the other meta information.
    use of the package to these expression data set and get the hazard cox results
    \part{}

