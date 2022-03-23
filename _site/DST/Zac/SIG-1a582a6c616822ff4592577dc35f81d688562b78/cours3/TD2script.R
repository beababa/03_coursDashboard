read.csv("cours1.csv")
data <- read.csv("cours1.csv",fileEncoding = "UTF-8" )
head(data,1)
str(data)
tab <- table(data$appétence.codage..1.fort.4.mauvais)
tab
barplot(tab,col = heat.colors(5),border = NA, xlab = "appétence,(1 oui - 4 non)")
tab <- table(data$passé)
tab
barplot(tab,col = colors(2), legend=T)
tab <- table(data$passé)
tab
etik <- names(tab)
barplot(tab,names.arg = etik)
tab <- table(data$futur)
etik <- names(tab)
names(tab)
motif <- grep("arc", data$futur)
data$futur [motif]
data$futur == ""
data$futur [data$futur == ""]
data$futur [data$futur == ""] <- NA
tab <- table(data$futur, useNA  = "always")
names(data)
