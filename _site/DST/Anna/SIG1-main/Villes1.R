villes <- c("Nice","Cannes", "Toulon")

population <- c(338659, 70829, 176198)

df <- as.data.frame(cbind(villes,population))

df

## Villes    Population
## 1 Nice    338 659
## 2 Cannes  70 829
## 3 Toulon  176 198

#mean(df$Population)
mean(population)
