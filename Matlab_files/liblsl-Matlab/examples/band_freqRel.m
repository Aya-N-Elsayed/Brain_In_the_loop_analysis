% processing EEG power for each band from each of the four electrods

clear all;
clc;
addpath(genpath('C:\Users\aeite\Documents\GitHub\neural_signal_2020\Matlab_files\liblsl-Matlab'));
% instantiate the library
disp('Loading the library...');
lib = lsl_loadlib();

% resolve a stream...
%for recieving
disp('Resolving an EEG stream...');
result = {};
%for sending
info = lsl_streaminfo(lib,'BioSemi','EEG',2,100,'cf_float32','sdfwerr32432');%sending feedback signal
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
   if ~(size(chunk,2))
       sent_data = 111;
       outlet.push_sample([sent_data, sent_data]); % Pushing a dummy frame incase of receiving an empty frame from the GUI
       continue;
   else
   band_power = sum (chunk(:,3),1);% alpha band power of all channel   
%    if (max_band > 5) % if the receiving matrix has a size > 5 (i.e 4*16)
%        max_band = max_band-8; 
%    end 
  sent_data = 2;
       outlet.push_sample([sent_data, sent_data]); % sending maxium power & corresponding band
end
 pause(0.033); % pause 0.1 sec
 disp(sent_data);
end