import glob
import argparse
import os
import pandas as pd

arguments = argparse.ArgumentParser()
arguments.add_argument('--config',type=str,help='configuration')
args = arguments.parse_args()

config = args.config  # 'SW' 'SR' 'LW' 'LR'
num = 0
df = pd.read_csv("loopdelay_"+ config +".csv",header=0)
df = df.drop(df.columns.difference(['0']), 1, inplace=True)
for name in glob.glob('*'+ config +'*.txt'):
      
    os.system('python main.py --filename ' + name + " --config " + config ) 
    num = num + 1

print("number of files ", num )
os.remove("results_"+ config + '.csv') # delete the old csv file that has the analysis for loop delay of the selected configuration
os.system("python boxplot"+ config + '.py') #creating the new csv file