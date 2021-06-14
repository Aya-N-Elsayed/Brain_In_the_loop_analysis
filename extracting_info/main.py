import numpy as np
import argparse
import scipy.stats
import pandas as pd

if __name__ == "__main__":

    arguments = argparse.ArgumentParser()
    arguments.add_argument('--filename',type=str,help='file name')
    args = arguments.parse_args()
    filename = args.filename                          #getting text file name
    pause= ((filename.split('W'))[1]).split('.')[0]   #getting Matlab pause amount
    
    file = open(filename, 'r')
    Lines = file.readlines()

    print('number of lines ',len(Lines))                                 #print number of lines of the text file 
    Sflag = 0                                                            #number of sending flags by BCI
    Rflag = 0                                                            #number of received flags by BCI
    all_sending_time = []                                                #array of sending time
    flag_sending_time = []                                               #array of sending flags' time
    flag_recieving_time = []                                             #array of received flags' time

   
   ### Extraction info from text file
    for line in Lines:
        
        if line.startswith(' time stamp of sending'):   #searching for time of sending 
            x = int(line[22:]) 
            all_sending_time.append(x)
            if Sflag == 1:                         #checking the sending flag 
                flag_sending_time.append(x)        #add sending time to array of sending flags' time
                Sflag = 0

        if Rflag == 1:                             #checking the sending flag 
            x = int(line[24:])                     #get the receiving time
            flag_recieving_time.append(x)          #add sending time to array of received flags' time
            Rflag = 0        
        
        if line.endswith(' -1.0 \n'):             
            Sflag = 1                              #assigning the sending flag

        if line.endswith('***************************\n'):   
            Rflag = 1                              #assigning the received flag
        
            
    all_sending_time = np.array(all_sending_time)  
    flag_sending_time = np.array(flag_sending_time) 
    flag_recieving_time = np.array(flag_recieving_time) 
    sending_delay = np.diff(all_sending_time)   
    loop_delay = flag_recieving_time - flag_sending_time[:len(flag_recieving_time)]




    ### printing the extracted info
    print("all_sending_time  ",all_sending_time)
    print("sending_delay  ",sending_delay)
    print("# flag_sending ",len(flag_sending_time))
    print(" # flag_recieving ",len(flag_recieving_time))
    print("loop_delay ",loop_delay)

  

    ###Loop delay reporting for laptops router setup
    DF = pd.DataFrame(loop_delay,columns = ['pause'+pause])
    df = pd.read_csv("loopdelay_lr.csv",header=0)
    data = pd.concat([df,DF], axis=1)
    data.to_csv("loopdelay_lr.csv", index=False)
    
    ###Loop delay reporting for server wall setup
    sw = pd.DataFrame(loop_delay,columns = ['pause'+pause])
    SW = pd.read_csv("loopdelay_sw.csv",header=0)
    data = pd.concat([sw,SW], axis=1)
    data.to_csv("loopdelay_sw.csv", index=False)