

# ropenaire

[![Build Status](https://travis-ci.org/sckott/ropenaire.svg?branch=master)](https://travis-ci.org/sckott/ropenaire)
[![Build status](https://ci.appveyor.com/api/projects/status/github/sckott/ropenaire?branch=master)](https://ci.appveyor.com/project/sckott/ropenaire)
[![codecov.io](http://codecov.io/github/sckott/ropenaire/coverage.svg?branch=master)](http://codecov.io/github/sckott/ropenaire?branch=master)

## About

**ropenaire** gives access to the [OpenAIRE RESTful API](http://api.openaire.eu/) with R. [OpenAIRE](https://www.openaire.eu/) is an open science initiative, which supports the Open Access policy of the European Commission. OpenAIRE aggregates over 12 mio publication and datasets from over 5,800 OA repositories and journals.

The API is intended for metadata discovery and exploration only. Note that the number of results returned by one query is limited to 10,000.

For bulk access, please use the [OpenAIRE OAI-PMH endpoint](http://api.openaire.eu/#cha_oai_pmh), which can be queried by [Scott's OAI-PMH client](https://github.com/sckott/oai) or [OAIHarvester](https://cran.r-project.org/web/packages/OAIHarvester/index.html).

## Installation from GitHub


```r
devtools::install_github("sckott/ropenaire")
```

Load `ropenaire`


```r
library(ropenaire)
```

## Usage 

### Projects

Search for EC-funded projects by participating institution. For example, Göttingen University has the acronym `GOE`


```r
roa_projects(org = "UGOE", size = 10)
#> # A tibble: 10 x 8
#>    grantID acronym  title          startdate enddate callidentifier ecsc39
#>    <chr>   <chr>    <chr>          <chr>     <chr>   <chr>          <chr> 
#>  1 648329  GRANT    Groups, Repre… 2015-09-… 2020-0… ERC-2014-CoG   ""    
#>  2 693457  Private… Private Pieti… 2016-10-… 2021-0… ERC-2015-AdG   ""    
#>  3 707072  MARDIV   'Marriage and… 2016-09-… 2018-0… H2020-MSCA-IF… ""    
#>  4 258713  ANTHOS   Analytic Numb… 2010-10-… 2015-0… ERC-2010-StG_… false 
#>  5 771295  SULFOSOL Sulfur-based … 2018-05-… 2023-0… ERC-2017-COG   ""    
#>  6 646747  N2FEED   N2 as Chemica… 2015-06-… 2020-0… ERC-2014-CoG   ""    
#>  7 750249  AGG-RES… Let restore o… 2017-06-… 2019-0… H2020-MSCA-IF… ""    
#>  8 639119  ULEED    Observing str… 2015-03-… 2020-0… ERC-2014-STG   ""    
#>  9 752533  UCHIRAL  Ultrafast opt… 2017-07-… 2019-0… H2020-MSCA-IF… ""    
#> 10 275542  MUSTERM… Music, Terror… 2011-06-… 2014-0… FP7-PEOPLE-20… false 
#> # ... with 1 more variable: funding_level_0 <chr>
```

Search projects by call id


```r
roa_projects(call_id = "FP7-PEOPLE-2013-IOF", size = 10)
#> # A tibble: 10 x 8
#>    grantID acronym  title          startdate enddate callidentifier ecsc39
#>    <chr>   <chr>    <chr>          <chr>     <chr>   <chr>          <chr> 
#>  1 623673  REPRODU… Historicizing… 2015-05-… 2018-0… FP7-PEOPLE-20… false 
#>  2 623324  EVOLINE  Mobile elemen… 2015-02-… 2019-0… FP7-PEOPLE-20… false 
#>  3 627781  AWE      Accurate Wave… 2014-10-… 2017-0… FP7-PEOPLE-20… false 
#>  4 624968  TPAB     Toward a Phen… 2014-10-… 2017-0… FP7-PEOPLE-20… false 
#>  5 622936  SEXSEL   Investigating… 2014-07-… 2017-0… FP7-PEOPLE-20… false 
#>  6 627639  BIOHELP  Revealing the… 2014-09-… 2018-0… FP7-PEOPLE-20… false 
#>  7 628785  ISCOBRA  Global challe… 2014-07-… 2016-0… FP7-PEOPLE-20… false 
#>  8 622331  CREA.TA  Schemata Viol… 2014-09-… 2017-0… FP7-PEOPLE-20… false 
#>  9 629861  SOX      The role of S… 2015-04-… 2018-0… FP7-PEOPLE-20… false 
#> 10 622294  PREVASC… Engineering a… 2014-08-… 2017-0… FP7-PEOPLE-20… false 
#> # ... with 1 more variable: funding_level_0 <chr>
```


### Publications

Publications from the 2nd-Generation Open Access Infrastructure for Research in Europe project, which has the grant id 283595.


```r
roa_pubs(fp7 = "283595", size = 10)
#> # A tibble: 10 x 10
#>    Title  Authors  `Publication Ye… DOI   `Download From` `Publication ty…
#>    <chr>  <chr>    <date>           <chr> <chr>           <chr>           
#>  1 ZENOD… Nielsen… 2014-06-20       10.5… https://zenodo… Lecture         
#>  2 Infra… Príncip… 2014-12-19       <NA>  http://www.bad… Article         
#>  3 Open … Tsimpog… 2012-10-29       10.1… http://hdl.han… Conference obje…
#>  4 OpenA… Príncip… 2014-05-05       10.1… http://dx.doi.… Article         
#>  5 The e… Schmidt… 2013-01-01       <NA>  http://hdl.han… Conference obje…
#>  6 Sfide… Manghi,… 2014-01-01       <NA>  http://puma.is… Article         
#>  7 Zelen… Macan, … NA               <NA>  http://fulir.i… Other           
#>  8 OpenA… Manola,… 2015-02-17       10.5… https://zenodo… Report          
#>  9 OpenA… Castell… 2012-01-01       <NA>  http://puma.is… Conference obje…
#> 10 Zenod… Nielsen… 2014-10-27       10.5… https://zenodo… Lecture         
#> # ... with 4 more variables: Journal <chr>, Funder <chr>, `Project Name
#> #   (GA Number)` <chr>, Access <chr>
```

### Datasets

Search for FP7 grant-supported datasets


```r
roa_datasets(fp7 = "247153", size = 10)
#> # A tibble: 10 x 10
#>    Title   Authors `Publication Ye… DOI   `Download From` `Publication ty…
#>    <chr>   <chr>   <date>           <chr> <chr>           <chr>           
#>  1 Pore w… Matthi… 2012-01-01       doi:… http://dx.doi.… Dataset         
#>  2 Porosi… Verena… 2014-01-01       doi:… http://dx.doi.… Dataset         
#>  3 Water … Tobias… 2015-01-01       10.1… http://dx.doi.… Dataset         
#>  4 Concen… Verena… 2014-01-01       doi:… http://dx.doi.… Dataset         
#>  5 Non-is… Jan Ma… 2015-01-01       10.1… http://dx.doi.… Dataset         
#>  6 Ph and… Matthi… 2012-01-01       10.1… http://dx.doi.… Dataset         
#>  7 Concen… Verena… 2014-01-01       10.1… http://dx.doi.… Dataset         
#>  8 Concen… Verena… 2014-01-01       doi:… http://dx.doi.… Dataset         
#>  9 Concen… Verena… 2014-01-01       doi:… http://dx.doi.… Dataset         
#> 10 Concen… Verena… 2014-01-01       doi:… http://dx.doi.… Dataset         
#> # ... with 4 more variables: Journal <chr>, Funder <chr>, `Project Name
#> #   (GA Number)` <chr>, Access <chr>
```

Search by title keywords


```r
roa_datasets(title = "methane", size = 10)
#> # A tibble: 10 x 10
#>    Title  Authors  `Publication Ye… DOI   `Download From` `Publication ty…
#>    <chr>  <chr>    <date>           <chr> <chr>           <chr>           
#>  1 METHA… CHANG, … 2000-01-01       10.1… http://dx.doi.… Dataset         
#>  2 Metha… T. Ditt… 2014-01-01       10.1… http://dx.doi.… Dataset         
#>  3 anaer… jetten,… 2016-01-01       10.6… http://dx.doi.… Dataset         
#>  4 Globa… Saunois… 2016-01-01       10.3… http://dx.doi.… Dataset         
#>  5 Data … David F… 2017-01-01       10.5… http://dx.doi.… Dataset         
#>  6 Metha… Susan M… 2015-01-01       10.1… http://dx.doi.… Dataset         
#>  7 Metha… Susan M… 2017-01-01       10.1… http://dx.doi.… Dataset         
#>  8 Light… Oswald,… 2015-01-01       10.1… http://dx.doi.… Collection      
#>  9 Metha… Helge N… 2009-01-01       10.1… http://dx.doi.… Dataset         
#> 10 Metha… Miriam … 2013-01-01       doi:… http://dx.doi.… Dataset         
#> # ... with 4 more variables: Journal <chr>, Funder <chr>, `Project Name
#> #   (GA Number)` <chr>, Access <chr>
```

### Get all the FP7-supported publications from a participating institution 


```r
roa_projects(org = "UGOE", size = 10)
#> # A tibble: 10 x 8
#>    grantID acronym  title          startdate enddate callidentifier ecsc39
#>    <chr>   <chr>    <chr>          <chr>     <chr>   <chr>          <chr> 
#>  1 648329  GRANT    Groups, Repre… 2015-09-… 2020-0… ERC-2014-CoG   ""    
#>  2 693457  Private… Private Pieti… 2016-10-… 2021-0… ERC-2015-AdG   ""    
#>  3 707072  MARDIV   'Marriage and… 2016-09-… 2018-0… H2020-MSCA-IF… ""    
#>  4 258713  ANTHOS   Analytic Numb… 2010-10-… 2015-0… ERC-2010-StG_… false 
#>  5 771295  SULFOSOL Sulfur-based … 2018-05-… 2023-0… ERC-2017-COG   ""    
#>  6 646747  N2FEED   N2 as Chemica… 2015-06-… 2020-0… ERC-2014-CoG   ""    
#>  7 750249  AGG-RES… Let restore o… 2017-06-… 2019-0… H2020-MSCA-IF… ""    
#>  8 639119  ULEED    Observing str… 2015-03-… 2020-0… ERC-2014-STG   ""    
#>  9 752533  UCHIRAL  Ultrafast opt… 2017-07-… 2019-0… H2020-MSCA-IF… ""    
#> 10 275542  MUSTERM… Music, Terror… 2011-06-… 2014-0… FP7-PEOPLE-20… false 
#> # ... with 1 more variable: funding_level_0 <chr>
```

## Meta

* Please [report any issues or bugs](https://github.com/njahn82/ropenaire/issues).
* License: MIT ©Najko Jahn
