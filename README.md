# CNVseq v1.0

## What does this app do?

CNVseq identifies copy number variants (CNVs) from whole genome sequencing (WGS) data. Mapped short reads are collected into genomic windows, corrected for GC percentage and used to calculate sample-reference ratios. An increase in sample read-depth across a window when compared to the reference sample represents a gain in genomic material and a reduction in read-depth suggests a loss. The general approach is described by Wood et al. (2010) with a validation for germline cytogenetic diagnosis reported by Hayes et al. (2013).

This app packages the CNVseq variant caller for the DNA Nexus platform.

## What are typical use cases for this app?

This app is designed to be run on a single WGS sample to call CNVs using CNVseq.

## What data are required for this app to run?

The following inputs are required for this app to run:
* Alignment file (`*.bam`) from alignment of a human WGS sample to the **hg19** reference genome using BWA

Additionally, an optional window size seed value can be passed to the app for use in genomic window size calculations. The window size is calculated in CNVseq as follows:
window size = ( seed * reference read count ) / samle read count

## What does this app output?

CNVs are reported where the log2 sample-reference ratio is outside the defined cut-offs. Here, -0.55 for a copy number loss and +0.24 for a copy number gain. This app produces the following output files:
* `*.bed` - A BED graph produced by DNAcopy (from [Bioconductor](https://bioconductor.org/packages/release/bioc/html/DNAcopy.html)). This output BED file contains the coordinates of CNVs along with the log2 ratio
* `*.html` - A printable CNVseq analysis report sheet for the sample in HTML format
* `*.seg` and `*.segpoints` - Files containing the locations of genomic windows produced by the segmentation algorithm
* `*.pdf` - A pdf file containing plots of the copy number ratios for each chromosome
* `images/*.png` and `images/*.svg` - Raw image files of copy number plots used in the output PDF.

## This app was made by Viapath Genome Informatics

## References

Wood, H.M., Belvedere, O., Conway, C., Daly, C., Chalkley, R., Bickerdike, M., McKinley, C., Egan, P., Ross, L., Hayward, B. and Morgan, J., 2010. Using next-generation sequencing for high resolution multiplex analysis of copy number variation from nanogram quantities of DNA from formalin-fixed paraffin-embedded specimens. Nucleic acids research, 38(14), pp.e151-e151.

Hayes, J.L., Tzika, A., Thygesen, H., Berri, S., Wood, H.M., Hewitt, S., Pendlebury, M., Coates, A., Willoughby, L., Watson, C.M. and Rabbitts, P., 2013. Diagnosis of copy number variation by Illumina next generation sequencing is comparable in performance to oligonucleotide array comparative genomic hybridisation. Genomics, 102(3), pp.174-181.