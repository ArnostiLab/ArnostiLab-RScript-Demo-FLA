# Calculating FLA hydrolysis rates

to follow this tutorial, navigate to the directory you want the tutorial folder to be in and clone this repository to your computer by running the following command in your terminal: 

`git clone https://github.com/ahoarfrost/ArnostiLab-RScript-Demo.git`

This will create a folder called "ArnostiLab-RScript-Demo" with the necessary files in whatever your current working directory is.

Look in the directory you downloaded:

```
cd ArnostiLab-RScript-Demo
ls
```

## Why bother? 
![alt text](https://github.com/ahoarfrost/ArnostiLab-RScript-Demo/blob/master/geeks.png "Geeks are more efficient than you")

## Steps to Processing GPC results and Calculate FLA hydrolysis rates

1. **RawGpcProcess.R**: Slant correct raw .asc output from GPC and output as .csv; also visualize chromatograms as .png and output

2. Define and visualize std bins

3. Calculate hydrolysis rates


## 1 - Slant correct raw GPC data

The **RawGpcProcess.R** script takes any raw .asc output file from the GPC, slant corrects it, and produces a slant-corrected file of the same name with a .csv extension (you can open this in Excel to look at it manually). It also visualizes the chromatogram and produces a file of the same name with a png extension

#### Organize your files

1. Put any .asc files you want to slant correct in a folder. You can name it whatever you want. For this tutorial, I provided some .asc files from EN556 bulk water incubations in a folder called "raw-asc".

2. Decide the name of the folders where you want to output your slant corrected .csv files and chromatogram images. I'm going to call these folders 'csvs-for-rates' and 'chroms-png'. 

3. Open the RawGpcProcess.R script in RStudio. Change lines 5, 7, and 9 to reflect the folders that contain/will contain the .asc, .csv, and .png files. 