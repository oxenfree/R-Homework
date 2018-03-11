data("CO2")
summary(CO2)
CO2[, c(1,3)]
str(CO2)
summary(CO2)
rownames(CO2)
ms <- CO2[which(CO2$Type == "Mississippi"),]
qu <- CO2[which(CO2$Type == "Quebec"),]
mean(ms$conc)
mean(qu$conc)
upt <- CO2[which(CO2$uptake > 30),]
rownames(upt)
grand <- CO2[which(CO2$conc == 1000),]
nrow(grand)

type_select <- function(frame, typeMatch = "Quebec") {
  return(frame[which(frame$Type == typeMatch),])
}

type_select(CO2)
type_select(CO2, "Mississippi")
