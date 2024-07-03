%% process1subject
% Script to extract the behavioral data that was analysed with ActiLife
% Files of a recording are imported and processed. The imported files are 
% presumed to belong to the same subject. Results of accelerometry and 
% sleep estimates are exported to a sheet containing individual results.
% This script is called upon in the 'ActiMat' script to loop recordings.
% Header information is organized for the output file of the parent script.

% Authorship script (this):             dr. Pieter Van den Berghe
% Updated on:                           31-March-2022

%% %%%%%%%%%%% GET & CHECK INPUT FILE OF PHYSICAL ACTIVITY DATA %%%%%%%%%%%
% Select the processed ActiGraph file on your drive using a pop-up window
[filename,location] = uigetfile('*.xlsx','Select the exported ActiLife file in xlsx format');
cd(location);

% Identify the number of the subject you selected
pattern='_0';
idSubject = regexp(filename, pattern);
idSubject = str2double(filename(idSubject+1:idSubject+3));

% Check if the study originates from primary researchers Manon K or Iris W
FileFromManon = '_MK';
FileFromIris = '_T2D';

% Import data of the sheet entitled Daily
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames');
if contains(filename,FileFromManon)
    readfileMK
else
    Daily_tbl = readtable(filename,'Sheet','Daily');
end

% Search the columns of interest based on the header name; get indices
    idMVPA = find(strcmp('TotalMVPA',Daily_tbl.Properties.VariableNames));
    idStepsCounts = find(strcmp('StepsCounts',Daily_tbl.Properties.VariableNames));
    idDays = find(strcmpi('DayOfWeekNum',Daily_tbl.Properties.VariableNames));
    idTime = find(strcmp('Time',Daily_tbl.Properties.VariableNames));
 % Naming is different in the study of Iris W. Therefore an additional condition 
     if contains(location,FileFromIris)
         idSedentary = find(strcmp('SedentaryBehavior',Daily_tbl.Properties.VariableNames));
     else
         idSedentary = find(strcmp('Sedentary',Daily_tbl.Properties.VariableNames));
     end
    
% Remove non-valid rows wherein Time is less than 600 minutes; 
if ~isnumeric(Daily_tbl.Time)
    Daily_tbl.Time = str2double(Daily_tbl.Time);
end
NotValid = Daily_tbl.Time < 600;
Daily_tbl([find(NotValid)],:) = [];

% Extract column information
Daily_Sedentary = Daily_tbl(:,idSedentary);
Daily_Light = Daily_tbl(:,idSedentary +1);
Daily_Moderate = Daily_tbl(:,idSedentary +2);
Daily_Vigorous = Daily_tbl(:,idSedentary +3);
% Different numbers and values of cut-offs in the study of Iris W. Therefore an additional condition
 if contains(location,FileFromIris)
     Daily_Vigorous = array2table(sum(Daily_tbl{:,idSedentary+3:idSedentary+4},2), 'VariableNames',{'VPA'});
 end
Daily_TotalMVPA = Daily_tbl(:,idMVPA);
Daily_StepsCounts = Daily_tbl(:,idStepsCounts);
Daily_DayOfWeekNum = Daily_tbl(:,idDays);
Daily_Time = Daily_tbl(:,idTime);

% Create table of the metrics requested
Daily_metrics = [Daily_DayOfWeekNum, Daily_Sedentary, Daily_Light, Daily_Moderate, Daily_Vigorous, Daily_TotalMVPA, Daily_StepsCounts, Daily_Time]

% Create figure and perform visually check the imported data for valid time
s = stackedplot(Daily_metrics); 
set(gcf,'WindowState','maximized');

% Determine the rows associated with week and weekend days
WeekRows = find(Daily_DayOfWeekNum{:,1} < 6);
WeekendRows = find(Daily_DayOfWeekNum{:,1} > 5);

% Check if the number of week days and weekend days suffices
% arbitrary minimum of three week days and one weekend day
if length(WeekRows) > 2 && length(WeekendRows) > 0
    % Average data of week and weekend days
    MOV_Weekday = mean(Daily_metrics{WeekRows,2:end});
    if length(WeekendRows) > 1 
        MOV_Weekendday = mean(Daily_metrics{WeekendRows,2:end});
    else
        MOV_Weekendday = Daily_metrics{WeekendRows,2:end};
    end
    
    % Calculate the weighed average of an entire week 
    MOV_WeekWeighed = (MOV_Weekday*5 + MOV_Weekendday*2)/7;
else
    warning('onvoldoende week- of weekenddagen')
    MOV_Weekday = [999 999 999 999 999 999];
    MOV_Weekendday = [999 999 999 999 999 999];
    MOV_WeekWeighed = [999 999 999 999 999 999]; 
end
% memo: deze bewerking staat los van de slaapfile

% Extract Epoch number of the sampled data
Epoch = Daily_tbl{1,3};

%% FILE OF SLEEP DATA
% Import data of the csv file and set the date format
fileNames = dir;
fileNames = {fileNames.name};
if contains(location,FileFromIris)
    [fileSleep] = uigetfile('*.csv','Selecteer de SLAAP export in csv formaat');
else
    fileSleep = fileNames(cellfun(@(f)~isempty(strfind(f,'sleep.csv')),fileNames));
end
fileSleep = char(fileSleep);

if contains(filename,FileFromManon)
    % Setup the Import Options and import the data
    opt = delimitedTextImportOptions("NumVariables", 18);
    % Specify range and delimiter
    opt.DataLines = [7, Inf];
    opt.Delimiter = ",";
    % Specify column names and types
    opt.VariableNames = ["SleepAlgorithm", "InBedDate", "InBedTime", "OutBedDate", "OutBedTime", "OnsetDate", "OnsetTime", "Latency", "TotalCounts", "Efficiency", "TotalMinutesinBed", "TotalSleepTimeTST", "WakeAfterSleepOnsetWASO", "NumberofAwakenings", "AverageAwakeningLength", "MovementIndex", "FragmentationIndex", "SleepFragmentationIndex"];
    opt.VariableTypes = ["categorical", "datetime", "char", "datetime", "char", "datetime", "char", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
    % Specify file level properties
    opt.ExtraColumnsRule = "ignore";
    opt.EmptyLineRule = "read";    
    % Specify variable properties
    opt = setvaropts(opt, ["InBedTime", "OutBedTime", "OnsetTime"], "WhitespaceRule", "preserve");
    opt = setvaropts(opt, ["SleepAlgorithm", "InBedTime", "OutBedTime", "OnsetTime"], "EmptyFieldRule", "auto");
    opt = setvaropts(opt, "InBedDate", "InputFormat", "dd/MM/yyyy");
    opt = setvaropts(opt, "OutBedDate", "InputFormat", "dd/MM/yyyy");
    opt = setvaropts(opt, "OnsetDate", "InputFormat", "dd/MM/yyyy");
    opt = setvaropts(opt, ["Efficiency", "AverageAwakeningLength", "MovementIndex", "FragmentationIndex", "SleepFragmentationIndex"], "TrimNonNumeric", true);
    opt = setvaropts(opt, ["Efficiency", "AverageAwakeningLength", "MovementIndex", "FragmentationIndex", "SleepFragmentationIndex"], "DecimalSeparator", ",");
else
    opt=detectImportOptions(fileSleep);
    opt = setvaropts(opt, "InBedDate", "InputFormat", "dd/MM/yyyy");
    opt = setvaropts(opt, "OutBedDate", "InputFormat", "dd/MM/yyyy");
    opt = setvaropts(opt, "OnsetDate", "InputFormat", "dd/MM/yyyy");
end

% Generate a table of the sleep data imported
Sleep_tbl = readtable(fileSleep, opt);
clear opts; % Clear temporary variable

% Determine the days of the week associated with the sleep days
[Sleep_DayNumber,Sleep_DayName] = weekday(Sleep_tbl.InBedDate);

% Search the columns of interest based on the header 
idEfficiency = find(strcmp('Efficiency',Sleep_tbl.Properties.VariableNames));
idTotalMinutesInBed = find(strcmpi('TotalMinutesInBed',Sleep_tbl.Properties.VariableNames));
idTotalSleepTimeTST = find(strcmp('TotalSleepTime_TST_',Sleep_tbl.Properties.VariableNames));
if isempty(idTotalSleepTimeTST)
    idTotalSleepTimeTST = find(strcmp('TotalSleepTimeTST',Sleep_tbl.Properties.VariableNames));
end
idWakeAfterSleepOnsetWASO = find(strcmp('WakeAfterSleepOnset_WASO_',Sleep_tbl.Properties.VariableNames));
if isempty(idWakeAfterSleepOnsetWASO)
    idWakeAfterSleepOnsetWASO = find(strcmp('WakeAfterSleepOnsetWASO',Sleep_tbl.Properties.VariableNames));
end
idNumberofAwakenings = find(strcmpi('NumberOfAwakenings',Sleep_tbl.Properties.VariableNames));
idAverageAwakeningLength = find(strcmp('AverageAwakeningLength',Sleep_tbl.Properties.VariableNames));
idMovementIndex = find(strcmp('MovementIndex',Sleep_tbl.Properties.VariableNames));
idFragmentationIndex = find(strcmp('FragmentationIndex',Sleep_tbl.Properties.VariableNames));
idSleepFragmentationIndex = find(strcmp('SleepFragmentationIndex',Sleep_tbl.Properties.VariableNames));

% Show the table with columns of interest
idSleep_min = min([idEfficiency,idTotalMinutesInBed,idTotalSleepTimeTST,idWakeAfterSleepOnsetWASO,idNumberofAwakenings,idAverageAwakeningLength,idMovementIndex,idFragmentationIndex,idSleepFragmentationIndex]);
idSleep_max = max([idEfficiency,idTotalMinutesInBed,idTotalSleepTimeTST,idWakeAfterSleepOnsetWASO,idNumberofAwakenings,idAverageAwakeningLength,idMovementIndex,idFragmentationIndex,idSleepFragmentationIndex]);
Sleep_tbl(:,[2 idSleep_min:idSleep_max])

% Identify the weekend days and the week days
Sleep_WeekendRows = find(Sleep_DayNumber > 5); % matlab defines Sunday as 1
Sleep_WeekRows = find(Sleep_DayNumber < 6);

% Average the week days and weekend days
Sleep_Weekendday = mean(Sleep_tbl{Sleep_WeekendRows,idSleep_min:idSleep_max});
Sleep_Weekday = mean(Sleep_tbl{Sleep_WeekRows,idSleep_min:idSleep_max});

% Calculate a weighed average
Sleep_WeekWeighed = (Sleep_Weekday*5 + Sleep_Weekendday*2)/7; 

% Create seperate variables 
Sleep_WeekWeighed_Efficiency = Sleep_WeekWeighed(idEfficiency - idSleep_min+1);
Sleep_WeekWeighed_TotalMinutesInBed = Sleep_WeekWeighed(idTotalMinutesInBed - idSleep_min+1);
Sleep_WeekWeighed_TotalSleepTime_TST = Sleep_WeekWeighed(idTotalSleepTimeTST - idSleep_min+1);
Sleep_WeekWeighed_WakeAfterSleepOnset_WASO = Sleep_WeekWeighed(idWakeAfterSleepOnsetWASO - idSleep_min+1);
Sleep_WeekWeighed_NumberOfAwakenings = Sleep_WeekWeighed(idNumberofAwakenings - idSleep_min+1);
Sleep_WeekWeighed_AverageAwakeningLength = Sleep_WeekWeighed(idAverageAwakeningLength - idSleep_min+1);
Sleep_WeekWeighed_MovementIndex = Sleep_WeekWeighed(idMovementIndex - idSleep_min+1);
Sleep_WeekWeighed_FragmentationIndex = Sleep_WeekWeighed(idFragmentationIndex - idSleep_min+1);
Sleep_WeekWeighed_SleepFragmentationIndex = Sleep_WeekWeighed(idSleepFragmentationIndex - idSleep_min+1);

%% ORGANIZE RESULTS OF THE RECORDING
ResultsFile = {'Recording','Epoch',...
    'Week_Sedentary','Week_Light','Week_Moderate','Week_Vigorous','Week_MVPA','Week_StepCounts',...
    'Weekend_Sedentary','Weekend_Light','Weekend_Moderate','Weekend_Vigorous','Weekend_MVPA','Weekend_StepCounts',...
    'WeighedWeek_Sedentary','WeighedWeek_Light','WeighedWeek_Moderate','WeighedWeek_Vigorous','WeighedWeek_MVPA','WeighedWeek_StepCounts'...
    'Sleep_WeekWeighed_Efficiency','Sleep_WeekWeighed_TotalMinutesInBed','Sleep_WeekWeighed_TotalSleepTime_TST','Sleep_WeekWeighed_WakeAfterSleepOnset_WASO',...
    'Sleep_WeekWeighed_NumberOfAwakenings','Sleep_WeekWeighed_AverageAwakeningLength','Sleep_WeekWeighed_MovementIndex','Sleep_WeekWeighed_FragmentationIndex','Sleep_WeekWeighed_SleepFragmentationIndex'...
    ; idSubject,Epoch,MOV_Weekday(1),MOV_Weekday(2),MOV_Weekday(3),MOV_Weekday(4),MOV_Weekday(5),MOV_Weekday(6),...
    MOV_Weekendday(1),MOV_Weekendday(2),MOV_Weekendday(3),MOV_Weekendday(4),MOV_Weekendday(5),MOV_Weekendday(6),...
    MOV_WeekWeighed(1),MOV_WeekWeighed(2),MOV_WeekWeighed(3),MOV_WeekWeighed(4),MOV_WeekWeighed(5),MOV_WeekWeighed(6),...
    Sleep_WeekWeighed_Efficiency,Sleep_WeekWeighed_TotalMinutesInBed,Sleep_WeekWeighed_TotalSleepTime_TST,Sleep_WeekWeighed_WakeAfterSleepOnset_WASO,...
    Sleep_WeekWeighed_NumberOfAwakenings,Sleep_WeekWeighed_AverageAwakeningLength,Sleep_WeekWeighed_MovementIndex,Sleep_WeekWeighed_FragmentationIndex,Sleep_WeekWeighed_SleepFragmentationIndex};
% ResultsFilename = [filename(1:end-5) '_proc'];
% writecell(ResultsFile, [ResultsFilename '.xlsx']);
Results = ResultsFile(2,:);