

# ropenaire

[![Build Status](https://travis-ci.org/njahn82/ropenaire.svg?branch=master)](https://travis-ci.org/njahn82/ropenaire)
[![codecov.io](http://codecov.io/github/njahn82/ropenaire/coverage.svg?branch=master)](http://codecov.io/github/njahn82/ropenaire?branch=master)

## About

`ropensci` gives access to the [OpenAIRE API](http://api.openaire.eu/)with R. The [OpenAIRE](https://www.openaire.eu/) project facilitates Open Access repository interoperability and supports Open Access funder mandates (e.g. European Commission).

This package is in early development and I am happy for contributors who wish to help me finalizing the wrapper.

## Installation from GitHub


```r
devtools::install_github("njahn82/ropenaire")
```

Load `ropenaire`


```r
library(ropenaire)
```

## Usage 

### Search for EC-funded projects by participant institutions

by acronym


```r
roa_projects(org = "UGOE")
#> Source: local data frame [75 x 7]
#> 
#>    grantID              acronym
#> 1   332136               HYDRON
#> 2   340528   CELLMECHANOCONTROL
#> 3   627266        ALGAEOILSYNTH
#> 4   275542            MUSTERMAN
#> 5   279347 WAVELENGTH STANDARDS
#> 6   258713               ANTHOS
#> 7   234866     EXOPLANET SEARCH
#> 8   307535             CATCHFUN
#> 9   302203           LIPIDQUEST
#> 10  612587  PLANT DNA TOLERANCE
#> ..     ...                  ...
#> Variables not shown: title (chr), startdate (chr), enddate (chr),
#>   callidentifier (chr), ecsc39 (chr)
```
 
### Search for FP7 grant-supported publications


```r
my_pubs <- roa_pubs(fp7 = "283595")
```

### Show how many of them are Open Access 


```r
table(my_pubs$Access)
#> 
#>       "OPEN" "RESTRICTED" 
#>           61            9
```

## Get all the FP7-supported publications from projects an institution participates in


```r
ugoe <- roa_projects(org = "UGOE")
tt <- plyr::ldply(as.character(ugoe$grantID), roa_pubs)

head(tt)
#>                                                                                                                        Title
#> 1              "A laser-lock concept to reach cm/s-precision in Doppler experiments with Fabry-Perot wavelength calibrators"
#> 2 "An independent planet search in the Kepler dataset II. An extremely low-density super-Earth mass planet around Kepler-87"
#> 3                           "Flat-relative optimal extraction. A quick and efficient algorithm for stabilised spectrographs"
#> 4                                                                          "Radial velocity signatures of Zeeman broadening"
#> 5                                                                           "Distribution of mass of holomorphic cusp forms"
#> 6                                                               "Drinfeld modules, Frobenius endomorphisms, and CM-liftings"
#>                                                                                                                                            Authors
#> 1                                                                                                       "Reiners, A. Banyal, R. K. Ulbrich, R. G."
#> 2                                                                            "Dreizler, Stefan Zechmeister, Mathias Husser, Tim-oliver Ofir, Aviv"
#> 3                                                                                                  "Reiners, A. Anglada-escudé, G. Zechmeister, M."
#> 4 "Jeffers, Sandra V. Morin, Julien Kochukhov, Oleg Reiners, Ansgar Piskunov, Nikolai Anglada-escude, Guillem Shulyak, Denis Zechmeister, Mathias"
#> 5                                                                                                 "Khan, Rizwanur Blomer, Valentin Young, Matthew"
#> 6                                                                                                        "Cojocaru, Alina Carmen Papikian, Mihran"
#>   Publication.Year                           DOI
#> 1     "2014-08-26"                              
#> 2     "2014-01-01" "10.1051/0004-6361/201220935"
#> 3     "2013-11-20" "10.1051/0004-6361/201322746"
#> 4     "2013-01-01" "10.1051/0004-6361/201220437"
#> 5     "2012-03-12"    "10.1215/00127094-2380967"
#> 6     "2013-07-23"                              
#>                               Permanent.identifier Publication.type
#> 1                 "http://arxiv.org/abs/1408.6111"        "Article"
#> 2                 "http://arxiv.org/abs/1310.2064"        "Article"
#> 3  "http://dx.doi.org/10.1051/0004-6361/201322746"        "Article"
#> 4                 "http://arxiv.org/abs/1301.2951"        "Article"
#> 5 "http://projecteuclid.org/euclid.dmj/1383760700"        "Article"
#> 6                 "http://arxiv.org/abs/1307.6162"        "Article"
#>                                         Journal
#> 1                                            ""
#> 2                                            ""
#> 3                                            ""
#> 4                                            ""
#> 5 "Duke Math. J. 162, no. 14 (2013), 2609-2644"
#> 6                                            ""
#>         Project.Name..GA.Number. Access
#> 1 "WAVELENGTH STANDARDS(279347)" "OPEN"
#> 2 "WAVELENGTH STANDARDS(279347)" "OPEN"
#> 3 "WAVELENGTH STANDARDS(279347)" "OPEN"
#> 4 "WAVELENGTH STANDARDS(279347)" "OPEN"
#> 5               "ANTHOS(258713)" "OPEN"
#> 6               "ANTHOS(258713)" "OPEN"

table(tt$Access)
#> 
#>     "CLOSED"       "OPEN" "RESTRICTED" 
#>          416          918           38
```

## Meta

* Please [report any issues or bugs](https://github.com/njahn82/ropenaire/issues).
* License: MIT


