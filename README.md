LncPipe Reporter
================

A submodule for automated visualization and interactive reports.

Motivation
----------

[Qi Zhao](https://github.com/likelet)'s [workflow](git.oschina.net/likelet/workflow) need a tool for automatically generating reports in `HTML` format with interactive plots.

Configuration
-------------

The main Rmarkdown file of MultiIP is an **R Markdown v2 document**, which need install `pandoc` first:

For Arch Linux:

``` bash
$ sudo pacman -S pandoc
```

For those runtime environment with `RStudio` (both desktop or server version is OK) installed before or more instructions, see [the rmarkdown document](https://github.com/rstudio/rmarkdown/blob/master/PANDOC.md).

How to use
----------

### Simply run with default parameters

``` bash
$ Rscript -e "rmarkdown::render('./reporter.Rmd')"
```

Parameters with their labels and default values were listed

### Specify the parameter values with user-interface

-   With R package `knitr`: Choose "Knit" -&gt; "Knit with Parameters" in RStudio, then adjust the parameters in the message dialog box.
-   In the browser: Call `rmarkdown::render` function in R Console with its `params` set to `ask`, just like:

``` bash
$ Rscript -e "rmarkdown::render('./reporter.Rmd', params = 'ask')"
```

### Specify the parameter values in command line (Recommended)

List the paramters with values as a R `list` object:

``` bash
$ Rscript -e "rmarkdown::render('./reporter.Rmd', params = list(output = 'output.html'))"
```

Gallery
-------

Later.

License
-------

This package is free and open source software, licensed under [GPL v3.0](https://github.com/bioinformatist/multiIP/blob/master/LICENSE).
