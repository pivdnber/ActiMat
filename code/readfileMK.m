%% AGPfileMK
% Script for importing data from a spreadsheet of Actigraph data pre-
% processed by MK
%
% Developed by Pieter Van den Berghe and updated on 31-Mar-2022

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 105);

% Specify sheet and range
opts.Sheet = "Daily";
opts.DataRange = "A2:DA10";

% Specify column names and types
opts.VariableNames = ["Subject", "Filename", "Epoch", "Weightlbs", "Age", "Gender", "Date", "DayofWeek", "DayofWeekNum", "NumberofFreedson1998boutsoccurringonthisday", "NumberofFreedson1998boutsstartingonthisday", "NumberofFreedson1998boutsendingonthisday", "TotaltimeofFreedson1998boutsoccurringonthisday", "TotalactivitycountsofFreedson1998boutsoccurringonthisday", "NumberofSedentaryBoutsoccurringonthisday", "NumberofSedentaryBoutsStartingontheDay", "NumberofSedentaryBoutsEndingontheDay", "TotaltimeofSedentaryBoutsOccuringonthisDay", "NumberofSedentaryBreaksOccurringontheDay", "NumberofSedentaryBreaksStartingontheDay", "NumberofSedentaryBreaksEndingontheDay", "TotaltimeofSedentaryBreaksOccuringonthisDay", "Sedentary", "Light", "Moderate", "Vigorous", "inSedentary", "inLight", "inModerate", "inVigorous", "TotalMVPA", "inMVPA", "AverageMVPAperhour", "Axis1Counts", "Axis2Counts", "Axis3Counts", "Axis1AverageCounts", "Axis2AverageCounts", "Axis3AverageCounts", "Axis1MaxCounts", "Axis2MaxCounts", "Axis3MaxCounts", "Axis1CPM", "Axis2CPM", "Axis3CPM", "VectorMagnitudeCounts", "VectorMagnitudeAverageCounts", "VectorMagnitudeMaxCounts", "VectorMagnitudeCPM", "StepsCounts", "StepsAverageCounts", "StepsMaxCounts", "StepsPerMinute", "LuxAverageCounts", "LuxMaxCounts", "NumberofEpochs", "Time", "CalendarDays", "VarName59", "DayofWeek1", "DayofWeekNum1", "NumberofFreedson1998boutsoccurringonthisday1", "NumberofFreedson1998boutsstartingonthisday1", "NumberofFreedson1998boutsendingonthisday1", "TotaltimeofFreedson1998boutsoccurringonthisday1", "TotalactivitycountsofFreedson1998boutsoccurringonthisday1", "NumberofSedentaryBoutsoccurringonthisday1", "NumberofSedentaryBoutsStartingontheDay1", "NumberofSedentaryBoutsEndingontheDay1", "TotaltimeofSedentaryBoutsOccuringonthisDay1", "NumberofSedentaryBreaksOccurringontheDay1", "NumberofSedentaryBreaksStartingontheDay1", "NumberofSedentaryBreaksEndingontheDay1", "TotaltimeofSedentaryBreaksOccuringonthisDay1", "Sedentary1", "Light1", "Moderate1", "Vigorous1", "TotalMVPA1", "inMVPA1", "Axis1Counts1", "Axis2Counts1", "Axis3Counts1", "Axis1AverageCounts1", "Axis2AverageCounts1", "Axis3AverageCounts1", "Axis1MaxCounts1", "Axis2MaxCounts1", "Axis3MaxCounts1", "Axis1CPM1", "Axis2CPM1", "Axis3CPM1", "VectorMagnitudeCounts1", "VectorMagnitudeAverageCounts1", "VectorMagnitudeMaxCounts1", "VectorMagnitudeCPM1", "StepsCounts1", "StepsAverageCounts1", "StepsMaxCounts1", "StepsPerMinute1", "LuxAverageCounts1", "LuxMaxCounts1", "NumberofEpochs1", "Time1", "CalendarDays1"];
opts.VariableTypes = ["categorical", "categorical", "double", "double", "double", "char", "char", "char", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "char", "char", "char", "char", "double", "char", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "char", "char", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "char", "double"];

% Specify variable properties
opts = setvaropts(opts, ["Gender", "Date", "DayofWeek", "inSedentary", "inLight", "inModerate", "inVigorous", "inMVPA", "VarName59", "DayofWeek1", "Time1"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Subject", "Filename", "Gender", "Date", "DayofWeek", "inSedentary", "inLight", "inModerate", "inVigorous", "inMVPA", "Time", "VarName59", "DayofWeek1", "Time1"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "Time", "DecimalSeparator", ",");

% Import the data
Daily_tbl = readtable([location filename], opts, "UseExcel", false);


%% Clear temporary variables
clear opts