% Sending and receiving to calculate the roud-trip delay
clear all;
clc;
addpath(genpath('C:\Users\aeite\Documents\GitHub\neural_signal_2020\Matlab_files\liblsl-Matlab'));
filepath = "C:\Users\aeite\Documents\GitHub\neural_signal_2020\Matlab_files\liblsl-Matlab\results.txt";
% instantiate the library/
disp('Loading the library...');
lib = lsl_loadlib();
% resolve a stream...
%for recieving
disp('Resolving an EEG stream...');
result = {};
%for sending
info = lsl_streaminfo(lib,'BioSemi','EEG',2,100,'cf_float32','sdfwerr32432');%sending a feedback signal
outlet = lsl_outlet(info);
fileID = fopen(filepath,'w'); % for reporting info in a text file

while isempty(result)
    result = lsl_resolve_byprop(lib,'name','obci_eeg2'); %for receiving bandpower ,'name','obci_eeg2'
end
% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});

disp('Now receiving chunked data...');
while true
    % get chunk from the inlet
    tic % for calculating execution time of each sending 
    [chunk,stamps] = inlet.pull_chunk();
    
   disp(size(chunk));
   disp(chunk)
   fprintf(fileID,'size of recieved %d %d\n ',size(chunk)); % writing in text file
   fprintf(fileID,'%f ',chunk);  % writing in text file
   
   if ~(size(chunk,2))
       outlet.push_sample([111, 111]); % Pushing a dummy frame incase of receiving an empty frame from the GUI
       continue;
   end       
 fprintf('time of recieved data %.9f\n',stamps(end));   % writing in text file
 fprintf(fileID,'\ntime of recieved data %.9f\n\n',stamps(end)); % writing in text file
 % searching for the -1 flag 
 temp =(chunk(end,:) == -1);
 disp(temp); 
 temp = sum(temp);
 if (temp) % a flag was found
     outlet.push_sample([-1,-1]); % send a flagged frame
     disp("sending the flag -1")
     fprintf(fileID,"\n%s\n","sending the flag -1");
 else     
     outlet.push_sample([888, 999]); 
 end
 elapedtime = toc % calculating matlab execution time
 pause(0.035 ); % pause 35 ms
end
fclose(fileID);