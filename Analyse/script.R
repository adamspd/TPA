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


#Suppression des variable inutiles
immatriculations_clients <- immatriculations_clients[,!names(immatriculations_clients)
                                        %in% c("immatriculation",
                                                "marque",
                                                "nom",
                                                "puissance",
                                                "longueur",
                                                "nbPlaces",
                                                "nbPortes",
                                                "couleur",
                                                "occasion",
                                                "prix" )]


#Convertir les variable en Factor
immatriculations_clients$voitureParCategories <- as.factor(immatriculations_clients$voitureParCategories)
immatriculations_clients$age <- as.factor(immatriculations_clients$age)
immatriculations_clients$sexe <- as.factor(immatriculations_clients$sexe)
immatriculations_clients$taux <- as.factor(immatriculations_clients$taux)
immatriculations_clients$situationFamiliale <- as.factor(immatriculations_clients$situationFamiliale)
immatriculations_clients$nbEnfantsAcharge <- as.factor(immatriculations_clients$nbEnfantsAcharge)
immatriculations_clients$X2eme.voiture <- as.factor(immatriculations_clients$X2eme.voiture)

summary(immatriculations_clients)

#Creation l'ensemble d'apprentissage + testes
immatriculations_clients_training <- immatriculations_clients[1:61422,]
immatriculations_clients_test <- immatriculations_clients[61423:88059,]



#Apprentissage SVM
svm_classifieur_1 <- svm(voitureParCategories~., immatriculations_clients_training, probability=TRUE)

#Prediction sur l'ensemble de testes
svm_classifieur_1_class <- predict(svm_classifieur_1, immatriculations_clients_test, type="response")

#Probabilité pour chaque prédiction
table(svm_classifieur_1_class)
table(immatriculations_clients_test$voitureParCategories, svm_classifieur_1_class)

#Taux precision = 0,719     #Taux erreur = 0,281

#Calcule de L'AUC
svm_classifieur_1_prob <- predict(svm_classifieur_1, immatriculations_clients_test, probability=TRUE)

svm_classifieur_1_prob <- as.data.frame(attr(svm_classifieur_1_prob, "probabilities"))
svm_classifieur_1_auc <-multiclass.roc(immatriculations_clients_test$voitureParCategories, svm_classifieur_1_prob)
cat (svm_classifieur_1_auc)

# AUC = 0.899



#Apprentissage C50
c_50_classifieur_2 <- C5.0(voitureParCategories ~., immatriculations_clients_training)
#Prediction sur l'ensemble de testes
c_50_classifieur_2_class <- predict(c_50_classifieur_2, immatriculations_clients_test, type="class")

#Probabilité pour chaque prédiction
table(c_50_classifieur_2_class)
table(immatriculations_clients_test$voitureParCategories, c_50_classifieur_2_class)

#Taux precision = 0,726     #Taux erreur = 0,274

#Calcule de L'AUC
c_50_classifieur_2_prob <- predict(c_50_classifieur_2, immatriculations_clients_test, type="prob")

c_50_classifieur_2_auc <-multiclass.roc(immatriculations_clients_test$voitureParCategories, c_50_classifieur_2_prob)

cat (c_50_classifieur_2_auc)

# AUC = 0.898



#Apprentissage Nnet
nnet_classifieur_3<-nnet(voitureParCategories ~., immatriculations_clients_training, size=)

#Prediction sur l'ensemble de testes
nnet_classifieur_3_class <- predict(nnet_classifieur_3, immatriculations_clients_test, type="class")

#Probabilité pour chaque prédiction
table(nnet_classifieur_3_class)
table(immatriculations_clients_test$voitureParCategories, nnet_classifieur_3_class)

#Taux precision = 0,729     #Taux erreur = 0,271

#Calcule de L'AUC
nnet_classifieur_3_prob <- predict(nnet_classifieur_3, immatriculations_clients_test, type="raw")

nnet_classifieur_3_auc <-multiclass.roc(immatriculations_clients_test$voitureParCategories, nnet_classifieur_3_prob)

cat (nnet_classifieur_3_auc)

# AUC = 0.902


#Modele de prediction

# Importation de fichier marketing.csv
predictionMarketing <- read.csv("../Groupe_TPT_4/Marketing.csv", header = TRUE, sep = ",", dec = ".")

predictionMarketing$situationFamiliale <- str_replace(predictionMarketing$situationFamiliale, "C\xe9libataire", "Celibataire")

# Convertir au bon type
predictionMarketing$age <- as.factor(predictionMarketing$age)
predictionMarketing$sexe <- as.factor(predictionMarketing$sexe)
predictionMarketing$taux <- as.factor(predictionMarketing$taux)
predictionMarketing$situationFamiliale <- as.factor(predictionMarketing$situationFamiliale)
predictionMarketing$nbEnfantsAcharge <- as.factor(predictionMarketing$nbEnfantsAcharge)
predictionMarketing$X2eme.voiture <- as.factor(predictionMarketing$X2eme.voiture)

# Application de prediction

class.nnet <- predict(nnet_classifieur_3_class, predictionMarketing)
categorie_voiture_predit <- data.frame(predictionMarketing, class.nnet)

write.table(categorie_voiture_predit, file='categorie_voiture_predit', sep="\t", dec=".", row.names = )

