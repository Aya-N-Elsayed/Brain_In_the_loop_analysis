Naming of BCI GUI text files:
BCI(month)_(day)_(year)_(hour)_(min)(R/SW)_(matlab pause in sec).txt
where LR for laptop_belkin router configuration between HP-Dell laptop
      SW for nmsu network configuration between HP-server
      LW for laptop_nmsu router configuration between HP-Dell laptop
      SR for server_belkin router configuration between HP-server
      
To extract information from all BCI GUI reported files of a specific configuration and analyze loop delay for this configuration 
     python running_codes.py --config SR
     
The file resulting from analyzing the loop delay for any configuration:
     The name of the output file is:  results_(configuration).csv
     It has the loop delay mean, the standard deviation (SD), the confidence interval of 95\% (CT) of the loop delay, and the outliers' percentage for each pause with and                without the outliers.
     The current results.csv files are resulting from running each pause five times for each configuration
     
For only one file:     

      To extract information from BCI GUI reported files:
        python main.py --filename BCI3_11_21_8_47R02.txt

      For analyzing Loop delay for laptops Router setup
        python boxplotLR.py

      For analyzing Loop delay for server wall setup
        python boxplotSW.py

For analyzing sending delay 
  python boxplotSD.py

For analayzing excution time of Matlab on Dell laptop
  python matlab_exctusionT.py

For analayzing relationship between Mean of loop delay and Matlab pause on Dell laptop
  python LoopD-matlabP.py
