
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib.ticker import (AutoMinorLocator, MultipleLocator)


# Matlab excution time on Dell Laptop 

Matlab_time = np.array([0.0146,0.003,0.0026,0.0024,0.0024,0.0025,0.0015,0.0011,0.0020,0.00087910,0.0012,0.00059590,0.00069910,0.00092590,0.0025, 0.0023,0.0032,0.0020,
                         0.0028,0.0024,0.0023,0.0036,0.0021,0.0022,0.0026,0.0030])
print("Mean of Matlap excution time on Dell laptop " ,np.mean(Matlab_time ))