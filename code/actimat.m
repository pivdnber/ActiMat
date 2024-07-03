%% ActiMat - main script
% This script loads ActiLife(R) data files (currently supporting .xlsx 
% and .csv format) iteratively to analyse physical and sleep behavior. 
% It is designed to streamline and standardize the file-reading process 
% of a 24HMB dataset, that has been collected by a researcher affiliated  
% with the department of Rehabilitation Sciences of Ghent University. 
% There is no a priori programming knowledge required for operating the 
% script. Execute the script by typing actimat in the command window, and 
% select the appropriate folders in the explorer window that pops-up. 
% Please read the README file distributed with this script on GitHub 
% (UGent) Enterprise. Link: github.ugent.be/pivdnber/ActigraphProcessing

% Output file: a .xlsx/.mat/.txt-sps file for all selected subjects
% containing physical activity and sleep parameters. The 'results' output
% can be invoked in statistical software. SPSS is loaded automatically
% and the matfile is compatible with R.

% The functionality is presented under Matlab version 2019b and 2021b.
% Updated on: 01-April-2022
% The code is archived and shared with colleagues of Ghent University. 
% The latest version is available in the listed Github repository. 
% These scripts were developed thanks to dr. Pieter Van den Berghe.

% COPYRIGHT (c) 2022, Pieter Van den Berghe, pieter.vandenberghe@ugent.be. 
% All rights reserved. Redistribution and use in source and binary forms, 
% with or without modification, are permitted for academic purposes 
% provided the conditions and disclaimer in the README and LICENSE files 
% are met. Use for commercial purposes is prohibited. 

%% %%%%%%%%%%%%%%%%%%%%%% PREPARATORY STEPS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clear workspace and command window of the program
clear; clc; close all;

% Select the folder containing the downloaded Acti*-matlab files
CodeName = uigetdir(cd, 'Select the folder containing the ActiGraphProcessing files');
addpath(CodeName);

% Select the main folder showing the folders of each subject
selpath = uigetdir('S:\shares', 'Select the Subject folder'); 

% Determine the names of the subjects folders
cd(selpath)
[subDirsNames]=getFolders;

% Generate an empty sheet to allocate the results; preallocate matrix
sheetResults = cell(size(subDirsNames,1),29); % 29 columns in the results file

%% %%%%%%%%%%%%%%%%%% PROCESS FILES SUBJECTWISE %%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the script that processes one subject and loop it
for ii = 1:length(subDirsNames)
    process1subject;
    display(['Processed ' filename(1:end-5)])
    sheetResults(ii,:) = Results(1,:); 
    cd(selpath)
    saveas(gcf, fullfile(selpath, filename(1:end-5)), 'jpeg');    
end

%% %%%%%%%%%%% EXPORT THE RESULTS IN DIFFERENT FORMATS %%%%%%%%%%%%%%%%%%%%
% Write metadata to header
header = {'Recording','Epoch','Week_Sedentary','Week_Light','Week_Moderate','Week_Vigorous','Week_MVPA','Week_StepCounts',...
    'Weekend_Sedentary','Weekend_Light','Weekend_Moderate','Weekend_Vigorous','Weekend_MVPA','Weekend_StepCounts',...
    'WeighedWeek_Sedentary','WeighedWeek_Light','WeighedWeek_Moderate','WeighedWeek_Vigorous','WeighedWeek_MVPA','WeighedWeek_StepCounts'...
    'Sleep_WeekWeighed_Efficiency','Sleep_WeekWeighed_TotalMinutesInBed','Sleep_WeekWeighed_TotalSleepTime_TST','Sleep_WeekWeighed_WakeAfterSleepOnset_WASO',...
    'Sleep_WeekWeighed_NumberOfAwakenings','Sleep_WeekWeighed_AverageAwakeningLength','Sleep_WeekWeighed_MovementIndex','Sleep_WeekWeighed_FragmentationIndex','Sleep_WeekWeighed_SleepFragmentationIndex'};
output = [header;sheetResults];

% Create and go to a folder that stores the processed files
parentDirectory = fileparts(cd);
cd(parentDirectory);
if not(isfolder('PROCESSED'))
    mkdir('PROCESSED');
end
cd PROCESSED;

% Save the results to an Excel compatible file
writecell(output, 'results.xlsx');

% Save a matfile containing the header and numeric data separately
output = {}; % preallocate feature array
output.key = header; % Write Metadata to Header
output.data = cell2mat(sheetResults); % get processed data of the selected subjects
save('results','output', '-v6'); % file for bringing results into R(studio)
close all;

% Save the output in text format and import the results in SPSS software
export2spss(header, cell2mat(sheetResults),'Results');