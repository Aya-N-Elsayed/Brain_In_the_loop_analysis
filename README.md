# BRAIN-IN-THE-LOOP ANALYSIS FOR INCREASED TESTING EFFICIENCY AND BETTER UNDERSTAND OF BRAIN DYNAMICS.

We created and analyzed a reliable nontraditional framework for studying the human brain’s response to changing  stimuli. The proposed closed-loop system places the participant’s brain inside a feedback loop so that the a stimulus can be altered based on thespecific real-time brain response. We provide an in-depth cross analysis for the framework to understand its limitations and constraints.
We have found that an obligatory 32 ms Matlab pause at the back-end is essential,  regardless of the back-end device used for the framework to work properly. We also have found a linear relationship between the loop delay and obligatory Matlab pause with a time offset varying from 0.1 ms to 2.6 ms depending on the back-end device specs. We have also created a real-time visual altering widget as a proof of concept for the viability of our closed-loop brain state-dependent brain stimulation framework, where the visual perspective of the subject changes according to the feedback signal. 
This framework could help psychologists to do their testing more quickly, more accurately, and adaptively. Furthermore, it will also reduce the cost of the tests as it relies on open source products for front-end alongside improving its long-term sustainability.

Steps to start the frame:
1. Connect your hardware configuration, see the hardware setups images.
2. Open processing folder, processing ide, OpenBCI_GUI_feedback sketchbook.
3. Change the name of the output text file in OpenBCI GUI network widget line 2258 according to your configuration R for laptops router while SW for server laptop on nmsu network
    and matlab pause in sec.
4. Open Matlab_files\liblsl-Matlab\examples\RecPower_SenMax.m , change your desired matlab pause in sec in the line 44  (for visual altering application), then run it. 
5. Open Matlab_files\liblsl-Matlab\examples\send_recieveChunck.m , change your desired matlab pause in sec in the line 54  (for analyzing the framework), then run it.
6. Run the processing Sketchbook and wait till the OpenBCI GUI opens.
7. Open the Networking widget and the Visual alterning widget when the OpenBCI GUI opens.
8. Choose LSL from Networking widget dropdown menu.
9. Set stream1 name to "obci_eeg1" and type to "power band".
10. Set stream2 name to "obci_eeg2" and type to "Receive".
11. Run the GUI.
12. Start streaming.
13. Upon finishing, Stop the Matlab first then the GUI.
14. For analyzing the frame work, open extraction_info folder to run python codes.

For more information please read the readme file inside each folder.


