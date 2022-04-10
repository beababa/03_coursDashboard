data<-read.csv("cours1.csv",fileEncoding = "UTF-8")
str(data)
tab  <- table (cours1$appétence.codage..1.fort.4.mauvais)
barplot(tab, col = heat.colors(5), border = NA, xlab = "appétence, (1 oui - 4 non)")
