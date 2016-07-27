## Transformation of the data matrix  
#### A Galaxy module from the [Workflow4metabolomics](http://workflow4metabolomics.org) project

### Description

**Version:** 2.0.2  
**Date:** 2016-07-27  
**Author:** Etienne A. Thevenot (CEA, LIST, MetaboHUB, W4M Core Development Team)   
**Email:** [etienne.thevenot(at)cea.fr](mailto:etienne.thevenot@cea.fr)  
**Citation:** Thevenot E.A., Roux A., Xu Y., Ezan E. and Junot C. (2015). Analysis of the human adult urinary metabolome variations with age, body mass index and gender by implementing a comprehensive workflow for univariate and OPLS statistical analyses. *Journal of Proteome Research*, **14**:3322-3335. [doi:10.1021/acs.jproteome.5b00354](http://dx.doi.org/10.1021/acs.jproteome.5b00354)  
**Licence:** CeCILL
**Reference history:** [W4M00001b_sacurine_complete](http://galaxy.workflow4metabolomics.org/history/list_published)     
**Funding:** Agence Nationale de la Recherche ([MetaboHUB](http://www.metabohub.fr/index.php?lang=en&Itemid=473) national infrastructure for metabolomics and fluxomics, ANR-11-INBS-0010 grant)

### Installation

* Configuration file: **transformation_config.xml**
* Image files: **static/images/transformation_workflowPositionImage.png**   
* Wrapper file: **transformation_wrapper.R**  
* R packages  
    + **batch** from CRAN  
> install.packages("batch", dep=TRUE)   

### Tests

The code in the wrapper can be tested by running the **tests/transformation_tests.R** in R  

### News

##### CHANGES IN VERSION 2.0.2  

INTERNAL MODIFICATION  

    o Creating tests for R code  
    
***