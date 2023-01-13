setwd('/Users/omar./Documents/Master-2/TPA/Projet/VersionFinal')

# Importation de fichier clients.csv
clients <- read.csv("../Groupe_TPT_4/clients_merged.csv", header = TRUE, sep = ",", dec = ".")

# Convertir au bon type
clients$age <- as.integer(clients$age)
clients$sexe <- as.factor(clients$sexe)
clients$taux <- as.integer(clients$taux)
clients$situationFamiliale <- as.factor(clients$situationFamiliale)
clients$nbEnfantsAcharge <- as.integer(clients$nbEnfantsAcharge)
clients$X2eme.voiture <- as.logical(clients$X2eme.voiture)

summary(clients)

######  Variable $age ######

# Suppression des valeurs NA
clients <- na.omit(clients)

# library ggplot2
install.packages("ggplot2")
library(ggplot2)
qplot(x=clients$age, data = clients)

# Suppression des valeurs -1
clients <- clients[!grepl(-1, clients$age),]

# Suppression des valeurs < 18 et > 84
clients <- subset(clients, clients$age >= 17 & clients$age <= 84)

summary(clients$age)

######  Variable $sexe ######

# Visualisation des différentes valeurs qu'on trouve dans la variable $sexe
qplot(x=clients$sexe, data = clients)

# Suppression des valeurs erronnée
clients <- clients[!grepl("N/D", clients$sexe),]
clients <- subset(clients, clients$sexe != " ")
clients <- subset(clients, clients$sexe != "?")

summary(clients$sexe)

# Remettre les données en bon format
clients$sexe[clients$sexe == "Homme"] <- "M"
clients$sexe[clients$sexe == "Masculin"] <- "M"
clients$sexe[clients$sexe == "Femme"] <- "F"
clients$sexe[clients$sexe == "F\xe9minin"] <- "F"


clients$sexe <- as.factor(clients$sexe)
clients$sexe <- droplevels(clients$sexe)

# fonction levels
levels(clients$sexe)


######  Variable $taux ######

# Visualisation des différentes valeurs qu'on trouve dans la variable taux
qplot(x=clients$taux, data = clients)

# Suppression les lignes qui contient une valeur inférieur de 544
clients <- subset(clients, clients$taux >= 544)

summary(clients$taux)


######  Variable $situationFamiliale  ######

# Visualisation des différentes valeurs qu'on trouve dans la variable $situationFamiliale
qplot(x=clients$situationFamiliale, data = clients)


# Suppression des valeurs erronnée
clients <- clients[!grepl("N/D", clients$situationFamiliale),]
clients <- subset(clients, clients$situationFamiliale != " ")
clients <- subset(clients, clients$situationFamiliale != "?")

clients$situationFamiliale <- droplevels(clients$situationFamiliale)
summary(clients$situationFamiliale)

# Remettre les données en bon format
library(stringr)
clients$situationFamiliale <- str_replace(clients$situationFamiliale, "C\xe9libataire", "Celibataire")
clients$situationFamiliale <- str_replace(clients$situationFamiliale, "Divorc\xe9e", "Divorcee")
clients$situationFamiliale <- str_replace(clients$situationFamiliale, "Mari\xe9(e)", "Marie(e")

clients$situationFamiliale <- as.factor(clients$situationFamiliale)
clients$situationFamiliale <- droplevels(clients$situationFamiliale)
summary(clients$situationFamiliale)


######  Variable $nbEnfantsAcharge  ######

# Visualisation des différentes valeurs qu'on trouve dans la variable $situationFamiliale
qplot(x=clients$nbEnfantsAcharge, data = clients)

# Suppression des valeurs erronnée (-1)
clients <- clients[!grepl(-1, clients$nbEnfantsAcharge),]



# Importation de fichier clients.csv
immatriculations <- read.csv("../Groupe_TPT_4/Immatriculations.csv", header = TRUE, sep = ",", dec = ".")

# Convertir au bon type
immatriculations$puissance <- as.integer(immatriculations$puissance)
immatriculations$nbPlaces <- as.integer(immatriculations$nbPlaces)

# Suppression des doublons
immatriculations<-immatriculations[-(which(duplicated(immatriculations$immatriculation))),]


# Remettre les données en bon format
immatriculations$longueur <- str_replace(immatriculations$longueur, "tr\xe8s longue", "tres longue")


# Importation de fichier catalogue.csv
catalogue <- read.csv("../Groupe_TPT_4/Catalogue.csv", header = TRUE, sep = ",", dec = ".")

# Remettre les données en bon format
catalogue$longueur <- str_replace(catalogue$longueur, "tr\xe8s longue", "tres longue")

# Convertir au bon type
catalogue$puissance <- as.integer(catalogue$puissance)
catalogue$nbPlaces <- as.integer(catalogue$nbPlaces)

summary(catalogue)

#Creation voiture par categorie -> catalongue
catalogue$voitureParCategories <- ifelse((catalogue$longueur == "courte" | catalogue$longueur == "moyenne")
                                            & catalogue$puissance <= 120 ,
                                            "citadine",
                                  ifelse(catalogue$longueur == "longue"
                                            & catalogue$nbPlaces == 7
                                            & catalogue$puissance<180,
                                            "familiale",
                                  ifelse((catalogue$longueur=="longue" | catalogue$longueur=="moyenne")
                                            & catalogue$nbPlaces <= 5
                                            & catalogue$puissance >=130 & catalogue$puissance <= 300,
                                            "sport",
                                  ifelse((catalogue$longueur == "tres longue" |
                                            (catalogue$longueur == "longue" & catalogue$puissance >=100 &  catalogue$puissance <=125 ) )
                                            & catalogue$nbPlaces <= 5 ,
                                            "berline",
                                            "autres"))))

#Creation voiture par categorie -> catalongue
immatriculations$voitureParCategories <- ifelse((immatriculations$longueur == "courte" | immatriculations$longueur == "moyenne")
                                                    & immatriculations$puissance <= 120 ,
                                                    "citadine",
                                         ifelse(immatriculations$longueur == "longue" & immatriculations$nbPlaces == 7 & immatriculations$puissance<180,
                                                    "familiale",
                                         ifelse( (immatriculations$longueur=="longue" | immatriculations$longueur=="moyenne")
                                                    & immatriculations$nbPlaces <= 5
                                                    & immatriculations$puissance >=130 & immatriculations$puissance <= 300,
                                                    "sport",
                                         ifelse( (immatriculations$longueur == "tres longue" |
                                                    (immatriculations$longueur == "longue" & immatriculations$puissance >=100 &  immatriculations$puissance <=125 ) )
                                                    & immatriculations$nbPlaces <= 5 ,
                                                    "berline",
                                                    "autres"))))


#Merge deux fichiers immatriculations & clients
immatriculations_clients <- merge(immatriculations, clients, by = "immatriculation")
summary(immatriculations_clients)