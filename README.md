LncPipe Reporter
================

A submodule for automated visualization and interactive reports.

Motivation
----------

This project is a part of LncPipe that take charge of automatically generating reports in `HTML` format with interactive plots based on pipeline output. It contains several ploting functions as well as analysis scripts to perform comparison analysis and differential expression analysis when experimental design information was available. We speculated this tools can facilitate understanding the underlining machanism of known and novel lncRNAs in their expriment.

Configuration
-------------

LncPipe Reporter currently only support **Unix-like operation system**.

> Because it contains several lines of *Perl 5 one-liner* for parsing multiple log files. I'll use pure R code instead in the future to make it a cross-platform package.

The main Rmarkdown file of LncPipe Reporter is an **R Markdown v2 document**, which need install `pandoc` first:

For Arch Linux:

``` bash
$ sudo pacman -S pandoc
```

For those runtime environment with `RStudio` (both desktop or server version is OK) installed before or more instructions, see [the rmarkdown document](https://github.com/rstudio/rmarkdown/blob/master/PANDOC.md).

To install this package:

``` r
install.packages("devtools")
devtools::install_github(c("bioinformatist/LncPipeReporter"))
```

How to use
----------

### Try the **simplest run** with default parameters

``` r
library(LncPipeReporter)
run_reporter()
```

### Specify the parameter values with **user-interface**

-   In the browser: Call `rmarkdown::render` function in R Console with its `params` set to `ask`, just like:

``` r
library(LncPipeReporter)
# DO NOT use T as short name of TRUE
run_reporter(ask = TRUE)
```

### Call with **user-defined** parameter values

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

### Call in **shell scripts** or **command line** (**Nextflow**, etc.)

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

Gallery
-------

Coming soon.

License
-------

This package is free and open source software, licensed under [GPL v3.0](https://github.com/bioinformatist/multiIP/blob/master/LICENSE).
