clear all;
clc;
addpath(genpath('C:\Users\aeite\Documents\MATLAB\liblsl-Matlab'));
%% instantiate the library
disp('Loading the library...');
lib = lsl_loadlib();

% resolve a stream...
disp('Resolving an EEG stream...');
result = {};
while isempty(result)
    disp('Entering...');
    result = lsl_resolve_byprop(lib,'name','BioSemi');end

% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});

disp('Now receiving data...');
while true
    % get data from the inlet
    [vec,ts] = inlet.pull_sample();
    % and display it
   
    fprintf('%.8f\t',vec);
    fprintf('%.9f\n',ts);
end