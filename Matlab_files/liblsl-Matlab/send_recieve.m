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
    [chunk,stamps] = inlet.pull_sample();
    
   disp(size(chunk));
   disp(chunk)
   %stamp                                             1.611871751071965 
   %time_ms_UTC = java.lang.System.currentTimeMillis; 1.611871747815000
  
   if ~(size(chunk,2))
       outlet.push_sample([111, 111]);
       %disp("here");
       continue;
   end    
  % ch_power = sum (chunk(),2);% row vector contain band power of all channel
  % [max_power,max_ch] = max(ch_power);
   
 fprintf('time of recieved data %.9f\n',stamps(end));  
  %fprintf(time_ms_UTC)
 outlet.push_sample([888, 999]);
 fprintf('888, 999');
 %fprintf('%.1f\n',max_ch-1);
 pause(0.0005);
end