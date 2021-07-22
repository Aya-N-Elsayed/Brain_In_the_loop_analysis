import glob

import os
config = 'LW' # 'SW' 'SR' 'LW' 'LR'
num = 0
for name in glob.glob('*'+ config +'*.txt'):
      
    os.system('python main.py --filename ' + name + " --config " + config ) 
    num = num + 1

print("number of files ", num )
os.system("python boxplot"+ config + '.py')