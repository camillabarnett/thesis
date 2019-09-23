# thesis - chapter 7 measuring women's stratification position cross nationally
Stata syntax used for Camilla Barnetts doctoral thesis chapter 7 


c7_data_management.do prepares the issp data for anaysis 
it calls sselectedmicrodatamanagement.do , gselectedmicrodatamanagement.do , wselectedmicrodatamanagement.do
which call adding_strat_to_issp.do - this file adds the startifcationmesures using Harry Ganzeebooms tools and the CAMSIS website

c7.do runs the analyis
