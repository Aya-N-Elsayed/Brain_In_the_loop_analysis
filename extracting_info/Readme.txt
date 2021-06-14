Naming of BCI GUI text files:
BCI(month)_(day)_(year)_(hour)_(min)(R/SW)_(matlab pause in sec).txt
where R for router configuration between HP-Dell laptop
      SW for nmsu network configuration between HP-server
      
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
