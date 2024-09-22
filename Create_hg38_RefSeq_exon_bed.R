# This code is written on 09/20/2024 by David Hillis for Fulgent Bioinformatics Scientist I quiz
# This will read in the read depth output from samtools and provide:
# 1 - a csv file with a summary of the read depths
# 2 - a simple histogram of those read_depth (excluding outliers)

setwd("/home/davidhillis/Fulgent/")
gtf <- read.table(gzfile("hg38.ncbiRefSeq.gtf.gz"), sep = "\t")

# Extract chromosome, start, and end location for exons
exon <- gtf[which(gtf[,3]=="exon"),c(1,4,5)]

# Write the exon locations to the file
write.table(exon, "hg38_RefSeq_exons.bed", sep = "\t", row.names=FALSE, col.names=FALSE, quote=FALSE)
