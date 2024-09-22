#!/bin/bash -l

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32GB
#SBATCH --output=./error/Fulgent_quiz_%j.out
#SBATCH --error=./error/Fulgent_quiz_%j.err
#SBATCH --mail-user=davidhillis@ucsb.edu
#SBATCH --mail-type=ALL
#SBATCH --time=15-00:00:00
#SBATCH --job-name="Fulgent_quiz"

# Created on 09/20/2024 for Fulgent Bioinformatics Scientist I quiz by David Hillis
# This code will run using conda environment "general"
# This is a premade environment for trimming, aligning, and variant/methylation calling 
# This will all be done in the working directory "/home/davidhillis/Fulgent/"

# For some reason, this server struggles to locate code loaded into a conda environment
# Identifying the folder is a consistently reliable solution to this
scripts="/home/davidhillis/anaconda3/envs/general/bin/"

# Download hg38 RefSeq GTF for exon locations 
#wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/genes/hg38.ncbiRefSeq.gtf.gz

# Download hg38 genome for depth extraction from CRAM file 
#wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz

# Download CRAM file (because bam did not appear available at https://www.internationalgenome.org/data-portal/sample/NA12878)  
#wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000_genomes_project/data/CEU/NA12878/exome_alignment/NA12878.alt_bwamem_GRCh38DH.20150826.CEU.exome.cram

# Download CRAM index file
#wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000_genomes_project/data/CEU/NA12878/exome_alignment/NA12878.alt_bwamem_GRCh38DH.20150826.CEU.exome.cram.crai

# Rscript to create a bed file of exon locations from the GTF
#${scripts}Rscript Create_hg38_RefSeq_exon_bed.R

# Samtools was previously loaded using into conda environment
#${scripts}samtools depth -b hg38_RefSeq_exons.bed NA12878.alt_bwamem_GRCh38DH.20150826.CEU.exome.cram > NA12878_coverage.txt

# This is a simple R script written to summarize the coverage and provide visuals
${scripts}Rscript Fulgent_coverage_summary.R


