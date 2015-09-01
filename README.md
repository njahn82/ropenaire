

# ropenaire

[![Build Status](https://travis-ci.org/njahn82/ropenaire.svg?branch=master)](https://travis-ci.org/njahn82/ropenaire)
[![Build status](https://ci.appveyor.com/api/projects/status/github/njahn82/ropenaire?branch=master)](https://ci.appveyor.com/project/njahn82/ropenaire)
[![codecov.io](http://codecov.io/github/njahn82/ropenaire/coverage.svg?branch=master)](http://codecov.io/github/njahn82/ropenaire?branch=master)

## About

`ropenaire` gives access to the [OpenAIRE RESTful API](http://api.openaire.eu/) with R. [OpenAIRE](https://www.openaire.eu/) is an open science initiative, which supports the Open Access policy of the European Commission. So far, OpenAIRE facilitates access to over 11 million publications from various sources such as 5,800 open access repositories.

The API is intended for metadata discovery and exploration only. The number of total return results returned by one query is limited to 10,000.

For bulk access, please use the [OpenAIRE OAI-PMH endpoint](http://api.openaire.eu/#cha_oai_pmh), which can be queried by [Scott's OAI-PMH client](https://github.com/sckott/oai) or [OAIHarvester](https://cran.r-project.org/web/packages/OAIHarvester/index.html).

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

Search EC-funded projects by participant institutions, e.g. Göttingen University by acronym `GOE`


```r
roa_projects(org = "UGOE") %>%
  head()
#>   grantID              acronym
#> 1  258713               ANTHOS
#> 2  275542            MUSTERMAN
#> 3  340528   CELLMECHANOCONTROL
#> 4  332136               HYDRON
#> 5  627266        ALGAEOILSYNTH
#> 6  279347 WAVELENGTH STANDARDS
#>                                                                                                                title
#> 1                                                                    Analytic Number Theory: Higher Order Structures
#> 2                                                               Music, Terror and Manipulation under the Greek Junta
#> 3                                                    The physical basis of cellular mechanochemical control circuits
#> 4                                                                  Near Hydrodynamic Type Systems in 2 +1 Dimensions
#> 5 Towards improving biofuel production - Oil synthesis and accumulation pathways in promising oleaginous microalgae.
#> 6                                        Development of new wavelength standards for the searchfor habitable planets
#>    startdate    enddate        callidentifier ecsc39
#> 1 2010-10-01 2015-09-30 ERC-2010-StG_20091028  false
#> 2 2011-06-15 2014-06-20   FP7-PEOPLE-2010-IEF  false
#> 3 2014-06-01 2019-05-31          ERC-2013-ADG  false
#> 4 2013-06-01 2015-05-31   FP7-PEOPLE-2012-IEF  false
#> 5 2014-05-01 2017-04-30   FP7-PEOPLE-2013-IOF  false
#> 6 2012-01-01 2016-12-31 ERC-2011-StG_20101014  false
```
 
### Publications

Publications from the 2nd-Generation Open Access Infrastructure for Research in Europe project, which has the grant id 283595.


```r
roa_pubs(fp7 = "283595") %>%
  head() 
#>                                                                                                                                        Title
#> 1                                                                          ZENODO: A New Innovative Service for Sharing All Research Outputs
#> 2 Open Access to Scientific Results and Data. European Union's Efforts through Openaire and Openaireplus FP7 Projects: Cypriot Participation
#> 3                                                                                              OpenAIRE's perspective and involvement in RDA
#> 4                                                                   Sfide tecnologiche per l'accesso aperto a tutti i prodotti della ricerca
#> 5                                                                                                      OpenAIREplus project Executive Report
#> 6                                   Zeleno, što volim zeleno - samoarhiviranje znanstvenih članaka kao način ostvarivanja otvorenog pristupa
#>                                                 Authors Publication.Year
#> 1                                    Nielsen, Lars Holm       2014-06-20
#> 2 Tsimpoglou, F. Ch Koukounidou, V. V. Prokopiou, L. A.       2012-10-29
#> 3                                   Castelli, Donatella       2012-01-01
#> 4                                         Manghi, Paolo       2014-01-01
#> 5         Rettberg, Najla Manola, Natalia Manghi, Paolo       2015-02-17
#> 6                                          Macan, Bojan                 
#>                         DOI
#> 1      10.5281/zenodo.11082
#> 2 10.1260/2047-4970.1.0.113
#> 3                          
#> 4                          
#> 5      10.5281/zenodo.15464
#> 6                          
#>                                                            Permanent.identifier
#> 1                                                http://zenodo.org/record/11082
#> 2                                              http://hdl.handle.net/10797/6080
#> 3 http://puma.isti.cnr.it/dfdownloadnew.php?ident=cnr.isti/cnr.isti/2012-A3-015
#> 4 http://puma.isti.cnr.it/dfdownloadnew.php?ident=cnr.isti/cnr.isti/2014-B0-002
#> 5                                                http://zenodo.org/record/15464
#> 6                                                     http://fulir.irb.hr/1367/
#>    Publication.type
#> 1           Article
#> 2 Conference object
#> 3 Conference object
#> 4           Article
#> 5           Article
#> 6           Unknown
#>                                                                             Journal
#> 1                                                                                  
#> 2                                                                                  
#> 3               In: OpenAIRE Conference (Goettingen, Germany, 21-22 November 2012).
#> 4 In: Biliotime, vol. 17 (3) article n. 4. Associazione Italiana Biblioteche, 2014.
#> 5                                                                                  
#> 6                                                                                  
#>   Project.Name..GA.Number. Access
#> 1     OPENAIREPLUS(283595)   OPEN
#> 2     OPENAIREPLUS(283595)   OPEN
#> 3     OPENAIREPLUS(283595)   OPEN
#> 4     OPENAIREPLUS(283595)   OPEN
#> 5     OPENAIREPLUS(283595)   OPEN
#> 6     OPENAIREPLUS(283595)   OPEN
```

### Datasets

Search for FP7 grant-supported datasets


```r
roa_datasets(fp7 = "247153") %>%
  head()
#>                                                                                                                                                Title
#> 1                                                      Turnover of microbial lipids in the deep biosphere and growth of benthic archaeal populations
#> 2                                                     Carbon isotope fractionation by the marine ammonia-oxidizing archaeon Nitrosopumilus maritimus
#> 3       Thermococcus kodakarensis modulates its polar membrane lipids and elemental composition according to growth stage and phosphate availability
#> 4                                                      Isoprenoid glycerol dialkanol diethers: a series of novel archaeal lipids in marine sediments
#> 5 Extending the known range of glycerol ether lipids in the environment: structural assignments based on tandem mass spectral fragmentation patterns
#> 6      Mono- and dihydroxyl glycerol dibiphytanyl glycerol tetraethers in marine sediments: Identification of both core and intact polar lipid forms
#>                                                                                              Authors
#> 1                 Xie, Sitan Ferdelman, Timothy G. Lipp, Julius S. Wegener, Gunter Hinrichs, Kai-uwe
#> 2                                                   Hinrichs, Kai-uwe Könneke, Martin Lipp, Julius S.
#> 3                                                                         EmmaJ.Gagen TravisB.Meador
#> 4                  Lipp, Julius S. Schröder, Jan M. Summons, Roger E. Hinrichs, Kai-uwe Liu, Xiao-lei
#> 5                                                  Hinrichs, Kai-uwe Liu, Xiao-lei Summons, Roger E.
#> 6 Simpson, Jeffrey H. Summons, Roger E. Liu, Xiao-lei Hinrichs, Kai-uwe Lipp, Julius S. Lin, Yu-shih
#>   Publication.Year                                                   DOI
#> 1       2013-01-01                               10.1073/pnas.1218569110
#> 2       2012-05-03                      10.1016/j.orggeochem.2012.04.007
#> 3       2014-01-01 10.3389/fmicb.2014.00010/full10.3389/fmicb.2014.00010
#> 4       2011-11-17                      10.1016/j.orggeochem.2011.11.002
#> 5       2012-09-04                                      10.1002/rcm.6355
#> 6       2012-04-28                             10.1016/j.gca.2012.04.053
#>                       Permanent.identifier Publication.type
#> 1 http://europepmc.org/articles/PMC3625344          Article
#> 2           http://zenodo.org/record/18408          Article
#> 3 http://europepmc.org/articles/PMC3906577          Article
#> 4           http://zenodo.org/record/18313          Article
#> 5           http://zenodo.org/record/18136          Article
#> 6           http://zenodo.org/record/18312          Article
#>                                                                                 Journal
#> 1                                                                                      
#> 2                                             Organic Geochemistry: 48 (2012) pp. 21-24
#> 3                                               Frontiers in Microbiology, Vol 5 (2014)
#> 4                                             Organic Geochemistry: 43 (2011) pp. 50-55
#> 5                    Rapid Communications in Mass Spectrometry: 26 (2012) pp. 2295-2302
#> 6 Geochimica et Cosmochimica Acta: 89 (2012) pp. 102-115Geochimica et Cosmochimica Acta
#>   Project.Name..GA.Number. Access
#> 1         DARCLIFE(247153)   OPEN
#> 2         DARCLIFE(247153)   OPEN
#> 3         DARCLIFE(247153)   OPEN
#> 4         DARCLIFE(247153)   OPEN
#> 5         DARCLIFE(247153)   OPEN
#> 6         DARCLIFE(247153)   OPEN
```

Search by title keywords


```r
roa_datasets(title = "methane") %>%
  head()
#>                                                                                               Title
#> 1                                                                                 Methane uncovered
#> 2                                                                                Geological Methane
#> 3                                                                                       Dam methane
#> 4                                                                                  Breaking methane
#> 5 Bio-methane & Bio-hydrogen. Status and perspectives of biological methane and hydrogen production
#> 6                            Methane (CH<sub>4</sub>) flux data for Moidach More. Years 1997 - 1998
#>                                                      Authors
#> 1 Etiope, G. Istituto Nazionale Di Geofisica E. Vulcanologia
#> 2 Etiope, G. Istituto Nazionale Di Geofisica E. Vulcanologia
#> 3                                      Isgtw, Editorial Team
#> 4                                         Rosenzweig, Amy C.
#> 5                          Wijffels, R. H. Janssen, M. G. J.
#> 6                                             Gauci, Vincent
#>   Publication.Year                 DOI
#> 1       2012-06-01    10.1038/ngeo1483
#> 2       2010-01-01                    
#> 3                                     
#> 4       2015-01-21 10.1038/nature14199
#> 5       2003-01-01                    
#> 6       2008-01-01                    
#>                                                                                                   Permanent.identifier
#> 1                                                                                      http://hdl.handle.net/2122/8629
#> 2                                                                                      http://hdl.handle.net/2122/6492
#> 3 http://belief-dl.research-infrastructures.eu/UIMain.jsp?handle=isgtw.org/iSGTW_2011_RGFtbWV0aGFuZQ==&view=&version=1
#> 4                                                                             http://europepmc.org/articles/PMC4336217
#> 5                                                                                           http://edepot.wur.nl/87576
#> 6                                                                                         http://oro.open.ac.uk/25665/
#>                  Publication.type Journal Project.Name..GA.Number.
#> 1                         Article                                 
#> 2 Part of book or chapter of book                                 
#> 3                         Unknown                                 
#> 4                         Article                                 
#> 5 Part of book or chapter of book                                 
#> 6                         Unknown                                 
#>       Access
#> 1 RESTRICTED
#> 2 RESTRICTED
#> 3       OPEN
#> 4       OPEN
#> 5       OPEN
#> 6       OPEN
```

### Get all the FP7-supported publications from projects an institution participates in


```r
ugoe <- roa_projects(org = "UGOE")
plyr::ldply(as.character(ugoe$grantID), roa_pubs) %>%
  head()
#>                                                                    Title
#> 1                         DISTRIBUTION OF MASS OF HOLOMORPHIC CUSP FORMS
#> 2                         On the Ramanujan conjecture over number fields
#> 3         Exponential sums with coefficients of certain Dirichlet series
#> 4                                 Automorphisms with exotic orbit growth
#> 5              Subconvexity for sup-norms of automorphic forms on PGL(n)
#> 6 Quadratic congruences on average and rational points on cubic surfaces
#>                                                     Authors
#> 1            Young, Matthew Khan, Rizwanur Blomer, Valentin
#> 2                         Brumley, Farrell Blomer, Valentin
#> 3                                            Baier, Stephan
#> 4 Jaidee, Sawian Stevens, Shaun Ward, Thomas Baier, Stephan
#> 5                               Maga, Péter Blomer, Valentin
#> 6                          Baier, Stephan Derenthal, Ulrich
#>   Publication.Year                          DOI
#> 1       2013-01-01     10.1215/00127094-2380967
#> 2       2011-01-01 10.4007/annals.2011.174.1.18
#> 3       2012-01-01    10.1007/s00605-011-0372-7
#> 4       2013-01-01            10.4064/aa158-2-5
#> 5       2014-05-26                             
#> 6       2012-05-02                             
#>                             Permanent.identifier Publication.type
#> 1 http://projecteuclid.org/euclid.dmj/1383760700          Article
#> 2                 http://arxiv.org/abs/1003.0559          Article
#> 3                 http://arxiv.org/abs/1108.2715          Article
#> 4                 http://arxiv.org/abs/1201.4503          Article
#> 5                 http://arxiv.org/abs/1405.6691          Article
#> 6                 http://arxiv.org/abs/1205.0373          Article
#>                                                               Journal
#> 1                         Duke Math. J. 162, no. 14 (2013), 2609-2644
#> 2                                                                    
#> 3                                                                    
#> 4 Acta arithmetica, 2013, Vol.158, pp.173-197 [Peer Reviewed Journal]
#> 5                                                                    
#> 6                                                                    
#>   Project.Name..GA.Number. Access
#> 1           ANTHOS(258713)   OPEN
#> 2           ANTHOS(258713)   OPEN
#> 3           ANTHOS(258713)   OPEN
#> 4           ANTHOS(258713)   OPEN
#> 5           ANTHOS(258713)   OPEN
#> 6           ANTHOS(258713)   OPEN
```

## Meta

* Please [report any issues or bugs](https://github.com/njahn82/ropenaire/issues).
* License: MIT ©Najko Jahn


