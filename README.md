MultiIP -- Multiple Interactive Plots
================

Motivation
----------

[Qi Zhao](https://github.com/likelet)'s [workflow](git.oschina.net/likelet/workflow) need a tool for automatically generating reports in `HTML` format with interactive plots.

Configuration
-------------

The main Rmarkdown file of MultiIP is an R Markdown v2 document, which need install `pandoc` first:

For Arch Linux:

``` bash
sudo pacman -S pandoc
```

For those runtime environment with `RStudio` (both desktop or server version is OK) installed before or more instructions, see [the rmarkdown document](https://github.com/rstudio/rmarkdown/blob/master/PANDOC.md).

How to use
----------

``` bash
Rscript -e "rmarkdown::render('./reporter.Rmd')"
```

Gallery
-------

Later.

License
-------

This package is free and open source software, licensed under [GPL v3.0](https://github.com/bioinformatist/multiIP/blob/master/LICENSE).
