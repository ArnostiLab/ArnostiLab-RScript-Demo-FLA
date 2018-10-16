#change to zero manually identified samples in ChangeToZeroKeys_shelf1234.txt
#read in output from FlaRates_Rdemo.R
master.bulk <- read.csv("FlaRates_Rdemo.csv",row.names=1)
#define file name you want to save your output as
outputMaster <- "FlaRatesZeroCorrected_Rdemo.csv"
#zero-correction reference file
zero.ref <- "reference-files/ChangeToZeroKeys_shelf1234.txt"

#zero correction reference file
zeros <- read.table(zero.ref, sep=",")

for (key in zeros) {
    key <- as.character(key)
    master.bulk[grep(pattern=key,row.names(master.bulk)),"mean.kcrate.nM.hr"] <- 0
}

write.csv(master.bulk,outputMaster,quote=FALSE)