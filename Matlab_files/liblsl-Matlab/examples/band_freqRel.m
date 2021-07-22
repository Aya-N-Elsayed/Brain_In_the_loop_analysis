% processing EEG power for each band from each of the four electrods to
% know the relationship between the frequency of alternating the display
% color and alpha band power from all the channels

clear all;
clc;
old_power = 0.0;
freq = 5; %Starting frequency in HZ 
A = [];
addpath(genpath('C:\Users\aeite\Documents\GitHub\neural_signal_2020\Matlab_files\liblsl-Matlab'));
filename = "aya2_2m.csv"; % Output file subject name trail number_trail duration
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
       band_power = sum (chunk(:,3),1);% alpha band power of all channel   (new alpha power)
       delta = band_power - old_power; %difference between new power and old power
       freq = freq + delta; % Add the difference with it's sign to the frequency 
       old_power = band_power;  % Assign the new power to the old power
       sent_data = freq;  
       outlet.push_sample([sent_data, sent_data]); % sending maxium power & corresponding band
       A = [A;band_power freq]; % Append the powerband along with the frequency to A matrix
   end
 fprintf('%f\n %f\n %f\n', band_power, freq, delta);
 pause(0.05); 
 
end
plot(A) % plot bandpower and frequency
legend('Frequency(HZ)','Alpha power(uv)')
writematrix(A,filename) % write bandpower and frequency in a text file