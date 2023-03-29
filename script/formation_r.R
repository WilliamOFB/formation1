library(tidyverse)
library (data.table)

#chargement des data sous le nom onde
onde <- data.table::fread(file = "raw_data/onde_france_2022.csv",encoding = "UTF-8")

#résumé des variables de 'onde'
summary(onde)

names(onde)#connaître nom des colonnes
class(onde)#classe de l'objet onde
typeof(onde)#type de stockage de l'objet
class(names(onde))#classe de l'objet names()

#renommage des colonnes onde sans < et >
nouveaux_noms<-stringr::str_replace(string = names(onde),
                                    pattern = ">",
                                    replacement = "")

nouveaux_noms<- stringr::str_replace(string = nouveaux_noms,
                                     pattern = "<",
                                     replacement = "")
nouveaux_noms

names(onde) <- nouveaux_noms

#voir les premières et dernières lignes
head(onde)
tail(onde)

#sélection de lignes (première partie) / colonnes (deuxième partie) par crochets
onde[1:8, 1:6] # 8 lignes et 6 colonnes
test <- onde[1:8, 1:6]

test <- onde[1:8, "CdSiteHydro"]
test1 <- onde[1:8, c("CdSiteHydro", "NomEntiteHydrographique")]
test <- onde[, c("CdSiteHydro", "NomEntiteHydrographique")]
test2 <- onde[c(1, 3, 6),] # c() pour créer un vecteur

#dimension du dataframe
nrow(onde) # lignes
ncol(onde) # colonnes
dim(onde) # lignes et colonnes
test3 <- dim(onde)
test3
test3[2] # sélection 2ème partie de test3
head(test1)
tail(test1)

onde$LbRsObservationNat # sélection juste de la variable
table(onde$LbRsObservationNat) # compte de chaque modalité

# Examen d'une colonne
mean(onde$CoordXSiteHydro) # moyenne d'une colonne
sd(onde$CoordXSiteHydro) # écart-type
plot(onde$CoordXSiteHydro) # graphique simple
hist(onde$CoordXSiteHydro) # distribution (var, quantile) en histogramme
ggplot(data = onde, # autre type distribution plus propre
       aes(x = CoordXSiteHydro)) +
  geom_histogram(fill = "pink",  # fill pour choisir la couleur des barres
                 col = "darkgrey") + # col pour choisir la couleur contours
  labs(x = "Longitude", # nom abscisse
       y = "Nombre d'occurrences", # nom ordonnée
       title = "Mon histogramme") #titre

table(onde$LbRegion) # nb occurrence chaque nom de région

ggplot(data = onde, # distribution en diagramme baton
       aes(x = LbRegion)) +
  geom_bar(fill="pink",
           col = "darkgrey") +
  labs(x = "Région",
       y = "Nombre d'occurrences",
       title = "Mon diagramme") +
  coord_flip()

## Feuille de calcul .ods
# lecture fichier ODS avec readODS
#importation de la première feuille par défaut
invertebres <- readODS::read_ods(path = "raw_data/AFB_Saisie_MinvCE_DREAL_Bzh_RRP_2021.ods")

# choix de la feuille
invertebres <- readODS::read_ods(path = "raw_data/AFB_Saisie_MinvCE_DREAL_Bzh_RRP_2021.ods",
                                 sheet = "04187500")

#choix de la feuille et sélection
invertebres <- readODS::read_ods(path = "raw_data/AFB_Saisie_MinvCE_DREAL_Bzh_RRP_2021.ods",
                                 sheet = "04187500",
                                 skip = 86) %>% #suppression 86 premières lignes
  select(CODE_STATION:C) # sélection certaines colonnes


#autre fichier de données
stations <- readODS::read_ods(path = "raw_data/stations.ods")

##Lecture feuille de calcul Excel
#définition du chemin du fichier
chemin <- "raw_data/aspe_vivarmor.xlsx"
file.exists(chemin) #voir si le chemin est bon

#définition des feuilles
readxl::excel_sheets(chemin) # voir quelles feuilles de dispo

stations_vivarmor <- readxl::read_xlsx(path = chemin,
                                       sheet = "liste_stations")

synthese_vivarmor <- readxl::read_xlsx(path = chemin,
                                       sheet = "synthese")

## Appel d'un API
# Voir fichier API

## Appel d'un shapefile
depts <- sf::read_sf("raw_data/DEPARTEMENT_CARTO.shp")

#visualisation
mapview::mapview(depts)
ggplot(data = depts) + geom_sf()

## Récupérer package sur Github
devtools::install_github(repo = "pascalirz/tod")

her2 <- tod::wfs_sandre(url_wfs = "https://services.sandre.eaufrance.fr/geo/mdo?",
                        couche = "Hydroecoregion2")

ggplot(her2) +
  geom_sf()

mapview::mapview(her2)

her1 <- tod::wfs_sandre(url_wfs = "https://services.sandre.eaufrance.fr/geo/mdo?",
                        couche = "Hydroecoregion1")

ggplot(her1,
       zcol = "gid") +
  geom_sf()

mapview::mapview(her1,
                 alpha.regions = 0.4,
                 zcol = "gid")+
  mapview::mapview(her2)

# modif de test
