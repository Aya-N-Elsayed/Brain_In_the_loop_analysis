% processing EEG power for each band from each of the four electrods

clear all;
clc;
addpath(genpath('C:\Users\aeite\Documents\GitHub\neural_signal_2020-\Matlab_files\liblsl-Matlab'));
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
   disp(stamps)
   if ~(size(chunk,2))
       outlet.push_sample([111, 111]); % Pushing a dummy frame incase of receiving an empty frame from the GUI
       continue;
   end    
   bands_power = sum (chunk(),1);% row vector contain band power of all channel
   [max_power,max_band] = max(bands_power); % maxium power & corresponding band
   
   if (max_band > 5) % if the receiving matrix has a size > 5 (i.e 4*16)
       max_band = max_band-8; 
   end   
 outlet.push_sample([max_power, max_band-1]); % sending maxium power & corresponding band
 fprintf('%.8f\t',max_power);
 fprintf('%.1f\n',max_band-1);
    pause(0.1); % pause 0.1 sec
end