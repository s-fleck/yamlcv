# yamlcv

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

Generate beautiful CVs from 'yaml' files. Currently only supports generating
pdf CVs based on posquit0's [Awesome-CV](https://github.com/posquit0/Awesome-CV) 
latex template, but in theory more templates and output formats could be 
supported.

## Installation



``` r
# install.packages("remotes")
remotes::install_github("s-fleck/yamlcv")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
  f <- system.file("examples", "experience.yaml", package = "yamlcv")
  tf <- render_cv(f, output = tempfile(fileext = ".pdf"))
  cat(tf)  # open in pdf viewer
```

## See also

[Awesome-CV](https://github.com/posquit0/Awesome-CV): The latex template used
by this package.

