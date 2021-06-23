import matplotlib.pyplot as plt
import numpy as np 
import pandas as pd
import seaborn as sns
import csv
import researchpy
from matplotlib.ticker import (AutoMinorLocator, MultipleLocator)
import scipy.stats
from matplotlib.pyplot import figure

# Reading time difference between consective sending frames of GUI 

data = pd.read_csv("sd.csv")

# Box plot of sending delay and matlab pause
sns.set(font_scale=2)
fig, ax = plt.subplots(figsize=(10, 8))
ax.set_xlim(0, 205)
ax.xaxis.set_major_locator(MultipleLocator(20))
ax.xaxis.set_minor_locator(AutoMinorLocator(4))
ax.grid(which='major', color='#CCCCCC', linestyle='--')
ax.grid(which='minor', color='#CCCCCC', linestyle=':')
sns.boxplot(data=data, orient='h')
plt.ylabel("Matab pause (ms)")
plt.xlabel("Sending delay (ms)")
plt.show()


# calculating statistics for data with outliers
print(researchpy.summary_cont(data, decimals = 1))

#for removing the outliers
for col in data.columns:
    Q1 = data[col].quantile(0.25)
    Q3 = data[col].quantile(0.75)
    IQR = Q3 - Q1    #IQR is interquartile range. 
    filter = (data[col] >= Q1 - 1.5 * IQR) & (data[col] <= Q3 + 1.5 *IQR)
    data[col] = data[col].loc[filter]  
 


# calculating statistics for data without outliers
print(researchpy.summary_cont(data, decimals = 1))

# plotting PMF of sending delay 
figure(figsize=(10, 7))
plt.rcParams.update({'font.size': 20})
datan = data['10 ms'].append(data['50 ms']).append(data['100 ms']).reset_index(drop=True)
pmf = datan.value_counts().sort_index() / len(datan)
pmf.plot(kind='bar')
plt.grid(b=True, which='major', color='#666666', linestyle='-')
# Show the minor grid lines with very faint and almost transparent grey lines
plt.minorticks_on()
plt.grid(b=True, which='minor', color='#999999', linestyle='-', alpha=0.2)
plt.ylabel("PMF(sending delay)")
plt.xlabel("Sending delay (ms)")
plt.show()