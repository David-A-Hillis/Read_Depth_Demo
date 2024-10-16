# Read Depth Determination for GIAB, NA12878/HG001

The scripts in the current directory were created as to demonstrate read depth calculations for exome data

It includes three separate files: \
&emsp;  [bash] 1 Depth_Demo.sh \
&emsp;  [R] 2 Create_hg38_RefSeq_exon_bed.R \
&emsp;  [R] 3 Coverage_summary.R 

The entire process can be completed by running the bash script which calls the R scripts.
The three files are downloaded: \
&emsp;  hg38.ncbiRefSeq.gtf.gz (GTF file from UCSC Genome Browser) \
&emsp;	NA12878.alt_bwamem_GRCh38DH.20150826.CEU.exome.cram (available at www.internationalgenome.org) \
&emsp;	NA12878.alt_bwamem_GRCh38DH.20150826.CEU.exome.cram.crai (available at www.internationalgenome.org) 

The purpose of this code is to determine the coverage of the NA12878 CRAM file.
Since this is an exome file aligned to human genome build hg38, the sequence targets should be exons similarly to those identified by the hg38.ncbiRefSeq.gtf. Therefore, it is the focus of this code to identify coverage in ranges identified as exons. 

Create_hg38_RefSeq_exon_bed.R creates a bed file of annotated exons which are then used to identify genomic regions for coverage extraction using the samtools depth tool. Fulgent_coverage_summary.R calculates mean coverage and the proportion of the genome at each read depth as well as the proportion of the genome at or greater than the indicated depth. 

A table is saved as a CSV (comma-delimited) file with these calculated values and a simple histogram (saved as a JPEG) of any depth representing at least 0.1% of the exome is produced.

Running this code requires: samtools (v1.21), R (v4.4.1), and ggplot2 (v3.5.1)

# Results
The mean coverage for the exome is 55.587. Though, more than half of the loci had coverage of less than 6 reads.
It should be noted that coverage for the genome (calculated with the same scripts as above except extracting a random 100,000,000 loci from the complete CRAM file) was 10.44 on average, indicating a notable amount of off target sequencing.

