LncPipeReporter
================

A R package for automatically aggregating and summarizing lncRNA analysis results.

Overview
--------

Most of bioinformatics tools, such as aligners like [STAR](https://github.com/alexdobin/STAR), [TopHat](http://ccb.jhu.edu/software/tophat/index.shtml) and [HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml) generate log files by default. A lastest nextflow-based lncRNA sequenceing data analysis pipeline, known as [LncPipe](), produces a file containing lncRNA basic features.

This project is a part of LncPipe (but can also be used solely) that take charge of automatically generating reports in `HTML` format with interactive plots based on pipeline output. It contains several ploting functions as well as analysis scripts to perform comparison analysis and differential expression analysis when experimental design information was available. We speculated this tools can facilitate understanding the underlining machanism of known and novel lncRNAs in their experiment.

Features
--------

-   **Common result files in lncRNA sequencing data analysis pipeline are well suppoted.** The package is designed to handle with several types of files (click to see the example file content):

    -   [STAR log file](inst/extdata/demo_results/LWS2.Log.final.out)
    -   [HISAT2 log file](inst/extdata/demo_results/N1037.log)
    -   [TopHat log file](inst/extdata/demo_results/align_summary.txt)
    -   [Experimental design information](inst/extdata/demo_results/design.file)
    -   [RSEM or expression matrix from other tools](inst/extdata/demo_results/lncRNA.rsem.count.txt)
    -   [Basic features of lncRNAs](inst/extdata/demo_results/basic_charac.txt)

-   **File can be found anywhere**. Users can put all up-stream analysis result files simply in a folder (even with other files). They will be found out **recursively** from the folder and its subdirectories.

-   **File types can be guessed.** Users **never** need designate file types explicitly or even send a file containing name list as a paramter when use LncPipe reporter.

-   **Flexible use.** User can send **arbitrary type or number** of files at a time, for instance, more than one STAR log files, or both STAR and HISAT2 log files, or even without any alignment log files.

Configuration
-------------

LncPipeReporter currently only support **Unix-like operation system**.

> Because it contains several lines of *Perl 5 one-liner* for parsing multiple log files. I'll use pure R code instead in the future to make it a cross-platform package.

The main reporter *Rmd* file is constructed from Rmarkdown files of **R Markdown v2 document**, so **you must install `pandoc` first**:

For Arch Linux:

``` bash
$ sudo pacman -S pandoc
```

For other operation systems or Linux distributions, see [pandoc's official documentation](https://pandoc.org/installing.html).

To install this package:

``` r
install.packages("devtools")
devtools::install_github("bioinformatist/LncPipeReporter")
```

To test installation:

``` r
library(LncPipeReporter)
# For testing multipe sample case (default)
run_reporter()
# For testing lacking certain parts case
run_reporter(input = system.file(file.path("extdata", "demo_results_lack_part"),package = "LncPipeReporter"))
# For testing single sample case
run_reporter(input = system.file(file.path("extdata", "demo_results_single_sample"),package = "LncPipeReporter"))
```

How to use
----------

> Caution: Though users never need specify file types, the sample name should be embedded in the **first part** of file name's prefix, for example, the sample name of *LWS2.Log.final.out* and *N1037.log* will be obtained as *LWS2* and *N1037*.

### Try the simplest run with default parameters

``` r
library(LncPipeReporter)
run_reporter()
```

### Specify the parameter values with user-interface

``` r
library(LncPipeReporter)
# DO NOT use T as short name of TRUE
run_reporter(ask = TRUE)
```

### Call with user-defined parameter values

``` r
library(LncPipeReporter)
run_reporter(input = system.file(file.path("extdata", "demo_results"),package = "LncPipeReporter"),
             output = 'reporter.html',
             theme = 'npg',
             cdf.percent = 10,
             max.lncrna.len = 10000,
             min.expressed.sample = 50,
             ask = FALSE)
```

### Call in shell scripts or command line (Nextflow, etc.)

List the paramters with values as a R `list` object:

``` bash
$ Rscript -e "library(LncPipeReporter); run_reporter(...)"
```

Parameters with their names and default values were listed below:

### Parameters

<table style="width:57%;">
<colgroup>
<col width="16%" />
<col width="20%" />
<col width="19%" />
</colgroup>
<thead>
<tr class="header">
<th>Name</th>
<th>Default value</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>input</td>
<td><code>extdata/demo_results</code></td>
<td>Absolute path of input directory (results of up-stream analysis)</td>
</tr>
<tr class="even">
<td>output</td>
<td><code>~/reporter.html</code></td>
<td>Output file name (In HTML format)</td>
</tr>
<tr class="odd">
<td>theme</td>
<td><code>npg</code></td>
<td>Journal palette applied to all plots supplied by <a href="https://cran.r-project.org/web/packages/ggsci/vignettes/ggsci.html#discrete-color-palettes">ggsci</a></td>
</tr>
<tr class="even">
<td>cdf.percent</td>
<td><code>10%</code></td>
<td>Percentage of values to display when calculating coding potential</td>
</tr>
<tr class="odd">
<td>max.lncrna.len</td>
<td><code>10000</code></td>
<td>Maximum length of lncRNAs to display when calculating distribution</td>
</tr>
<tr class="even">
<td>min.expressed.sample</td>
<td><code>50%</code></td>
<td>Minimal percentage of expressed samples</td>
</tr>
</tbody>
</table>

For details, please type `help(run_reporter)` or `?run_reporter` in R session for documentation.

Gallery
-------

Coming tomorrow.

License
-------

This package is free and open source software, licensed under [GPL v3.0](LICENSE).
