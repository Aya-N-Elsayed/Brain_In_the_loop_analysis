clear all;
clc;
addpath(genpath('C:\Users\aeit el rahman\Documents\MATLAB\liblsl-Matlab'));
filepath = "C:\Users\aeit el rahman\Documents\MATLAB\liblsl-Matlab\results.txt";
% instantiate the library/
disp('Loading the library...');
lib = lsl_loadlib();
% resolve a stream...
%for recieving
disp('Resolving an EEG stream...');
result = {};
%for sending
info = lsl_streaminfo(lib,'BioSemi','EEG',2,100,'cf_float32','sdfwerr32432');%sending on timeseries
outlet = lsl_outlet(info);
fileID = fopen(filepath,'w');
while isempty(result)
    result = lsl_resolve_byprop(lib,'name','obci_eeg2'); %for receiving bandpower ,'name','obci_eeg2'
end
% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});

disp('Now receiving chunked data...');
while true
    % get chunk from the inlet
    tic
    [chunk,stamps] = inlet.pull_chunk();
    
   disp(size(chunk));
   disp(chunk)
   fprintf(fileID,'size of recieved %d %d\n ',size(chunk));
   fprintf(fileID,'%f ',chunk);
   %writematrix(chunk,filepath,'Delimiter','tab')
   if ~(size(chunk,2))
       outlet.push_sample([111, 111]);
       continue;
   end       
 fprintf('time of recieved data %.9f\n',stamps(end));  
 fprintf(fileID,'\ntime of recieved data %.9f\n\n',stamps(end)); 
 % searching for the flag -1
 temp =(chunk(end,:) == -1);
 disp(temp); 
 temp = sum(temp);
 if (temp)
     outlet.push_sample([-1,-1]);
     disp("sending the flag -1")
     fprintf(fileID,"\n%s\n","sending the flag -1");
 else     
     outlet.push_sample([888, 999]);
 end
 elapedtime = toc
 pause(0.035 );
end
fclose(fileID);