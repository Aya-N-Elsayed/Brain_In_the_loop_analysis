# The feedback dynamics of brain-computer interfaces in a distributed processing environment.

We created and analyzed a reliable nontraditional framework for studying the human brain’s response to changing  stimuli. The proposed closed-loop system places the participant’s brain inside a feedback loop so that the a stimulus can be altered based on thespecific real-time brain response. We provide an in-depth cross analysis for the framework to understand its limitations and constraints.
We have found that an obligatory 32 ms Matlab pause at the back-end is essential,  regardless of the back-end device used for the framework to work properly. We also have found a linear relationship between the loop delay and obligatory Matlab pause with a time offset varying from 0.1 ms to 2.6 ms depending on the back-end device specs. We have also created a real-time visual altering widget as a proof of concept for the viability of our closed-loop brain state-dependent brain stimulation framework, where the visual perspective of the subject changes according to the feedback signal. 
This framework could help psychologists to do their testing more quickly, more accurately, and adaptively. Furthermore, it will also reduce the cost of the tests as it relies on open source products for front-end alongside improving its long-term sustainability.

 We used this brain in the loop system to understand how is the power of alpha is related to frequency of changing the color of the display in front of the subject. We start from low frequency (i.e., 5 HZ) and Matlab observes the change of alpha power upon increasing the frequency of altering the display color. The system then decides whether it should increase or decrease the altering frequency to determine its maximum and minimum to which alpha power is responsive.

Steps to start the frame:
1. Connect your hardware configuration, see the hardware setups images.
2. Open processing folder, processing ide, OpenBCI_GUI_feedback sketchbook.
3. In network widget, Change the configuration in line 24 and matlab pause in millisec in line 23.
4. Open Matlab_files\liblsl-Matlab\examples\RecPower_SenMax.m , change your desired matlab pause in sec in the line 44  (for visual altering application), then run it. 
5. Open Matlab_files\liblsl-Matlab\examples\send_recieveChunck.m , change your desired matlab pause in sec in the line 54  (for analyzing the framework), then run it.
6. Open Matlab_files\liblsl-Matlab\examples\band_freqRel.m , change your desired matlab pause in sec in the line 50  (for understanding the relationship between the frequency of   alternating the display color and alpha band power from all the channels), change output file name in line 11, starting frequency in line 8 and then run it.
7. Run the processing Sketchbook and wait till the OpenBCI GUI opens.
8. Open the Networking widget and the Visual Alterning widget or colorfreq band widget when the OpenBCI GUI opens.
9. Choose LSL from Networking widget dropdown menu.
10. Set stream1 name to "obci_eeg1" and Data type to "Receive".
11. Set stream2 name to "obci_eeg2" and Data type to "BandPower".
12. Run the GUI.
13. Start streaming.
14. Upon finishing, Stop the Matlab first then the GUI.
15. For analyzing the frame work, open extraction_info folder to run python codes.

For more information please read the readme file inside each folder.


