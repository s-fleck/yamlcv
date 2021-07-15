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

**yamlcv** provides a single function for rendering CVs. Please refer to the 
example file included in the package for details on how the input yaml files
should be structured.

``` yaml
# experience.yaml  [excerpt]

experience:
  - title: Data science and data management
    organization: Statistik Austria
    location: Vienna
    date: "2016 -- 2021"
    description: |
        * Setting up an alaysis database for management and analysis of transport data (DB/2)
        * Implementing a REST Service for validation and cleaning GPS data
        * Development of a model for using truck tolling data to improve freight statistics
        * Development of R/Shiny web applications

education:
  - degree: Msc Natural Resource Management and Ecological Engineering
    institution: University of Natural Resources and Life Sciences / Lincoln University
    location: Vienna (AT) / Christchurch (NZ)
    date: '2009 -- 2012'

```

``` r
  f <- system.file("examples", "experience.yaml", package = "yamlcv")
  tf <- render_cv(f, output = tempfile(fileext = ".pdf"))
  cat(tf)  # open in pdf viewer
```

## See also

[Awesome-CV](https://github.com/posquit0/Awesome-CV): The latex template used
by this package.

