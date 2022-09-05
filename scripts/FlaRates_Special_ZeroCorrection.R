#En 584 LV FLA Rates - Takes FLA Master List and Replaces rates that were calculated from unhydrolyzed samples with 0

master <- read.csv('FlaRates_TN362_071922.csv')

hydrolysis <- read.csv('HydrolyzedTimepoints.csv')

master <- master[,c('X', 'kcrate.1.nM.hr', 'kcrate.2.nM.hr', 'kcrate.3.nM.hr')]

out <- merge(master, hydrolysis)

out[grep("no", out$Rep1),]$kcrate.1.nM.hr <- 0

out[grep("no", out$Rep2),]$kcrate.2.nM.hr <- 0

out[grep("no", out$Rep3),]$kcrate.3.nM.hr <- 0

out$mean.kcrate.nM.hr = rowMeans(out[,2:4])

out$sd.kcrate.nM.hr <- apply(out[, c("kcrate.1.nM.hr", "kcrate.2.nM.hr", "kcrate.3.nM.hr")], 1, sd)

out <- subset(out, select = -c(Rep1, Rep2, Rep3))

master <- read.csv('FlaRates_TN362_071922.csv')
master <- subset(master, select = -c(kcrate.1.nM.hr, kcrate.2.nM.hr, kcrate.3.nM.hr, mean.kcrate.nM.hr, sd.kcrate.nM.hr))

out <- merge(master, out)

write.csv(out,"FlaRates_TN362_071922_Corrected_Final.csv", quote=FALSE)