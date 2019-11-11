#!/usr/bin/Rscript

D = read.table("stdin", col.name=c("GC_Ratio"))
png("/dev/stdout")
hist(D$GC_Ratio, labels=T, col="burlywood", main="GC Ratio frequency of yeast", xlab="GC Ratio")
dev = dev.off()
