# ActiMat

## _Tool to process behavioral data from ActiLife in Matlab_

> ActiMat calculates physical activity and sleep parameters from a pre-processed dataset. The tool enables researchers to efficiently process data files that have been exported in ActiLife software.

## General Information

The ActiMat tool is developed for processing analysed ActiGraph files in `MATLAB`. It is a research group-driven matlab tool for processing physical activity and sleep outcomes from multi-day analysed accelerometer data. The repository holds the code for generating the ActiGraph physical activity results from acceleration measured with an ActiGraph device. The ActiGraph wGT3X-BT (ActiGraph LLC, FL, USA) is a triaxial accelerometer and one of the most commonly used devices for assessing physical activity. Besides accelerometer data to estimate sedentary behaviour (i.e. inactive sitting), the tool also processes sleep data extracted using the Sadeh algorithm in closed-source proprietary ActiLife software. The matlab code provided in this repository is useful to read and generate results of 24HMB datasets. Sample data are available upon request. 

## 

## Features

List of the ready features:

- Read activity (`.xlsx`)  and sleep (`.csv`)  files
- Identify columns of interest (e.g., MVPA) 
- Validate the recordings based on time and worn days 
- Produce activity profile plot
- Calculate mean and weighed mean for week and weekend days
- Loop subject files organized in a nested parent folder
- Export results for statistical analysis in SPSS or MATLAB or R (`.xlsx`,`.sps`,`.mat`) 

## 

## Setup

**Tested datasets:** Verbestel, V. Obesity project. ; Kinaupenne, M. CFPA study; Willem, I. T2DM study.

## 

## Usage

Once the files are downloaded, you can run the application *MATLAB* locally or in the Athena environment. The matlab code is easy to use. The file `actimat.m` is the main script that calls on the other scripts and functions in the folder. Simply run the file  

```
actimat
```

## Technologies Used

- Matlab - successfully tested in versions 2019b, 2020b, 2021b

## Project Status

Project is  *in progress* (08/04/2022)

## Contact

Created by [Pieter Van den Berghe](pieter.vandenberghe@ugent.be)

> I hope that ActiMat will make it easier for researchers to work with 
> analysed ActiGraph data, and particularly the 24HMB datasets. 
> Researchers who encounter problems using the script, or have 
> suggestions for additional features, should not hesitate to contact me.