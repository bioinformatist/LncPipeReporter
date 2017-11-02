LncPipeReporter
================

A R package for automatically aggregating and summarizing lncRNA analysis results.

Overview
--------

Most of bioinformatics tools, such as aligners like [STAR](https://github.com/alexdobin/STAR), [TopHat](http://ccb.jhu.edu/software/tophat/index.shtml) and [HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml) generate log files by default. A lastest nextflow-based lncRNA sequenceing data analysis pipeline, known as [LncPipe](https://github.com/likelet/LncPipe), produces a file containing lncRNA basic features.

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

-   **File can be found anywhere.** Users can put all up-stream analysis result files simply in a folder (even with other files). They will be found out **recursively** from the folder and its subdirectories.

-   **File types can be guessed.** Users **never** need designate file types explicitly or even send a file containing name list as a paramter when use LncPipe reporter.

-   **Flexible use.** User can send **arbitrary type or number** of files at a time, for instance, more than one STAR log files, or both STAR and HISAT2 log files, or even without any alignment log files.

-   **More themes available.** The users can apply for a series of pretty theme brought by ggsci. See [Parameters](#parameters) for details.

-   **High resolution static figures with detailed results in *csv* is provided.** User will get figures which can be used for publication in *tiff* format with *300 ppi resolution* and *lzw compression* performed. Also, LncPipeReporter bring you analysis result tables (comma-separated, can be opened/edited by *MS Excel*, etc.), for details, see [Results](#results).

Installation
------------

LncPipeReporter currently only support **Unix-like operation system**.

> Because it contains several lines of *Perl 5 one-liner* for parsing multiple log files. I'll use pure R code instead in the future to make it a cross-platform package.

The main reporter *Rmd* file is constructed from Rmarkdown files of **R Markdown v2 document**, so **you must install `pandoc` first**:

For Arch Linux:

``` shell
$ sudo pacman -S pandoc
```

For other operation systems or Linux distributions, see [pandoc's official documentation](https://pandoc.org/installing.html).

### Install binary version by [packrat](http://rstudio.github.io/packrat/) (**recommended**) (**still not ready**, preparing)

Coming soon!

### Build from source

> You can't build from source in **Microsoft-R-Open** now due to [its bug](https://github.com/Microsoft/microsoft-r-open/issues/26).

For some packages need `fortran` for compiling, you should install fortran compiler first:

``` shell
$ sudo apt-get install gfortran
```

Run in R session:

``` r
install.packages("devtools")
devtools::install_github("bioinformatist/LncPipeReporter")
```

If `devtools::install_github()` raise `Installation failed: Problem with the SSL CA cert (path? access rights?)` error, try:

``` r
install.packages(c("curl", "httr"))
```

During installation there may be some configuration error (lack of libraries):

``` pre
------------------------- ANTICONF ERROR ---------------------------
Configuration failed because libcurl was not found. Try installing:
 * deb: libcurl4-openssl-dev (Debian, Ubuntu, etc)
 * rpm: libcurl-devel (Fedora, CentOS, RHEL)
 * csw: libcurl_dev (Solaris)
If libcurl is already installed, check that 'pkg-config' is in your
PATH and PKG_CONFIG_PATH contains a libcurl.pc file. If pkg-config
is unavailable you can set INCLUDE_DIR and LIB_DIR manually via:
R CMD INSTALL --configure-vars='INCLUDE_DIR=... LIB_DIR=...'
--------------------------------------------------------------------
```

Just follow the instruction to satisfy the dependencies. For instance, you can run `sudo apt-get install libcurl4-openssl-dev` in *Ubuntu* to fix the problem above.

> LncPipeReporter use Bioconductor package *edgeR* to perform differential expression analysis, so if you get `'BiocInstaller' must be installed to install Bioconductor packages.`, please choose `1 (Yes)`. Since then you may see `Installation failed: cannot open the connection to 'https://bioconductor.org/biocLite.R'`, run `source('http://bioconductor.org/biocLite.R')`, finally try the installation commands above again.

> Please wait for minutes then **try again** if solving some dependencies from *GitHub* fails with `Connection timed out after 100001 milliseconds`.

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
$ Rscript -e "library(LncPipeReporter); run_reporter(input = '.', ...)"
```

> `...` stands for other arguments. You should use **single-quotes** here.

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
<td>index file name (In HTML format)</td>
</tr>
<tr class="odd">
<td>output_dir</td>
<td><code>~/LncPipeReports</code></td>
<td>output directory (who holds all results and dependencies)</td>
</tr>
<tr class="even">
<td>theme</td>
<td><code>npg</code></td>
<td>Journal palette applied to all plots supplied by <a href="https://cran.r-project.org/web/packages/ggsci/vignettes/ggsci.html#discrete-color-palettes">ggsci</a></td>
</tr>
<tr class="odd">
<td>cdf.percent</td>
<td><code>10%</code></td>
<td>Percentage of values to display when calculating coding potential</td>
</tr>
<tr class="even">
<td>max.lncrna.len</td>
<td><code>10000</code></td>
<td>Maximum length of lncRNAs to display when calculating distribution</td>
</tr>
<tr class="odd">
<td>min.expressed.sample</td>
<td><code>50%</code></td>
<td>Minimal percentage of expressed samples</td>
</tr>
<tr class="even">
<td>ask</td>
<td>FALSE</td>
<td>need set parameters with graphical user-interface in browser?</td>
</tr>
</tbody>
</table>

For details and examples, please type `help(run_reporter)` or `?run_reporter` in R session for documentation.

Results
-------

By default, LncPipeReporter will generate a directory named as `LncPipeReports` at your `$HOME` (**you can [set another place](#parameters) yourself**) that holds all results as well as dependencies, so you should always move/copy the **whole** folder. The contents of the output directory seems like:

``` pre
LncPipeReports
├── figures
│   ├── CDF.tiff
│   ├── HISAT2.tiff
│   ├── lncRNA_length_distribution.tiff
│   ├── lncRNA_length_distribution_with_type.tiff
│   ├── pca.tiff
│   ├── STAR.tiff
│   ├── TopHat2.tiff
│   └── vocano.tiff
├── libs
│   ├── bootstrap-3.3.5
│   ├── crosstalk-1.0.0
│   ├── datatables-binding-0.2
│   ├── dt-core-1.10.12
│   ├── dt-ext-buttons-1.10.12
│   ├── dt-plugin-searchhighlight-1.10.12
│   ├── htmlwidgets-0.9
│   ├── ionicons-2.0.1
│   ├── jquery-1.12.4
│   ├── jszip-1.10.12
│   ├── pdfmake-1.10.12
│   ├── plotly-binding-4.7.1
│   ├── plotlyjs-1.29.2
│   ├── stickytableheaders-0.1.19
│   └── typedarray-0.1
├── reporter.html
└── tables
    ├── DE.csv
    ├── HISAT2.csv
    ├── lncRNAs.csv
    ├── STAR.csv
    └── TopHat2.csv
```

Gallery
-------

Coming soon.

License
-------

This package is free and open source software, licensed under [GPL v3.0](LICENSE).
