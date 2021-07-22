clear all;
clc;
addpath(genpath('C:\Users\aeite\Documents\MATLAB\liblsl-Matlab'));
%% instantiate the library
disp('Loading library...');
lib = lsl_loadlib();

% make a new stream outlet
disp('Creating a new streaminfo...');
info = lsl_streaminfo(lib,'Aya','EEG',4,100,'cf_float32','sdfwerr32432');

disp('Opening an outlet...');
outlet = lsl_outlet(info);

% send data into the outlet, sample by sample
disp('Now transmitting data...');
while true
    outlet.push_sample([999, 888,777,666]);
    pause(0.05);
end