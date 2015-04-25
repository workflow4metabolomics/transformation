Tool: Transformation

I. Date: 2015-04-25

II. Authors and maintainer:

	Authors: Etienne Thevenot (1)
	
	(1) MetaboHUB Paris, CEA
	
	Maintainer: Etienne Thevenot (etienne.thevenot@cea.fr)

III. Funding

	Developed within MetaboHUB, The French Infrastructure in Metabolomics and Fluxomics (www.metabohub.fr/en)

IV. Usage restrictions

	Use of this tool is restricted to the service conditions of the MetaboHUB-IFB infrastructures.
	For any question regarding the use of these services, please contact: etienne.thevenot@cea.fr
	
V. Requirements

	none

VI. Installation

	5 files are required for installation:

	1) 'README.txt'
		Instructions for installation
   
	2) 'transformation_config.xml'
		Configuration file; to be put into the './galaxy-dist/tools' directory ('Normalization/Transformation' subdirectory)
		 
	3) 'transformation_wrapper.R'
		Wrapper code written in R aimed at launching the transformation_script.R given the arguments entered by the user through the Galaxy interface

	4) 'transformation_script.R'
		R code containing the computational functions
		
	5) 'transformation_workflowPositionImage.png'
		Image for the help section of the tool main page (as indicated in the 'transformation_config.xml' file); to be put into the './galaxy-dist/static/images' directory		 

VII. License

	CeCILL
