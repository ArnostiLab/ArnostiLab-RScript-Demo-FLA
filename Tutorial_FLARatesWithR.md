# Calculating FLA hydrolysis rates

to follow this tutorial, navigate to the directory you want the tutorial folder to be in and clone this repository to your computer by running the following command on your terminal/command line:

`git clone https://github.com/ahoarfrost/ArnostiLab-RScript-Demo.git`

This will create a folder called "ArnostiLab-RScript-Demo" with the necessary files in whatever your current working directory is.

Look in the directory you downloaded:

```
cd ArnostiLab-RScript-Demo
ls
```

## Why bother?
![alt text](https://github.com/ahoarfrost/ArnostiLab-RScript-Demo/blob/master/images-for-tut/geeks.png "Geeks are more efficient than you")

## Steps to Processing GPC results and Calculate FLA hydrolysis rates

1. **RawGpcProcess.R**: Slant correct raw .asc output from GPC and output as .csv; also visualize chromatograms as .png and output

2. **CalculateStdBins.R**: Define and visualize std bins

3. **FlaRates_Rdemo.R**: Calculate hydrolysis rates


## 1 - Slant correct raw GPC data

The **RawGpcProcess.R** script takes any raw .asc output file from the GPC, slant corrects it, and produces a slant-corrected file of the same name with a .csv extension (you can open this in Excel to look at it manually). It also visualizes the chromatogram and produces a file of the same name with a png extension

### Naming your raw GPC data

**This is a really crucial part of running these scripts. Your file naming format needs to match the lab file naming format agreed upon in previous years, so that the script knows what station, depth, substrate, rep, and timepoint each file corresponds to.**

The basic file format should look like this:

**stn##-d##-EXPTTYPE-SUBSTRATE-REP-t##.asc**

e.g., stn1-d1-bulk-ara-2-t3.asc; stn4-d2-bulk-lam-x-t5.asc

* **stn##**: the station number. You must have the string 'stn' followed by any number, e.g. stn1, stn4, stn36. You cannot use letters for station names.

* **d##**: The depth label sampled. You must have the string 'd' followed by any number, e.g. d0, d5, d12. You cannot use letters for depth names.

* **EXPTTYPE**: This is a fixed value and should generally be "bulk", "GF", or "LV" to reference the type of experiment being measured. There is a different script for running gravity filtration (GF) or large-volume (LV) incubations. In this tutorial, we are looking at bulk water incubations and this value should be 'bulk'.

* **SUBSTRATE**: This should be a lower case string referring to the lab-standard substrate label added to the incubtaion: ara, chon, fuc, lam, pul, xyl. Your life will be simpler if you use these abbreviations and don't make up your own (otherwise you'll have to adjust your HydrolysisCutsInfo.csv reference file column names). It MUST be lowercase, and CANNOT be Ara, Chn, Fuc, Lam, Pul, Xyl.

* **REP**: Either a single integer or a single lower case letter. I generally use 1, 2, 3, and x to reference live replicate 1, live replicate 2, live replicate 3, and the kill control respectively.

* **t##**: The timepoint sampled. This should be the lower case letter "t" followed by any integer, e.g. t0, t1, t8.

*Each section of the file name should be separated by a dash, not an underscore/space/anything else.*

The above *can* be changed in the rate script if you want to make your own labeling scheme, if you understand regular expressions. There are many written and video tutorials out there for using regular expressions in R, if you want to learn them. The relevant lines of code to adjust are in lines 46-49.

### Organize your files

1. Put any .asc files you want to slant correct in a folder. You can name it whatever you want. For this tutorial, I provided some .asc files from EN556 bulk water incubations in a folder called "raw-asc".

2. Decide the name of the folders where you want to output your slant corrected .csv files and chromatogram images. I'm going to call these folders 'slant-corrected-csv' and 'chroms-png'.

3. Open the RawGpcProcess.R script in RStudio. Change lines 5, 7, and 9 to reflect the folders that contain/will contain the .asc, .csv, and .png files.

![alt text](https://github.com/ahoarfrost/ArnostiLab-RScript-Demo/blob/master/images-for-tut/rawgpcfolders.png)

4. Run the script. You can do this in RStudio by pressing the "Source" button in the top right of the script window you want to run. (You can also do this in the RStudio console by running: `source("scripts/RawGpcProcess.R")`).

You will now see the folders 'slant-corrected-csv' and 'chroms-png' with the slant corrected .csv files and the chromatogram images within them. You can then page through the chromatograms to look for reruns, etc.

## 2 - Calculate standard bins

Before calculating rates, you need to deduce the standard bin cutoffs for all the standards you ran with your chromatograms.

### Organize your files

I like to put all the relevant standards in a folder called 'stds', and within that let each standard set have its own folder. For this tutorial, you will find a provided folder called 'stds' with the 'raw-asc' chromatogram output for that run in it.

**VERY IMPT**: Name your standard files to begin with the standard that is run. This should be either 150kD, 10kD, 4kD, GAL, or FLA. The script looks for files that begin with those strings to identify which standard is which. The rest of the file name can be whatever you want.

### Slant correct your standard data as you did for your samples

1. Change your working directory to the standards folder you want to process.
2. Run the RawGpcProcess.R script in this folder.
3. Do this for all standards folders you want to process.
4. Change your working directory back to your main folder.

You can do this in RStudio by running:
```
setwd("stds/stds-gpc3-072715")
source("../../scripts/RawGpcProcess.R")
setwd("../stds-gpc2-071515/")
source("../../scripts/RawGpcProcess.R")
setwd("../..")
```

### Calculate standard bins

1. In RStudio, change lines 9, 11, and 13 in the script "CalculateStdBins.R" to reflect the path of the slant-corrected csv files to use for the calculation, the output path and file name of the .csv calculated file info, and the output path and file name of the standard bin visualization, respectively. Make sure these paths are relevant to the working directory you're in (for us, this should be the main folder we downloaded):

![alt text](https://github.com/ahoarfrost/ArnostiLab-RScript-Demo/blob/master/images-for-tut/stdbinspaths.png)

I like to name the output files 'stdbins-gpc#-MMDDYY...', but you can name it whatever you want.

2. Run the CalculateStdBins script by pressing the "Source" button in RStudio or running the command in RStudio: `source("scripts/CalculateStdBins.R")`

3. Repeat steps 1 and 2 for all standard bin folders you want to calculate bins for.

Now you can look at the std bins .csv in excel, or look at the .png to sanity check if the cutoffs look reasonable. It should look something like this:

![alt text](https://github.com/ahoarfrost/ArnostiLab-RScript-Demo/blob/master/images-for-tut/stdbins-gpc2-071515.png)

## 3 - Calculate FLA hydrolysis rates

### Create your timesheet/std refs spreadsheet

This spreadsheet needs to manually created in Excel or something similar, so that the script knows 1) what was the elapsed time (from t0) for the rate calculation, and 2) what standard bins to use for the calculation. You need to provide this information from your lab notebook.

For this tutorial, a number of reference files you need for the script calculation are provided in the folder 'reference-files'. One of these is the time sampled and standard bin reference info.

When creating a new timesheet/std refs spreadsheet for a new project, the format of the spreadsheet should look like the "FlaTimepointsStdRefs_EN556stn1234.csv" file in the folder 'reference-files'. **Most importantly, make sure your rows have the sample name, exactly as it is in the 'slant-corrected-csv' folder (without the .csv suffix) - e.g. stn1-d1-bulk-chon-1-t1; have an elapsed.time.hrs column that contains sthe elapsed time since t0, in hours; and have a std.ref column with the file name prefix of the stdbins that should be used for that sample. This would be whatever you named your stdbins .csv output in step 1 of "Calculate standard bins" above, e.g. stdbins-gpc2-071515 or stdbins-gpc3-072715.**

### Make sure you have your hydrolysis cuts info in the reference files

This is provided in the 'reference-files' folder as "HydrolysisCutsInfo.csv". This contains information about the number of hydrolysis cuts to hydrolyze a substrate into the various molecular weight bins, etc. This information does not change from project to project so you can simply copy this file to each new project without editing. If down the road we add new substrates to the mix, simply create a new column in this file.

### Organize your files

1. Put all the .csv slant corrected files for the experiments you want to calculate rates for in a folder. In this tutorial, this is the 'slant-corrected-csv' folder we created in main folder in the first step. If you only wanted to calculate rates for a subset of these samples, you could copy the relevant files to a new folder. All of the samples from a single experiment should be together (e.g. all the live reps and kills for stn1-d1-ara). In general, you should put all timepoints in there too, although you could remove all the t3s if you wanted to ignore that timepoint, for example.

2. Put all your stdbin .csv sheets in a central folder. I like to create a folder called 'stdbins' within the 'reference-files' folder. You can do this on the command line by running the following commands:

```
mkdir reference-files/stdbins
cp stds/stds-gpc2-071515/stdbins-gpc2-071515.csv reference-files/stdbins/
cp stds/stds-gpc3-072715/stdbins-gpc3-072715.csv reference-files/stdbins/
```

### Adjust the reference header in FlaRates_XXX.R to be specific to your project

I generally create a new rates script for each project, so I can keep it in the project folder and preserve the heading I used for that project. The basic rate calculation is the same, but the information specific to the project - where the files to calculate rates for are, the incubation volume, the substrate concentration, etc. - can be adjusted depending on the project.

**Adjust lines 8-24 in the FlaRates_XXX.R script:**

* Line 9: the relative path of the folder containing the scripts you want to calculate. This should be 'slant-corrected-csv' for this tutorial.

* Line 11: the substrate abbreviations used in your file names. In general, these will be "ara, chon, fuc, lam, pul, xyl". If you didn't do incubations with all of these substrates or you added a substrate, this would be the place to adjust it.

* Line 13: your incubation volume, in liters. For this tutorial, we used 50mL , or 0.05.

* Line 15: the uM concentration of substrate used for each substrate. The default is 3.5 for all substrates except fuc, which is 5. Change these numbers if you used something different.

* Line 18: the relative path to the hydrolysis cuts reference file. For this tutorial, this is "reference-files/HydrolysisCutsInfo.csv".

* Line 20: the relative path to the timesheet/std ref reference file. For this tutorial, this is "reference-files/FlaTimepointsStdRefs_EN556stn1234.csv".

* Line 22: the relative path where your standard bin .csv files are centrally located. For this tutorial, this is "reference-files/stdbins/"

* Line 24: What you want your rate output file to be called. This can be whatever you want. I like to do "FlaRates_PROJECTNAME.csv". For this tutorial, I used "FlaRates_Rdemo.csv".

### Run the script!

You can press the "Source" button in RStudio, or run the following line in the RStudio console:

```
source("scripts/FlaRates_Rdemo.R")
```

This may take a few minutes, and will print some info to the console as it works.

# Calculating FLA hydrolysis rates for special cases

After you look at your chromatograms, you may want to change certain rates to zero, or recalculate rates while ignoring the FLA bin. Here's how to do that:

## Changing rates to zero

Do this after you run your initial FLA rates and have produced the output from FlaRates_Rdemo.R (in my case, I called this FlaRates_Rdemo.csv)

### Create a reference file defining the samples you want to change to zero

For this tutorial, I have provided a comma-separated (no spaces!) .txt file in the reference-files/ folder called ChangeToZeroKeys_shelf1234.txt. This file tells the script which incubations should be changed to zero. For your own project, use this as a template and adjust the incubation set names to be the ones you want to change to zero. You can specify particular timepoints if you want by adding something like stn1-d1-bulk-ara-t1 (rather than stn1-d1-bulk-ara, which will look for all timepoints from that incubation set).

### Adjust the header for FlaRatesSpecial_ZeroCorrection_Rdemo.R

**Adjust lines 3-7**

* Line 3: The file name of your rates output .csv from FlaRates_Rdemo.csv

* Line 5: What you want to call your zero-corrected rates file, as a csv file. This can be whatever you want, I've called it "FlaRatesZeroCorrected_Rdemo.csv".

* Line 7: The relative path to the zero correction reference file you created that tells the script which incubations should be changed to zero. Here, this is "reference-files/ChangeToZeroKeys_shelf1234.txt".

### Run the script!

You can press the "Source" button in RStudio, or run the following line in the RStudio console:

```
source("scripts/FlaRatesSpecial_ZeroCorrection_Rdemo.R")
```

## Calculating rates ignoring the FLA bin

### Create a reference file defining the samples you want to ignore the FLA bin for

For this tutorial, I have provided this as reference-files/IgnoreFlaBin_shelf1234.txt. As with the zero correction ref file, use this as a template to define the incubation set filename prefixes that you want to recalculate rates for. The filename prefixes should use the stn#-d#-[bulk]-[substrate] file naming format we defined when we calcuated rates originally.

### Adjust the header for FlaRatesSpecial_IgnoreFLA_Rdemo.R

This header looks a lot like the one we used for the FlaRates script, but with the extra reference file as well.

**Adjust lines 3-22**

* Line 4: Your most updated rates output file you want to update. If you've already done the zero correction above, this should be "FlaRatesZeroCorrected_Rdemo.csv"

* Line 6: the relative path to the reference file that defines which incubations you want to ignore the fla bin for. For this tutorial, I've provided this with "reference-files/IgnoreFlaBin_shelf1234.txt".

* Line 8: The folder containing your slant corrected csv files to use for rate calculations

* Line 10: the relative path to the hydrolysis cuts info ref file

* Line 12: the relative path to your timesheet/standard reference file

* Line 14: the relative path to your std bins folder where you're keeping your std bins output files from the standard bin calculation script

* Line 16: what you want to name your final rates output file. This can be whatever you want that is useful.

* Line 18: the substrates you're using

* Line 20: incubation volume, in liters

* Line 22: the incubation concentration you used for each substrate, in micromolar concentrations

### Run the script!

You can press the "Source" button in RStudio, or run the following line in the RStudio console:

```
source("scripts/FlaRatesSpecial_IgnoreFLA_Rdemo.R")
```
