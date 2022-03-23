library(sf)
## Linking to GEOS 3.9.0, GDAL 3.2.1, PROJ 7.2.1
zone <- st_read("data/vote.gpkg", "zone")
## Reading layer `zone' from data source 
##   `D:\sauveGIT\03_coursDashboard\data\vote.gpkg' using driver `GPKG'
## Simple feature collection with 32 features and 5 fields
## Geometry type: MULTIPOLYGON
## Dimension:     XY
## Bounding box:  xmin: 661088.1 ymin: 6865338 xmax: 663354.7 ymax: 6869043
## Projected CRS: RGF93 / Lambert-93
str(zone)
## Classes 'sf' and 'data.frame':   32 obs. of  6 variables:
##  $ Layer     : chr  "_Bureau 32" "_Bureau 24" "_Bureau 15" "_Bureau 14" ...
##  $ bureauNo_1: chr  NA "ECOLE ELEMENTAIRE OLYMPE DE GOUGES" "SALLE MAURICE PETITJEAN" "ECOLE MATERNELLE LEO LAGRANGE" ...
##  $ aire      : int  129558 260846 253109 229099 104115 230670 54899 91995 70288 140443 ...
##  $ numBureau : int  32 24 15 14 12 30 5 9 28 26 ...
##  $ txVotants : int  NA 50 41 53 55 54 46 50 66 52 ...
##  $ geom      :sfc_MULTIPOLYGON of length 32; first list element: List of 1
##   ..$ :List of 1
##   .. ..$ : num [1:21, 1:2] 662713 662894 662926 663008 662925 ...
##   ..- attr(*, "class")= chr [1:3] "XY" "MULTIPOLYGON" "sfg"
##  - attr(*, "sf_column")= chr "geom"
##  - attr(*, "agr")= Factor w/ 3 levels "constant","aggregate",..: NA NA NA NA NA
##   ..- attr(*, "names")= chr [1:5] "Layer" "bureauNo_1" "aire" "numBureau" 
zone$numBureau
##  [1] 32 24 15 14 12 30  5  9 28 26 27 22 21 25  7 23  1 19  3  2 18 29  8 17 13
## [26] 20 10  4  6 31 11 16
zone [zone$numBureau == 1,]
## Simple feature collection with 1 feature and 5 fields
## Geometry type: MULTIPOLYGON
## Dimension:     XY
## Bounding box:  xmin: 661781.8 ymin: 6866550 xmax: 662062.4 ymax: 6867135
## Projected CRS: RGF93 / Lambert-93
##         Layer                       bureauNo_1  aire numBureau txVotants
## 17 _Bureau 01 HOTEL DE VILLE - SALLE DES FETES 98177         1        36
##                              geom
## 17 MULTIPOLYGON (((661895.1 68...
zone [1,2]
## Simple feature collection with 1 feature and 1 field
## Geometry type: MULTIPOLYGON
## Dimension:     XY
## Bounding box:  xmin: 662546.6 ymin: 6866000 xmax: 663008.4 ymax: 6866554
## Projected CRS: RGF93 / Lambert-93
##   bureauNo_1                           geom
## 1       <NA> MULTIPOLYGON (((662713.3 68
plot(zone$geom)
# première solution
fusion <- st_union(zone)
str(zone)
## Classes 'sf' and 'data.frame':   32 obs. of  6 variables:
##  $ Layer     : chr  "_Bureau 32" "_Bureau 24" "_Bureau 15" "_Bureau 14" ...
##  $ bureauNo_1: chr  NA "ECOLE ELEMENTAIRE OLYMPE DE GOUGES" "SALLE MAURICE PETITJEAN" "ECOLE MATERNELLE LEO LAGRANGE" ...
##  $ aire      : int  129558 260846 253109 229099 104115 230670 54899 91995 70288 140443 ...
##  $ numBureau : int  32 24 15 14 12 30 5 9 28 26 ...
##  $ txVotants : int  NA 50 41 53 55 54 46 50 66 52 ...
##  $ geom      :sfc_MULTIPOLYGON of length 32; first list element: List of 1
##   ..$ :List of 1
##   .. ..$ : num [1:21, 1:2] 662713 662894 662926 663008 662925 ...
##   ..- attr(*, "class")= chr [1:3] "XY" "MULTIPOLYGON" "sfg"
##  - attr(*, "sf_column")= chr "geom"
##  - attr(*, "agr")= Factor w/ 3 levels "constant","aggregate",..: NA NA NA NA NA
##   ..- attr(*, "names")= chr [1:5] "Layer" "bureauNo_1" "aire" "numBureau"
plot(zone$geom)
# deuxième solution
enveloppe <- st_convex_hull(fusion)
plot(enveloppe)
# troisième solution
tampon <- st_buffer(zone, 50)
plot(tampon$geom)
fusion <- st_union(tampon)
plot(fusion)
simplifier <- st_simplify(fusion,90, preserveTopology = F)
plot(simplifier)
# carte avec commande rbase
plot(zone$geom, col = terrain.colors (31),
     border = NA,
     main = "31 bureaux de vote de Bondy")
# carte avec mapsf
library(mapsf)
mf_map(zone, type = "choro", border = NA,var = "aire")
# éliminer les bureaux 31 et 32
zone <- zone [zone$numBureau %in% seq(1,30),]
summary(zone)
##     Layer            bureauNo_1             aire          numBureau    
##  Length:30          Length:30          Min.   : 54899   Min.   : 1.00  
##  Class :character   Class :character   1st Qu.:102057   1st Qu.: 8.25  
##  Mode  :character   Mode  :character   Median :146437   Median :15.50  
##                                        Mean   :163750   Mean   :15.50  
##                                        3rd Qu.:223232   3rd Qu.:22.75  
##                                        Max.   :367989   Max.   :30.00  
##    txVotants                geom   
##  Min.   :35.00   MULTIPOLYGON :30  
##  1st Qu.:42.25   epsg:2154    : 0  
##  Median :50.00   +proj=lcc ...: 0  
##  Mean   :50.30                     
##  3rd Qu.:55.00                     
##  Max.   :69.00
mf_map(zone, type = "choro", pal = "Burg",
       border = NA, var = "txVotants")
Data <- read.csv("data/bondyElection.csv", fileEncoding = "UTF-8", dec = ",")
zone$Layer
##  [1] "_Bureau 24" "_Bureau 15" "_Bureau 14" "_Bureau 12" "_Bureau 30"
##  [6] "_Bureau 05" "_Bureau 09" "_Bureau 28" "_Bureau 26" "_Bureau 27"
## [11] "_Bureau 22" "_Bureau 21" "_Bureau 25" "_Bureau 07" "_Bureau 23"
## [16] "_Bureau 01" "_Bureau 19" "_Bureau 03" "_Bureau 02" "_Bureau 18"
## [21] "_Bureau 29" "_Bureau 08" "_Bureau 17" "_Bureau 13" "_Bureau 20"
## [26] "_Bureau 10" "_Bureau 04" "_Bureau 06" "_Bureau 11" "_Bureau 16"
data$Bureau.de.vote
##  [1] "BV1"        "BV2"        "BV3"        "BV4"        "BV5"       
##  [6] "BV6"        "BV7"        "BV8"        "BV9"        "BV10"      
## [11] "BV11"       "BV12"       "BV13"       "BV14"       "BV15"      
## [16] "BV16"       "BV17"       "BV18"       "BV19"       "BV20"      
## [21] "BV21"       "BV22"       "BV23"       "BV24"       "BV25"      
## [26] "BV26"       "BV27"       "BV28"       "BV29"       "BV30"      
## [31] "BV31"       "BV32"       "TOTAL"      "Total en %"
data <- data [data$cle[c(1:32)],]
zone$cle <- substring (zone$Layer,9,11)
data$cle <- substring(data$Bureau.de.vote, 3,5 )
data$cle <- as.integer(data$cle)
zone$cle <- as.integer(zone$cle)
length(zone$cle) == length(data$cle)
## [1] FALSE
jointure <- merge(zone, data, by = "cle")
st_write(jointure, "data/vote.gpkg", "jointure", delete_layer = T)
## Deleting layer `jointure' using driver `GPKG'
## Writing layer `jointure' to data source `data/vote.gpkg' using driver `GPKG'
## Writing 0 features with 18 fields and geometry type Unknown (any)
names(jointure)
##  [1] "cle"                                                                                       
##  [2] "Layer"                                                                                     
##  [3] "bureauNo_1"                                                                                
##  [4] "aire"                                                                                      
##  [5] "numBureau"                                                                                 
##  [6] "txVotants"                                                                                 
##  [7] "Bureau.de.vote"                                                                            
##  [8] "Nb.d.électeurs.inscrits"                                                                   
##  [9] "Nb.de.votants"                                                                             
## [10] "Taux.de.participation...."                                                                 
## [11] "Nb.votes.nuls"                                                                             
## [12] "Nb.votes.blancs"                                                                           
## [13] "Suffrages.exprimés"                                                                        
## [14] "Résultats.liste.1...Liste.de.la.gauche.unie.pour.Bondy....Sylvine.THOMASSIN."              
## [15] "Résultats.liste.2....Pour.Bondy.allons.plus.loin....Stephen.HERVE"                         
## [16] "Résultats.liste.3....Bondy.pour.une.gauche.sociale.insoumise.et.populaire....Jamal.AMMOURI"
## [17] "Résultats.liste.4....Bondy.autrement...Vincent.DUGUET"                                     
## [18] "Résultats.liste.5....Bondy.c.est.vous...Sylvie.BADOUX"                                     
## [19] "geometry"
