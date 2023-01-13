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

######  Variable $sexe ######

# Visualisation des différentes valeurs qu'on trouve dans la variable $sexe
qplot(x=clients$sexe, data = clients)

# Suppression des valeurs erronnée
clients <- clients[!grepl("N/D", clients$sexe),]
clients <- clients[!grepl(" ", clients$sexe),]
clients <- subset(clients, clients$sexe != "?")

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


clients$taux <- as.integer(clients$taux)
clients[grepl(-1, clients$taux),]
clients <- clients[!grepl(-1, clients$taux),]
subset(clients, clients$taux > 74185)
View(clients)
subset(clients, clients$taux < 544)
clients <- subset(clients, clients$taux >= 544)







View(clients)
clients[grepl("", clients$age),]
subset(clients, clients$age < 18)
subset(clients, clients$age > 84)

View(clients)
clients[grepl(" ", clients$sexe),]
clients[grepl("N/D", clients$sexe),]


View(clients)
clients[grepl("?", clients$sexe),]
subset(clients, clients$sexe != "?")
subset(clients, clients$sexe == "?")


levels(clients$sexe)

levels(clients$sexe)

qplot(x=clients$sexe, data = clients$sexe)


clients$situationFamiliale <- as.factor(clients$situationFamiliale)
clients[grepl(" ", clients$sexe),]
clients[grepl(" ", clients$situationFamiliale),]
clients[grepl("N/D", clients$situationFamiliale),]
clients <- clients[!grepl("N/D", clients$situationFamiliale),]
clients <- clients[!grepl("N/D", clients$situationFamiliale),]
subset(clients, clients$situationFamiliale == "?")
subset(clients, clients$situationFamiliale == " ")
clients <- subset(clients, clients$situationFamiliale != "?")
clients <- subset(clients, clients$situationFamiliale != " ")
View(clients)
View(clients)
clients$sexe[clients$sexe == "C\xe9libataire"]
clients$sexe[clients$situationFamiliale == "C\xe9libataire"]
clients$situationFamiliale[clients$situationFamiliale == "C\xe9libataire"]
levels(clients$situationFamiliale)
clients$situationFamiliale <- droplevels(clients$situationFamiliale)
levels(clients$situationFamiliale)
clients$situationFamiliale[clients$situationFamiliale == "C\xe9libataire"]
install.packages("stringr")
library("stringr")
str_replace(clients$situationFamiliale, "C\xe9libataire", "Celibataire")
View(clients)
str_replace(clients$situationFamiliale, "C\xe9libataire", "Celibataire")
str_replace(clients$situationFamiliale, "célibataire", "Celibataire")
str_replace(clients$situationFamiliale, "Celibataire", "célibataire")
str_replace(clients$situationFamiliale, "C\xe9libataire", "Celibataire")
str_replace(clients$situationFamiliale, "C\xe9libataire", "Celibataire")
str_replace(clients$situationFamiliale, "Mari<e9>", "Marie(e)")
clients$situationFamiliale <- str_replace(clients$situationFamiliale, "C\xe9libataire", "Celibataire")
str_replace(clients$situationFamiliale, "Mari\xe9(e)", "Marie(e)")
str_replace(clients$situationFamiliale, "Mari<e9>(e)", "Marie(e)")
clients[306, 4]
clients[309, 4]
clients[300:"390", 4]
clients[200:"1000", 4]
clients$situationFamiliale <- str_replace(clients$situationFamiliale, "Mari\xe9(e)", "Marie(e)")
clients$situationFamiliale <- str_replace(clients$situationFamiliale, "Mari\xe9e(e)", "Marie(e)")
levels(clients$situationFamiliale)
clients$situationFamiliale[clients$situationFamiliale == "C\xe9libataire"]
clients$situationFamiliale[clients$situationFamiliale == "Celibataire"]
subset(clients, clients$situationFamiliale == "Celibataire")
as.factor(clients$situationFamiliale)
clients$situationFamiliale <- str_replace(clients$situationFamiliale, "Mari�(e)", "Marie(e)")
clients$situationFamiliale <- str_replace(clients$situationFamiliale, "Mari\xe9e(e)", "Marie(e)")
clients$situationFamiliale <- str_replace(clients$situationFamiliale, "Divorc\xe9e", "Divorcée")
clients$situationFamiliale <- str_replace(clients$situationFamiliale, "Divorcée", "Divorcee")
clients$situationFamiliale <- str_replace(clients$situationFamiliale, "Mari\xe9e", "Marie(e)")
clients$situationFamiliale <- str_replace(clients$situationFamiliale, "Mari\xe9(e)", "Marie(e)")
summary(clients)

summary(clients)
levels(clients$situationFamiliale)
as.factor(clients$situationFamiliale)
View(clients)
clients$situationFamiliale[clients$situationFamiliale == "Mari\xe9(e)"]
clients$situationFamiliale[clients$situationFamiliale == "Mari<e9>(e)"]
View(clients)

clients[grepl("N/D", clients$X2eme.voiture),]
clients[grepl(" ", clients$X2eme.voiture),]
clients[grepl("?", clients$X2eme.voiture),]
subset(clients, clients$X2eme.voiture == "?")
subset(clients, clients$X2eme.voiture == " ")
subset(clients, clients$X2eme.voiture == "N/D")
summary(clients)
na.omit(clients$X2eme.voiture)
na.omit(clients)

clients[grepl(-1, clients$nbEnfantsAcharge),]
clients <-  clients[!grepl(-1, clients$nbEnfantsAcharge),]
clients[grepl(-1, clients$nbEnfantsAcharge),]
na.omit(clients)
clients <- na.omit(clients)
subset(clients, clients$nbEnfantsAcharge == "?")
subset(clients, clients$nbEnfantsAcharge == " ")
subset(clients, clients$nbEnfantsAcharge == "N/D")
subset(clients, clients$nbEnfantsAcharge > 4)
catalogue <- read.csv("Groupe_TPT_4/Catalogue.csv", header = TRUE, sep = ",", dec = ".")
View(catalogue)
catalogue$puissance <- as.integer(catalogue$puissance)
catalogue[grepl(-1, catalogue$puissance),]
catalogue[grepl(0, catalogue$puissance),]
subset(catalogue, catalogue$puissance == 0)
subset(catalogue, catalogue$puissance < 0)
subset(catalogue, catalogue$puissance < 55)
subset(catalogue, catalogue$puissance > 507)
catalogue$longueur[catalogue$longueur == "tr\xe8s longue"]
catalogue$longueur[catalogue$longueur == "tr\xe8s longue"] <- "tres longue"
catalogue$longueur[catalogue$longueur == "tr\xe8s longue"]
catalogue$puissance <- as.facto(catalogue$longueur)
catalogue$longueur <- as.factor(catalogue$longueur)
levels(catalogue$longueur)
catalogue$nbPlaces <- as.integer(catalogue$nbPlaces)
clients[grepl(-1, catalogue$nbPlaces),]
subset(catalogue, catalogue$nbPlaces > 7)
subset(catalogue, catalogue$nbPlaces < 5)
catalogue$nbPortes <- as.integer(catalogue$nbPortes)
clients[grepl(-1, catalogue$nbPortes),]
subset(catalogue, catalogue$nbPortes > 5)
subset(catalogue, catalogue$nbPortes < 3)
catalogue$couleur <- as.factor(catalogue$couleur)
clients[grepl("N/D", catalogue$couleur),]
clients[grepl(" ", catalogue$couleur),]
subset(catalogue, catalogue$couleur == "?")
levels(catalogue$couleur)
catalogue$occasion <- as.logical(catalogue$occasion)
clients[grepl(-1, catalogue$occasion),]
clients[grepl("-1", catalogue$occasion),]
catalogue$prix <- as.integer(catalogue$prix)
subset(catalogue, catalogue$prix > 101300)
subset(catalogue, catalogue$prix < 7500)
immatriculations <- read.csv("Groupe_TPT_4/Immatriculations.csv", header = TRUE, sep = ",", dec = ".")
View(immatriculations)
View(immatriculations)
immatriculations$puissance <- as.integer(immatriculations$puissance)
mmatriculations[grepl(-1, immatriculations$puissance),]
immatriculations[grepl(-1, immatriculations$puissance),]
immatriculations[grepl(0, immatriculations$puissance),]
subset(immatriculations, immatriculations$puissance == 0)
subset(immatriculations, immatriculations$puissance < 0)
subset(immatriculations, immatriculations$puissance < 55)
subset(immatriculations, immatriculations$puissance > 507)
immatriculations$longueur[immatriculations$longueur == "tr\xe8s longue"]
immatriculations$longueur[immatriculations$longueur == "tr\xe8s longue"] <- "tres longue"
immatriculations$longueur[immatriculations$longueur == "tr\xe8s longue"]
immatriculations$longueur <- as.factor(immatriculations$longueur)
immatriculations[grepl("N/D", immatriculations$longueur),]
immatriculations[grepl(" ", immatriculations$longueur),]
subset(immatriculations, immatriculations$longueur == " ")
subset(immatriculations, immatriculations$longueur == "?")
View(immatriculations)
levels(immatriculations$longueur)
immatriculations$nbPlaces <- as.integer(immatriculations$nbPlaces)
immatriculations[grepl(-1, immatriculations$nbPlaces),]
subset(immatriculations, immatriculations$nbPlaces < 5)
subset(immatriculations, immatriculations$nbPlaces > 7)
immatriculations$nbPortes <- as.integer(immatriculations$nbPortes)
immatriculations[grepl(-1, immatriculations$nbPortes),]
subset(immatriculations, immatriculations$nbPors > 5)
subset(immatriculations, immatriculations$nbPortes > 5)
subset(immatriculations, immatriculations$nbPortes < 3)
immatriculations$couleur <- as.factor(immatriculations$couleur)
immatriculations[grepl("N/D", immatriculations$couleur),]
immatriculations[grepl(" ", immatriculations$couleur),]
subset(immatriculations, immatriculations$couleur == "?")
levels(immatriculations$couleur)
subset(immatriculations, immatriculations$couleur == "-1")
immatriculations$occasion <- as.logical(immatriculations$occasion)
immatriculations[grepl(-1, immatriculations$occasion),]
immatriculations[grepl("-1", immatriculations$occasion),]
subset(immatriculations, immatriculations$occasion == "N/D")
subset(immatriculations, immatriculations$occasion == " ")
immatriculations$prix <- as.integer(immatriculations$prix)
subset(immatriculations, immatriculations$prix > 101300)
subset(immatriculations, immatriculations$prix > 7500)
subset(immatriculations, immatriculations$prix < 7500)
savehistory("~/Documents/Master-2/TPA/Projet/Sans titre.Rhistory")
View(immatriculations)
subset(immatriculations, immatriculations$longueur == "moyenne" & immatriculations$puissance > 300 )
subset(immatriculations, immatriculations$longueur == "moyenne" & immatriculations$puissance > 250 )
subset(immatriculations, immatriculations$longueur == "moyenne" & immatriculations$puissance > 200 )
subset(immatriculations, immatriculations$longueur == "moyenne" & immatriculations$puissance < 200 )
subset(immatriculations, immatriculations$longueur == "longue" & immatriculations$puissance > 200 )
subset(immatriculations, immatriculations$longueur == "longue" & immatriculations$puissance > 180 )
subset(immatriculations, immatriculations$longueur == "moyenne" & immatriculations$puissance > 180 )
subset(immatriculations, immatriculations$longueur == "tres longue" & immatriculations$puissance > 180 )
subset(immatriculations,  immatriculations$puissance > 300 )
subset(immatriculations, immatriculations$longueur == "courte" & immatriculations$puissance > 180 )
subset(immatriculations, immatriculations$longueur == "courte" & immatriculations$nbPlaces = 5 )
subset(immatriculations, immatriculations$longueur == "courte" & immatriculations$nbPlaces == 5 )
subset(immatriculations, immatriculations$longueur == "courte" & immatriculations$nbPortes == 3 )
subset(immatriculations, immatriculations$longueur == "moyenne" & immatriculations$nbPortes == 3 )
subset(immatriculations, immatriculations$longueur == "courte" & immatriculations$puissance > 180)
subset(immatriculations, immatriculations$longueur == "courte" & immatriculations$puissance > 100)
subset(immatriculations, immatriculations$longueur == "longue" & immatriculations$puissance = 180)
subset(immatriculations, immatriculations$longueur == "longue" & immatriculations$puissance == 180)
subset(immatriculations, immatriculations$longueur == "longue" & immatriculations$puissance < 180)
subset(immatriculations, immatriculations$longueur == "tres longue" & immatriculations$puissance > 180)
subset(immatriculations, immatriculations$longueur == "tres longue" & immatriculations$puissance > 300)
subset(immatriculations, immatriculations$longueur == "tres longue" & immatriculations$puissance < 100)
subset(immatriculations, immatriculations$longueur == "tres longue" & immatriculations$puissance < 150)
subset(immatriculations, immatriculations$longueur == "tres longue" & immatriculations$puissance > 300)
subset(immatriculations, immatriculations$longueur == "tres longue" & immatriculations$nbPlaces > 5)
subset(immatriculations, immatriculations$longueur == "courte" & immatriculations$puissance > 180)
subset(immatriculations, immatriculations$longueur == "courte" & immatriculations$puissance > 150)
subset(immatriculations, immatriculations$longueur == "courte" & immatriculations$puissance > 120)
subset(immatriculations, immatriculations$longueur == "courte" & immatriculations$puissance > 110)
subset(immatriculations, immatriculations$longueur == "courte" & immatriculations$puissance > 118)
subset(immatriculations, immatriculations$longueur == "courte" & immatriculations$puissance > 116)
subset(immatriculations, immatriculations$longueur == "courte" & immatriculations$puissance > 116)
subset(immatriculations, immatriculations$longueur == "moyenne" & immatriculations$puissance < 180)
subset(immatriculations, immatriculations$longueur == "moyenne" & immatriculations$puissance < 180 & immatriculations$nbPlaces == 7)
subset(immatriculations, immatriculations$longueur == "longue" & immatriculations$puissance < 180 & immatriculations$nbPlaces == 7)
subset(immatriculations, immatriculations$longueur == "longue" & immatriculations$puissance < 180 & immatriculations$nbPlaces < 7)
subset(immatriculations, immatriculations$longueur == "longue" & immatriculations$puissance < 200 & immatriculations$nbPlaces < 7)
subset(immatriculations, immatriculations$longueur == "longue" & immatriculations$puissance < 200 & immatriculations$nbPlaces == 7)
subset(immatriculations, immatriculations$longueur == "longue" & immatriculations$puissance < 200 & immatriculations$nbPlaces < 7)
subset(immatriculations, (immatriculations$longueur == "longue" | immatriculations$longueur == "moyenne" ) & immatriculations$puissance < 300 & (immatriculations$nbPlaces >= 5  | immatriculations$nbPlaces <= 7) & immatriculations$nbPlaces == 5)
subset(immatriculations, (immatriculations$longueur == "longue" | immatriculations$longueur == "moyenne" ) & immatriculations$puissance < 180 & (immatriculations$nbPlaces >= 5  | immatriculations$nbPlaces <= 7) & immatriculations$nbPlaces == 5)
subset(immatriculations, (immatriculations$longueur == "longue" | immatriculations$longueur == "moyenne" ) & immatriculations$puissance < 100 & (immatriculations$nbPlaces >= 5  | immatriculations$nbPlaces <= 7) & immatriculations$nbPlaces == 5)
subset(immatriculations, (immatriculations$longueur == "longue" | immatriculations$longueur == "moyenne" ) & immatriculations$puissance < 120 & (immatriculations$nbPlaces >= 5  | immatriculations$nbPlaces <= 7) & immatriculations$nbPlaces == 5)
subset(immatriculations, (immatriculations$longueur == "longue" | immatriculations$longueur == "moyenne" ) & immatriculations$puissance < 120 & (immatriculations$nbPlaces >= 5  | immatriculations$nbPlaces <= 7) )
subset(immatriculations, immatriculations$longueur == "longue" (immatriculations$nbPlaces >= 5  | immatriculations$nbPlaces <= 7) )
subset(immatriculations, immatriculations$longueur == "longue" & (immatriculations$nbPlaces >= 5  | immatriculations$nbPlaces <= 7) )
subset(immatriculations, immatriculations$longueur == "longue" & ( immatriculations$nbPlaces <= 7) )
subset(immatriculations, immatriculations$longueur == "longue" & ( immatriculations$nbPlaces == 7) )
subset(catalogue, catalogue$longueur == "longue" & ( catalogue$nbPlaces == 7) )
subset(immatriculations, immatriculations$longueur == "longue" & immatriculations$puissance < 200 & immatriculations$nbPlaces == 7)
subset(immatriculations, immatriculations$longueur == "tres longue" & immatriculations$puissance > 200 )
immatriculation$voitureParCategories <- ifelse(immatriculation$longueur=="courte","citadine",
ifelse(immatriculation$longueur=="longue"&immatriculation$nbPlaces== 7&immatriculation$puissance<180,"familiale",
ifelse(immatriculation$longueur=="longue" | immatriculation$longueur=="moyenne" & immatriculation$puissance >=180 & immatriculation$puissance <= 300,"sport",
ifelse(immatriculation$longueur == "tres longue" & immatriculation$puissance >300, "berline","autres"))))))
immatriculation$voitureParCategories <- ifelse(immatriculation$longueur=="courte","citadine",
ifelse(immatriculation$longueur=="longue"&immatriculation$nbPlaces== 7&immatriculation$puissance<180,"familiale",
ifelse(immatriculation$longueur=="longue" | immatriculation$longueur=="moyenne" & immatriculation$puissance >=180 & immatriculation$puissance <= 300,"sport",
ifelse(immatriculation$longueur == "tres longue" & immatriculation$puissance >300, "berline","autres"))))
immatriculations$voitureParCategories <- ifelse(immatriculations$longueur == "courte","citadine",
ifelse(immatriculations$longueur == "longue" & immatriculations$nbPlaces == 7 & immatriculations$puissance<180,"familiale",
ifelse(immatriculations$longueur=="longue" | immatriculations$longueur=="moyenne" & immatriculations$puissance >=180 & immatriculations$puissance <= 300,"sport",
ifelse(immatriculations$longueur == "tres longue" & immatriculations$puissance >300, "berline","autres"))))
immatriculations$voitureParCategories <- ifelse(immatriculations$longueur == "courte","citadine",
ifelse(immatriculations$longueur == "longue" & immatriculations$nbPlaces == 7 & immatriculations$puissance<180,"familiale",
ifelse( (immatriculations$longueur=="longue" | immatriculations$longueur=="moyenne") & immatriculations$nbPlaces <= 5 & immatriculations$puissance >=180 & immatriculations$puissance <= 300,"sport",
ifelse(immatriculations$longueur == "tres longue" & immatriculations$nbPlaces <= 5 & immatriculations$puissance >300, "berline","autres"))))
View(immatriculations)
View(immatriculations)
immatriculations$voitureParCategories <- ifelse(immatriculations$longueur == "courte","citadine",
ifelse(immatriculations$longueur == "longue" & immatriculations$nbPlaces == 7 & immatriculations$puissance<180,"familiale",
ifelse( (immatriculations$longueur=="longue" | immatriculations$longueur=="moyenne") & immatriculations$nbPlaces <= 5 & immatriculations$puissance >=130 & immatriculations$puissance <= 300,"sport",
ifelse(immatriculations$longueur == "tres longue" & immatriculations$nbPlaces <= 5 & immatriculations$puissance >300, "berline","autres"))))
immatriculations$voitureParCategories <- ifelse(immatriculations$longueur == "courte","citadine",
ifelse(immatriculations$longueur == "longue" & immatriculations$nbPlaces == 7 & immatriculations$puissance<180,"familiale",
ifelse( (immatriculations$longueur=="longue" | immatriculations$longueur=="moyenne") & immatriculations$nbPlaces <= 5 & immatriculations$puissance >=130 & immatriculations$puissance <= 300,"sport",
ifelse(immatriculations$longueur == "tres longue" & immatriculations$nbPlaces <= 5 , "berline","autres"))))
catalogue$voitureParCategories <- ifelse(catalogue$longueur == "courte","citadine",
ifelse(catalogue$longueur == "longue" & catalogue$nbPlaces == 7 & catalogue$puissance<180,"familiale",
ifelse( (catalogue$longueur=="longue" | catalogue$longueur=="moyenne") & catalogue$nbPlaces <= 5 & catalogue$puissance >=130 & catalogue$puissance <= 300,"sport",
ifelse(catalogue$longueur == "tres longue" & catalogue$nbPlaces <= 5 , "berline","autres"))))
catalogue$voitureParCategories <- ifelse((catalogue$longueur == "courte" | catalogue$longueur == "moyenne") & catalogue$puissance <= 120 ,"citadine",
ifelse(catalogue$longueur == "longue" & catalogue$nbPlaces == 7 & catalogue$puissance<180,"familiale",
ifelse( (catalogue$longueur=="longue" | catalogue$longueur=="moyenne") & catalogue$nbPlaces <= 5 & catalogue$puissance >=130 & catalogue$puissance <= 300,"sport",
ifelse(catalogue$longueur == "tres longue" & catalogue$nbPlaces <= 5 , "berline","autres"))))
View(catalogue)
immatriculations$voitureParCategories <- ifelse((immatriculations$longueur == "courte" | immatriculations$longueur == "moyenne") & immatriculations$puissance <= 120 ,"citadine",
ifelse(immatriculations$longueur == "longue" & immatriculations$nbPlaces == 7 & immatriculations$puissance<180,"familiale",
ifelse( (immatriculations$longueur=="longue" | immatriculations$longueur=="moyenne") & immatriculations$nbPlaces <= 5 & immatriculations$puissance >=130 & immatriculations$puissance <= 300,"sport",
ifelse(immatriculations$longueur == "tres longue" & immatriculations$nbPlaces <= 5 , "berline","autres"))))
immatriculations[grepl("autres", immatriculations$voitureParCategories),]
immatriculations$voitureParCategories <- ifelse(immatriculations$longueur == "courte","citadine",
ifelse(immatriculations$longueur == "longue" & immatriculations$nbPlaces == 7 & immatriculations$puissance<180,"familiale",
ifelse( (immatriculations$longueur=="longue" | immatriculations$longueur=="moyenne") & immatriculations$nbPlaces <= 5 & immatriculations$puissance >=130 & immatriculations$puissance <= 300,"sport",
ifelse(immatriculations$longueur == "tres longue" & immatriculations$nbPlaces <= 5 , "berline","autres"))))
immatriculations[grepl("autres", immatriculations$voitureParCategories),]
immatriculations$voitureParCategories <- ifelse((immatriculations$longueur == "courte" | immatriculations$longueur == "moyenne") & immatriculations$puissance <= 120 ,"citadine",
ifelse(immatriculations$longueur == "longue" & immatriculations$nbPlaces == 7 & immatriculations$puissance<180,"familiale",
ifelse( (immatriculations$longueur=="longue" | immatriculations$longueur=="moyenne") & immatriculations$nbPlaces <= 5 & immatriculations$puissance >=130 & immatriculations$puissance <= 300,"sport",
ifelse(immatriculations$longueur == "tres longue" & immatriculations$nbPlaces <= 5 , "berline","autres"))))
immatriculations[grepl("autres", immatriculations$voitureParCategories),]
immatriculations$voitureParCategories <- ifelse((immatriculations$longueur == "courte" | immatriculations$longueur == "moyenne") & immatriculations$puissance <= 120 ,"citadine",
ifelse(immatriculations$longueur == "longue" & immatriculations$nbPlaces == 7 & immatriculations$puissance<180,"familiale",
ifelse( (immatriculations$longueur=="longue" | immatriculations$longueur=="moyenne") & immatriculations$nbPlaces <= 5 & immatriculations$puissance >=130 & immatriculations$puissance <= 300,"sport",
ifelse( (immatriculations$longueur == "tres longue" | (immatriculations$longueur == "tres longue" & immatriculations$puissance >=100 &  immatriculations$puissance <=125 ) ) & immatriculations$nbPlaces <= 5 , "berline","autres"))))
immatriculations$voitureParCategories <- ifelse((immatriculations$longueur == "courte" | immatriculations$longueur == "moyenne") & immatriculations$puissance <= 120 ,"citadine",
ifelse(immatriculations$longueur == "longue" & immatriculations$nbPlaces == 7 & immatriculations$puissance<180,"familiale",
ifelse( (immatriculations$longueur=="longue" | immatriculations$longueur=="moyenne") & immatriculations$nbPlaces <= 5 & immatriculations$puissance >=130 & immatriculations$puissance <= 300,"sport",
ifelse( (immatriculations$longueur == "tres longue" | (immatriculations$longueur == "moyenne" & immatriculations$puissance >=100 &  immatriculations$puissance <=125 ) ) & immatriculations$nbPlaces <= 5 , "berline","autres"))))
immatriculations$voitureParCategories <- ifelse((immatriculations$longueur == "courte" | immatriculations$longueur == "moyenne") & immatriculations$puissance <= 120 ,"citadine",
ifelse(immatriculations$longueur == "longue" & immatriculations$nbPlaces == 7 & immatriculations$puissance<180,"familiale",
ifelse( (immatriculations$longueur=="longue" | immatriculations$longueur=="moyenne") & immatriculations$nbPlaces <= 5 & immatriculations$puissance >=130 & immatriculations$puissance <= 300,"sport",
ifelse( (immatriculations$longueur == "tres longue" | (immatriculations$longueur == "longue" & immatriculations$puissance >=100 &  immatriculations$puissance <=125 ) ) & immatriculations$nbPlaces <= 5 , "berline","autres"))))
catalogue$voitureParCategories <- ifelse((catalogue$longueur == "courte" | catalogue$longueur == "moyenne") & catalogue$puissance <= 120 ,"citadine",
ifelse(catalogue$longueur == "longue" & catalogue$nbPlaces == 7 & catalogue$puissance<180,"familiale",
ifelse( (catalogue$longueur=="longue" | catalogue$longueur=="moyenne") & catalogue$nbPlaces <= 5 & catalogue$puissance >=130 & catalogue$puissance <= 300,"sport",
ifelse((catalogue$longueur == "tres longue" | (catalogue$longueur == "longue" & catalogue$puissance >=100 &  catalogue$puissance <=125 ) ) & catalogue$nbPlaces <= 5 , "berline","autres"))))
immatriculations_clients <- merge(immatriculations, clients, by = "immatriculation")
View(immatriculations_clients)
View(immatriculations_clients)
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c("immatriculation")]
immatriculations_clients <- merge(immatriculations, clients, by = "immatriculation")
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c("immatriculation")]
View(immatriculations_clients)
View(immatriculations_clients)
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c("immatriculation", "marque", "nom", "puissance", "longueur", "nbPlaces, "nbPortes", "couleur", "occasion", "prix" )]
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c("marque", "nom", "puissance", "longueur", "nbPlaces, "nbPortes", "couleur", "occasion", "prix" )]
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c("marque" )]
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c("marque", "nom", "puissance", "longueur", "nbPlaces, "nbPortes", "couleur", "occasion", "prix" )]
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c( "nom")]
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c( "puissance")]
longueur
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c( "longueur")]
nbPlaces
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c( "nbPlaces")]
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c( "nbPortes")]
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c( "nbPortes")]
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c( "couleur")]
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c( "occasion")]
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients) %in% c( "prix")]
immatriculations_clients$voitureParCategories <- as.factor(immatriculations_clients$voitureParCategories)
immatriculations_clients$age <- as.factor(immatriculations_clients$age)
immatriculations_clients$sexe <- as.factor(immatriculations_clients$sexe)
immatriculations_clients$taux <- as.factor(immatriculations_clients$taux)
immatriculations_clients$situationFamiliale <- as.factor(immatriculations_clients$situationFamiliale)
immatriculations_clients$nbEnfantsAcharge <- as.factor(immatriculations_clients$nbEnfantsAcharge)
immatriculations_clients$X2eme.voiture <- as.factor(immatriculations_clients$X2eme.voiture)
cat('test')
cat("Creation l'ensemble dpour le trainning & l'ensemble de test ")
immatriculations_clients_training <- immatriculations_clients[1:30753,]
immatriculations_clients_test <- immatriculations_clients[30754:43933,]
summary((immatriculations_clients$taux))
qplot(x=immatriculations_clients$taux, data = immatriculations_clients)
qplot(y=immatriculations_clients$taux, data = immatriculations_clients)
qplot(x=taux, data = immatriculations_clients)
summary((immatriculations_clients$taux))
View(immatriculations_clients)
immatriculations_clients_training <--> immatriculations_clients_training[,!names(immatriculations_clients_training) %in% c( "taux")]
qplot(x=taux,y= age, data = immatriculations_clients)
qplot(x=immatriculations_clients$taux,y= immatriculations_clients$age, data = immatriculations_clients)
summary((immatriculations_clients$taux))
immatriculations_clients_training_without_taux <- immatriculations_clients_training[,!names(immatriculations_clients_training) %in% c( "taux")]
View(immatriculations_clients_training)
View(immatriculations_clients_training)
immatriculations_clients_training_with_taux <- immatriculations_clients_training
immatriculations_clients_test_with_taux <- immatriculations_clients_test
immatriculations_clients_training <- immatriculations_clients_training[,!names(immatriculations_clients_training) %in% c( "taux")]
immatriculations_clients_test <- immatriculations_clients_test[,!names(immatriculations_clients_test) %in% c( "taux")]
qplot(immatriculations_clients$taux, data = immatriculations_clients)
qplot(immatriculations_clients_training$taux, data = immatriculations_clients_training)
qplot(x=immatriculations_clients_training$taux, data = immatriculations_clients_training)
qplot(x=immatriculations_clients_training$taux, y=immatriculations_clients_training$age, data = immatriculations_clients_training)
treeC <- C5.0(voitureParCategories ~., immatriculations_clients_training)
install.packages("C50")
library(C50)
treeC <- C5.0(voitureParCategories ~., immatriculations_clients_training)
print(treeC)
View(treeC)
treeC <- C5.0(immatriculations_clients_training$voitureParCategories ~., immatriculations_clients_training)
View(treeC)
View(treeC)
print(treeC)
C_class <- predict(treeC, immatriculations_clients_test, type="class")
C_class <- predict(treeC, immatriculations_clients_test, type="class")
is.factor(immatriculations_clients_test$voitureParCategories)
treeC <- C5.0(voitureParCategories ~., immatriculations_clients_training)
C_class <- predict(treeC, immatriculations_clients_test, type="class")
treeC <- C5.0(voitureParCategories ~., immatriculations_clients_training_with_taux)
print(treeC)
C_class <- predict(treeC, immatriculations_clients_test_with_taux, type="class")
treeC <- C5.0(immatriculations_clients_training$voitureParCategories , immatriculations_clients_training)
is.factor(immatriculations_clients_test$voitureParCategories)
is.factor(immatriculations_clients_training$voitureParCategories)
is.factor(immatriculations_clients_training$age)
is.factor(immatriculations_clients_training$sexe)
is.factor(immatriculations_clients_training$nbEnfantsAcharge)
is.factor(immatriculations_clients_training$X2eme.voiture)
treeC <- C5.0(voitureParCategories~., immatriculations_clients_training_with_taux)
print(treeC)
treeC <- C5.0(voitureParCategories~., immatriculations_clients_training)
print(treeC)
immatriculations_clients$voitureParCategories <- as.factor(immatriculations_clients$voitureParCategories)
immatriculations_clients$age <- as.factor(immatriculations_clients$age)
immatriculations_clients$sexe <- as.factor(immatriculations_clients$age)
immatriculations_clients$sexe <- as.factor(immatriculations_clients$sexe)
immatriculations_clients$situationFamiliale <- as.factor(immatriculations_clients$situationFamiliale)
immatriculations_clients$nbEnfantsAcharge <- as.factor(immatriculations_clients$nbEnfantsAcharge)
immatriculations_clients$X2eme.voiture <- as.factor(immatriculations_clients$X2eme.voiture)
immatriculations_clients_training <- immatriculations_clients[1:30753,]
immatriculations_clients_test <- immatriculations_clients[30754:43933,]
immatriculations_clients_test <- immatriculations_clients_test[,!names(immatriculations_clients_test) %in% c( "taux")]
immatriculations_clients_training <- immatriculations_clients_training[,!names(immatriculations_clients_training) %in% c( "taux")]
treeC <- C5.0(voitureParCategories~., immatriculations_clients_training)
print(treeC)
treeC <- C5.0(voitureParCategories~., immatriculations_clients_training)
print(treeC)
View(immatriculations_clients_training_with_taux)
summary(immatriculations_clients$taux)
View(immatriculations_clients_training_with_taux)
immatriculations_clients_training_with_taux$tauxParCategories <- ifelse(immatriculations_clients_training_with_taux$taux <589, "Faible",
ifelse(immatriculations_clients_training_with_taux$taux <901.7, "Moyen",
ifelse(immatriculations_clients_training_with_taux$taux < 1147, "Eleve","Tres Eleve")))
immatriculations_clients_training_with_taux$tauxParCategories <- ifelse(immatriculations_clients_training_with_taux$taux < 589, "Faible",
ifelse(immatriculations_clients_training_with_taux$taux < 901.7, "Moyen",
ifelse(immatriculations_clients_training_with_taux$taux < 1147, "Eleve","Tres Eleve")))
immatriculations_clients_training_with_taux$tauxParCategories <- ifelse(immatriculations_clients_training_with_taux$taux < as.factor(589), "Faible",
ifelse(immatriculations_clients_training_with_taux$taux < as.factor(901.7), "Moyen",
ifelse(immatriculations_clients_training_with_taux$taux < as.factor(1147), "Eleve","Tres Eleve")))
View(immatriculations_clients_training_with_taux)
immatriculations_clients_training_with_taux <- immatriculations_clients_training
immatriculations_clients_training_with_taux <- immatriculations_clients[1:30753,]
immatriculations_clients_test_with_taux <- immatriculations_clients[30754:43933,]
immatriculations_clients_training_with_taux$tauxParCategories <- ifelse(immatriculations_clients_training_with_taux$taux < 589, "Faible",
ifelse(immatriculations_clients_training_with_taux$taux < 901.7, "Moyen",
ifelse(immatriculations_clients_training_with_taux$taux < 1147, "Eleve","Tres Eleve")))
as.integer(immatriculations_clients_training_with_taux$taux)
immatriculations_clients_training_with_taux$tauxParCategories <- ifelse(immatriculations_clients_training_with_taux$taux < as.factor(589), "Faible",
ifelse(immatriculations_clients_training_with_taux$taux < as.factor(901.7), "Moyen",
ifelse(immatriculations_clients_training_with_taux$taux < as.factor(1147), "Eleve","Tres Eleve")))
immatriculations_clients_training_with_taux$tauxParCategories <- ifelse(immatriculations_clients_training_with_taux$taux < 589, "Faible",
ifelse(immatriculations_clients_training_with_taux$taux < 901.7, "Moyen",
ifelse(immatriculations_clients_training_with_taux$taux < 1147, "Eleve","Tres Eleve")))
View(immatriculations_clients)
View(immatriculations_clients)
View(immatriculations_clients)
View(immatriculations)
subset(immatriculations, immatriculations$occasion == FALSE)
View(immatriculations_clients)
subset(immatriculations_clients, immatriculations_clients$age = 21 & immatriculations_clients$taux >= 1000 )
subset(immatriculations_clients, immatriculations_clients$age == 21 & immatriculations_clients$taux >= 1000 )
is.factor(immatriculations_clients$age)
subset(immatriculations_clients, immatriculations_clients$age == "21" & immatriculations_clients$taux >= "1000" )
View(clients)
View(clients)
View(immatriculations_clients)
View(immatriculations_clients)
predictionMarketing <- read.csv("Groupe_TPT_4/Marketing2.csv", header = TRUE, sep = ",", dec = ".")
View(predictionMarketing)
table(predictionMarketing)
savehistory("~/Documents/Master-2/TPA/Projet/script.Rhistory")
