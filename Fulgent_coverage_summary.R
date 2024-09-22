# This code is written on 09/20/2024 by David Hillis for Fulgent Bioinformatics Scientist I quiz
# This will read in the read depth output from samtools and provide:
# 1 - a csv file with a summary of the read depths
# 2 - a simple histogram of those read_depth (excluding outliers)

setwd("/home/davidhillis/Fulgent/")
data <- read.table("NA12878_coverage.txt", sep = "\t")

# Create empty output file
coverage_summary <- as.data.frame(matrix(NA, nrow=0, ncol=3))
colnames(coverage_summary) <- c("depth", "genome_proportion", "genome_>=_this_depth")

# Calculate average coverage
coverage_summary[1,1] <- mean(data[,3])
coverage_summary[1,2] <- "genome_mean"
coverage_summary[1,3] <- sum(data[,3]>=coverage_summary[1,1])/nrow(data)
n <- 2

# Calculate coverage for each depth
depth <- unique(data[,3])
depth <- depth[order(depth)]

for (i in depth) {
  coverage_summary[n,1] <- i
  coverage_summary[n,2] <- sum(data[,3]==i)/nrow(data)
  coverage_summary[n,3] <- sum(data[,3]>=i)/nrow(data)
  n <- n+1
}

# Write the output file
write.csv(coverage_summary, "summary_of_NA12878_at_different_depths.csv", row.names=FALSE)

library(ggplot2)

# Remove depths representing less than 1/1000th of the genome
plotdata <- coverage_summary[-1,]
plotdata <- plotdata[which(as.numeric(plotdata[,2])>=0.001),]

# Produce a simple histogram of results with a red line for mean depth
jpeg(paste("histogram_of_NA12878_coverage.jpg", sep = ""), width = 3000, height = 3000, res=300)
ggplot(plotdata, aes(x=depth, y=as.numeric(genome_proportion))) + 
  geom_histogram(stat="identity") +
  theme_classic(base_size = 20) + 
  labs(title="NA12878 Exon Coverage",x="Depth", y = "Proportion of Genome") 
dev.off()

