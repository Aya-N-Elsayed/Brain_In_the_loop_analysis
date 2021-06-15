clear all;
clc;
addpath(genpath('C:\Users\aeite\Documents\MATLAB\liblsl-Matlab'));
% instantiate the library
disp('Loading the library...');
lib = lsl_loadlib();

% resolve a stream...
%for recieving
disp('Resolving an EEG stream...');
result = {};
%for sending
info = lsl_streaminfo(lib,'BioSemi','EEG',2,100,'cf_float32','sdfwerr32432');%sending on timeseries
outlet = lsl_outlet(info);

while isempty(result)
    result = lsl_resolve_byprop(lib,'name','obci_eeg2'); %for receiving bandpower ,'name','obci_eeg2'
end
% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});

disp('Now receiving chunked data...');
while true
    % get chunk from the inlet
    [chunk,stamps] = inlet.pull_chunk();
   disp(size(chunk));
   disp(stamps)
   if ~(size(chunk,2))
       outlet.push_sample([111, 111]);
       %disp("here");
       continue;
   end    
   ch_power = sum (chunk(),2);% row vector contain band power of all channel
   [max_power,max_ch] = max(ch_power);
   
   
  outlet.push_sample([max_power, 999]);
 fprintf('%.8f\t',max_power);
 fprintf('%.1f\n',max_ch-1);
    pause(0.05);
end