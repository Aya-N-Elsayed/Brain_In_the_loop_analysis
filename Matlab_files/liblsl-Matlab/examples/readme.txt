# To run these examples, you must have added the folder include/lsl_matlab to your MATLAB path (recursively).
You can do this either via the File/Path... menu or via the command addpath(genpath('your_path_to/liblsl-1.xx/include/lsl_matlab'))
Also, if you have rebuilt the library, make sure that liblsl-1.xx/include/lsl_matlab/bin contains a copy of the library files in the liblsl-1.xx/bin.

# To receive bands' power from the GUI and summing the power of each band from all four electrodes to get the total power corresponding to each frequency band. then send back the maxium power & corresponding band.

   Run
    RecPower_SenMax

# To calculate round-trip delay, Matlab sends back three different streams, depending on the receiving GUI stream; in case of receiving nothing, it sends a stream of [111,111], 
in case of receiving "-1" flag, it sends a flagged stream of [-1,-1] otherwise it sends a [888,999] stream.

    Run
     
