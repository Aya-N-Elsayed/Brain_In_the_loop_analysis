import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib.ticker import (AutoMinorLocator, MultipleLocator)
from matplotlib.pyplot import figure

matlab_pause = np.array([32,33,35,40,43,45,47,50,100,200])
loop_delay = np.array([34.6,34.9,37.6,41.1,45.3,47.5,49.3,52.5,102.5,201.5])
diff = loop_delay - matlab_pause
print("Time difference between loop delay mean & matlab pause  ",diff)
print("Mean of the time difference ",np.mean(diff))

# plotting time difference & Matlab pause
figure(figsize=(10, 7))
plt.rcParams.update({'font.size': 20})
plt.grid(b=True, which='major', color='#666666', linestyle='-')
# Show the minor grid lines with very faint and almost transparent grey lines
plt.minorticks_on()
plt.grid(b=True, which='minor', color='#999999', linestyle='-', alpha=0.2)
#plt.plot(matlab_pause, loop_delay)
plt.plot(matlab_pause,diff, 'o')
plt.xlabel("Matab pause (ms)")
plt.ylabel("Difference between LD & MP (ms)")
plt.show()
