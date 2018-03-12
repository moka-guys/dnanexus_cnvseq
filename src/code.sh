#!/bin/bash

# The following line causes bash to exit at any point if there is any error
# and to output each line as it is executed -- useful for debugging
set -e -x -o pipefail

# Extract binaries for cnvseq
unzip cnvseq.zip
# Install libraries required by R from apt-get repositories
sudo apt-get install -y libtcl8.6 libtk8.6
# Install samtools, gawk and R from bundled .deb packages
sudo dpkg --install *.deb
# Install DNA copy
sudo R CMD INSTALL DNAcopy_1.52.0.tar.gz

# Download input BAM file
dx-download-all-inputs
# Create the input directory expected by CNVseq
mkdir -p RUNDIR/Sample_1/bam/
# Move input BAM to CNVseq input directory
mv ${input_bam_path} RUNDIR/Sample_1/bam/

# Assign the CNVseq.sh "PROG_DIR" constant to the cnvseq directorysed -i "s/PROG_DIR=.*/PROG_DIR=\/home\/dnanexus\/cnvseq/g" ../cnvseq/CNVseq.sh    on the worker
sed -i "s/PROG_DIR=.*/PROG_DIR=\/home\/dnanexus\/cnvseq/g" cnvseq/CNVseq.sh

# Run CNVseq on input BAM file
bash cnvseq/CNVseq.sh -r RUNDIR/

# Create output directory
outdir=out/cnvseq/cnvseq_out/${input_bam_prefix}; mkdir -p $outdir
# Move CNVseq results files for upload
mv RUNDIR/Sample_1/cnvseq/* $outdir

# Upload output files
dx-upload-all-outputs
