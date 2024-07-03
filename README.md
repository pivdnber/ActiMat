<p align="center"><img src="https://github.ugent.be/pivdnber/ActiGraphProcessing/blob/main/images/logo-small.png" alt="ActiMat" width="100" height="100"></p>

# ActiMat

## _Tool to process behavioral data from ActiLife in Matlab_

> ActiMat calculates physical activity and sleep parameters from a pre-processed 24HMB dataset. The tool enables researchers to efficiently process data files that have been exported in ActiLife software. 

## Table of Contents

- [General Info](https://github.ugent.be/pivdnber/actimat/#general-information)
- [Features](https://github.ugent.be/pivdnber/actimat/#features)
- [Setup](https://github.ugent.be/pivdnber/actimat/#setup)
- [Usage](https://github.ugent.be/pivdnber/actimat/#usage)
- [Technology used](https://github.ugent.be/pivdnber/actimat/#technologies-used)
- [Screenshot](https://github.ugent.be/pivdnber/actimat/#screenshot)
- [Project status](https://github.ugent.be/pivdnber/actimat/#project-status)
- [Acknowledgements](https://github.ugent.be/pivdnber/actimat/#acknowledgements)
- [Conflict of interest](https://github.ugent.be/pivdnber/actimat/#conflicts-of-interest)
- [License](https://github.ugent.be/pivdnber/actimat/#license)
- [Contact](https://github.ugent.be/pivdnber/actimat/#contact)

## General Information

The ActiMat tool is developed for processing analysed ActiGraph files in `MATLAB`. It is a research group-driven matlab tool for processing physical activity and sleep outcomes from multi-day analysed accelerometer data. The repository holds the code for generating the ActiGraph physical activity results from acceleration measured with an ActiGraph device. The ActiGraph wGT3X-BT (ActiGraph LLC, FL, USA) is a triaxial accelerometer and one of the most commonly used devices for assessing physical activity. Besides accelerometer data to estimate sedentary behaviour (i.e. inactive sitting), the tool also processes sleep data extracted using the Sadeh algorithm in closed-source proprietary ActiLife software. The matlab code provided in this repository is useful to read and generate results of 24HMB datasets. Sample data of a dataset are made available to try out the tool. 

Explanation in Dutch for UGent colleagues [*here*](https://ugentbe-my.sharepoint.com/:v:/g/personal/pieter_vandenberghe_ugent_be/EYTnQpx9TR9LsCWqHpxjj9MBNjh_Vh0iKhWabzv9VgBo2Q?e=5BpKcA).

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

Download the files: Click **CODE** then **DOWNLOAD ZIP** to save the source files to a secured folder. Total uncompressed size: less than 1 MB. The downloaded folder should contain the following files:  <span style="color:grey">actimat.m, export2spss.m, getFolders.m, process1subject.m, readfileMK.m </span>  

note: sample data have been added for demonstrative purposes. 

**Tested datasets:** Verbestel, V. Obesity project. ; Kinaupenne, M. CFPA study; Willem, I. T2DM study.

**Paper link:** When using pieces of the code, please cite the study describing their development. The link will be made available.  

## Usage

Once the files are downloaded, you can run the application *MATLAB* locally or in the Athena environment. The matlab code is easy to use. The file `actimat.m` is the main script that calls on the other scripts and functions in the folder. Simply run the file  

```
actimat
```

Check out the [scripts](https://github.ugent.be/pivdnber/actimat/tree/main/code) for more details and operational details.

## Technologies Used

- Matlab - successfully tested in versions 2019b, 2020b, 2021b

## Screenshot

![](C:\Users\pivdnber\OneDrive%20-%20UGent\Documenten\GitHub\ActiGraphProcessing\images\screenshot-matlab.png)

![Example screenshot](https://github.ugent.be/pivdnber/actimat/blob/main/images/ActiMat-gif.gif)

## Project Status

Project is *in progress*

The following areas have room for improvement 

- Systematic files naming by the researchers to minimize the code developed
- (visualisation of the generated datasheet)
- (computation of summary statistics)

## 

## Acknowledgements

There was no external funding received for this repository. The work was requested by the research group led by Prof. M De Craemer of the department of Rehabilitation Sciences. Many thanks to the local IT officer (Michiel D.) for screening the developed scripts. This readme was inspired by ritaly's [README-cheatsheet](https://github.com/ritaly/README-cheatsheet). 

## 

## Conflicts of Interest

There are no conflicts of interest relevant to this repository.

## License

> You can check out the full license [here](https://github.com/IgorAntun/node-chat/blob/master/LICENSE)

ActiMat is free but copyright software, distributed under the terms of the **MIT** license. In particular, ActiMat is supplied as is. No formal support or maintenance is provided or implied. ActiMat is currently developed and maintained by its creator.

## Contact

Created by [Pieter Van den Berghe](pieter.vandenberghe@ugent.be) - feel free to contact me

> I hope that ActiMat will make it easier for researchers to work with 
> analysed ActiGraph data, and particularly the 24HMB datasets. 
> Researchers who encounter problems using the script, or have 
> suggestions for additional features, should not hesitate to contact me.

\---