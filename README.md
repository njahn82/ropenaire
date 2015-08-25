

# ropenaire

[![Build Status](https://travis-ci.org/njahn82/ropenaire.svg?branch=master)](https://travis-ci.org/njahn82/ropenaire)
[![Build status](https://ci.appveyor.com/api/projects/status/github/njahn82/ropenaire?branch=master)](https://ci.appveyor.com/project/njahn82/ropenaire)
[![codecov.io](http://codecov.io/github/njahn82/ropenaire/coverage.svg?branch=master)](http://codecov.io/github/njahn82/ropenaire?branch=master)

## About

`ropensci` gives access to the [OpenAIRE API](http://api.openaire.eu/) with R. [OpenAIRE](https://www.openaire.eu/) OpenAIRE is an initiative which aims to support the Open Access policy of the European Commission. So far, OpenAIRE facilitates access to over 11 million publications from various sources such as 5,800 open access repositories.

The API is intended for metadata discovery and exploration only. The number of total return results returned by one query is limited to 10,000.

For bulk access, please use the [OpenAIRE OAI-PMH endpoint](http://api.openaire.eu/#cha_oai_pmh), which can be queried by [Scott's OAI-PMH client](https://github.com/sckott/oai).

## Installation from GitHub


```r
devtools::install_github("njahn82/ropenaire")
```

Load `ropenaire`


```r
library(ropenaire)
```

## Usage 

### Projects

Search EC-funded projects by participant institutions

Göttingen University by acronym `GOE`


```r
roa_projects(org = "UGOE")
#> Source: local data frame [76 x 7]
#> 
#>    grantID              acronym
#> 1   258713               ANTHOS
#> 2   275542            MUSTERMAN
#> 3   340528   CELLMECHANOCONTROL
#> 4   332136               HYDRON
#> 5   627266        ALGAEOILSYNTH
#> 6   279347 WAVELENGTH STANDARDS
#> 7   234866     EXOPLANET SEARCH
#> 8   307535             CATCHFUN
#> 9   302203           LIPIDQUEST
#> 10  277963  FRUSTRATED HYDROGEN
#> ..     ...                  ...
#> Variables not shown: title (chr), startdate (chr), enddate (chr),
#>   callidentifier (chr), ecsc39 (chr)
```
 
### Publications

Publications from the 2nd-Generation Open Access Infrastructure for Research in Europe project, which has the grant id 283595.


```r
my_pubs <- roa_pubs(fp7 = "283595")
```

Show how many of them are Open Access 


```r
table(my_pubs$Access)
#> 
#>       OPEN RESTRICTED 
#>         61          9
```

### Datasets

Search for FP7 grant-supported datasets


```r
roa_datasets(fp7 = "247153")
#> Source: local data frame [45 x 9]
#> 
#>                                                                          Title
#> 1  Concentration and isotopic composition of methane in sediment core GeoB1730
#> 2                        Concentration of methane in sediment core GeoB17302-3
#> 3                        Concentration of methane in sediment core GeoB17310-1
#> 4                                        Porosity in sediment core GeoB17309-1
#> 5             Ph and Eh measured on bulk sediment of sediment core GeoB15104-3
#> 6  CTD-profiles at 11 sites recorded during RV Poseidon cruise POS450, Western
#> 7  Concentration and isotopic composition of methane in sediment core GeoB1730
#> 8                                        Porosity in sediment core GeoB17302-4
#> 9         Ph and Eh measurements on bulk sediment of sediment core GeoB15105-1
#> 10                                       Porosity in sediment core GeoB17310-1
#> ..                                                                         ...
#> Variables not shown: Authors (chr), Publication.Year (chr), DOI (chr),
#>   Permanent.identifier (chr), Publication.type (chr), Journal (chr),
#>   Project.Name..GA.Number. (chr), Access (chr)
```

Search by title keywords


```r
roa_datasets(title = "methane") 
#> Source: local data frame [134 x 9]
#> 
#>                                                          Title
#> 1     Methane measurements during POLARSTERN cruise ARK-XXII/2
#> 2  Methane measured on ice core TALDICE on AICC2012 chronology
#> 3        Concentration of methane in sediment core GeoB17302-3
#> 4               Methane and ethane of sediment core PS69/702-6
#> 5        Concentration of methane in sediment core GeoB17310-1
#> 6               Methane and ethane of sediment core PS69/709-3
#> 7   Methane measured on ice core Vostok on AICC2012 chronology
#> 8       Methane oxidation rates of sediment core MEDECO2-MTB-4
#> 9               Methane and ethane of sediment core PS69/706-4
#> 10       Concentration of methane in sediment core GeoB17302-5
#> ..                                                         ...
#> Variables not shown: Authors (chr), Publication.Year (chr), DOI (chr),
#>   Permanent.identifier (chr), Publication.type (chr), Journal (chr),
#>   Project.Name..GA.Number. (chr), Access (chr)
```

### Get all the FP7-supported publications from projects an institution participates in


```r
ugoe <- roa_projects(org = "UGOE")
tt <- plyr::ldply(as.character(ugoe$grantID), roa_pubs)

head(tt)
#>                                                            Title
#> 1                 DISTRIBUTION OF MASS OF HOLOMORPHIC CUSP FORMS
#> 2                 On the Ramanujan conjecture over number fields
#> 3 Exponential sums with coefficients of certain Dirichlet series
#> 4                         Automorphisms with exotic orbit growth
#> 5           The average of $L^4$-norms of holomorphic cusp forms
#> 6     Drinfeld modules, Frobenius endomorphisms, and CM-liftings
#>                                                     Authors
#> 1            Young, Matthew Khan, Rizwanur Blomer, Valentin
#> 2                         Brumley, Farrell Blomer, Valentin
#> 3                                            Baier, Stephan
#> 4 Jaidee, Sawian Stevens, Shaun Ward, Thomas Baier, Stephan
#> 5                                            Khan, Rizwanur
#> 6                   Cojocaru, Alina Carmen Papikian, Mihran
#>   Publication.Year                          DOI
#> 1       2013-01-01     10.1215/00127094-2380967
#> 2       2011-01-01 10.4007/annals.2011.174.1.18
#> 3       2012-01-01    10.1007/s00605-011-0372-7
#> 4       2013-01-01            10.4064/aa158-2-5
#> 5       2012-10-02                             
#> 6       2013-07-23                             
#>                             Permanent.identifier Publication.type
#> 1 http://projecteuclid.org/euclid.dmj/1383760700          Article
#> 2                 http://arxiv.org/abs/1003.0559          Article
#> 3                 http://arxiv.org/abs/1108.2715          Article
#> 4                 http://arxiv.org/abs/1201.4503          Article
#> 5                 http://arxiv.org/abs/1210.0740          Article
#> 6                 http://arxiv.org/abs/1307.6162          Article
#>                                                               Journal
#> 1                         Duke Math. J. 162, no. 14 (2013), 2609-2644
#> 2                                                                    
#> 3                                                                    
#> 4 Acta arithmetica, 2013, Vol.158, pp.173-197 [Peer Reviewed Journal]
#> 5                                                                    
#> 6                                                                    
#>   Project.Name..GA.Number. Access   tt
#> 1           ANTHOS(258713)   OPEN <NA>
#> 2           ANTHOS(258713)   OPEN <NA>
#> 3           ANTHOS(258713)   OPEN <NA>
#> 4           ANTHOS(258713)   OPEN <NA>
#> 5           ANTHOS(258713)   OPEN <NA>
#> 6           ANTHOS(258713)   OPEN <NA>

table(tt$Access)
#> 
#>     CLOSED       OPEN RESTRICTED 
#>        497        930         40
```

## Meta

* Please [report any issues or bugs](https://github.com/njahn82/ropenaire/issues).
* License: MIT


