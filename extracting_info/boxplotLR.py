import matplotlib.pyplot as plt
import numpy as np 
import pandas as pd
import seaborn as sns
import csv
import researchpy
from matplotlib.ticker import (AutoMinorLocator, MultipleLocator)
import scipy.stats


data = pd.read_csv("loopdelay_LR.csv") # Reading loop delay csv file for two Laptops communication through a router

'''
dataS = data[['20','30','31']] # small delay 
dataL = data[['100','200']] # large delay
dataM = data.drop(['20','30','31','200','100'],axis= 1) # Medium delay

# Boxplot for small delay
sns.set(font_scale=2)
fig, ax = plt.subplots(figsize=(10, 7))
sns.boxplot(data=dataS, orient='h')
plt.ylabel("Matab pause (ms)")
plt.xlabel("Loop delay (ms)")
plt.show()

# Boxplot for large delay
sns.set(font_scale=2)
fig, ax = plt.subplots(figsize=(10, 7))
ax.set_xlim(0, 220)
ax.xaxis.set_major_locator(MultipleLocator(20))
ax.xaxis.set_minor_locator(AutoMinorLocator(4))
ax.grid(which='major', color='#CCCCCC', linestyle='--')
ax.grid(which='minor', color='#CCCCCC', linestyle=':')
sns.boxplot(data=dataL, orient='h')
plt.ylabel("Matab pause (ms)")
plt.xlabel("Loop delay (ms)")
plt.show()

# Boxplot for medium  delay
sns.set(font_scale=2)
fig, ax = plt.subplots(figsize=(10, 7))
ax.set_xlim(0, 105)
ax.xaxis.set_major_locator(MultipleLocator(20))
ax.xaxis.set_minor_locator(AutoMinorLocator(4))
ax.grid(which='major', color='#CCCCCC', linestyle='--')
ax.grid(which='minor', color='#CCCCCC', linestyle=':')
sns.boxplot(data=dataM, orient='h')
plt.ylabel("Matab pause (ms)")
plt.xlabel("Loop delay (ms)")
plt.show()
'''

# calculating statistics for data with outliers

num_outleirs = (researchpy.summary_cont(data, decimals = 1))["N"] # number of instances for each delay
df = pd.DataFrame(researchpy.summary_cont(data, decimals = 1))

# Removing the outliers 
for col in data.columns:
    Q1 = data[col].quantile(0.25)
    Q3 = data[col].quantile(0.75)
    IQR = Q3 - Q1    #IQR is interquartile range. 

    filter = (data[col] >= Q1 - 1.5 * IQR) & (data[col] <= Q3 + 1.5 *IQR)
    
    data[col] = data[col].loc[filter]  
    

# calculating statistics for data without outliers

num_no_outleirs = (researchpy.summary_cont(data, decimals = 1))["N"] # number of instances for each delay after removing the outliers
percent = (num_outleirs - num_no_outleirs)/num_outleirs * 100 # percentage of outliers 
DF = pd.DataFrame(researchpy.summary_cont(data, decimals = 1))
DF = DF.rename(columns={"Variable": "Variable2"})
data = pd.concat([df,DF,percent], axis=1)
data = data.sort_values(by='Variable')
data.to_csv("results_LR.csv", index=False)


#plotting the outliers percentage for each delay
delays = (researchpy.summary_cont(data, decimals = 1))["Variable"]
plt.grid(b=True, which='major', color='#666666', linestyle='-')
# Show the minor grid lines with very faint and almost transparent grey lines
plt.minorticks_on()
plt.grid(b=True, which='minor', color='#999999', linestyle='-', alpha=0.2)
plt.plot(delays,percent, 'o')
plt.ylabel("Percentage of Outliers (%)")
plt.xlabel("Matab pause (ms)")
plt.show()