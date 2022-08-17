#Preenchimento por meio de algoritmos de inteligencia artificial
#
#RandonForest
#
install.packages("randomForest")
install.packages("caret")
install.packages('Rcpp') 
library(Rcpp)
library(caret)
library(randomForest)
library(munsell)
library(ggplot2)
library(ModelMetrics)
library(recipes)
library(assertthat)
library(bindrcpp)
library(glue)
library(pkgconfig)
library(DEoptimR)
library(dplyr)
library(tidyverse)

#construir tabela com variaveis dos vizinhos para prever CBS
#IAL,CBS,CDR,IAL,JCA,XNR,SJM,RDC
umd_med_CBS <- CBS[1:3000, 8]
umd_med_IAL <- IAL[1:3000, 8]
tabela_umd_med <- c(umd_med_CBS,umd_med_IAL)

#bonco apenas com curitibanos
amostra <- CBS %>% select(-data,-et0) %>% drop_na()
#banco apenas com variaveis iguais entre CBS e os vizinhos
cbs_ial <- inner_join(CBS, IAL, by="data", suffix=c("_cbs", "_ial"))

#RandomForest
ind <- createDataPartition(amostra$chuva, p = 0.7, times = 1, list = FALSE)

treino <- amostra[ind,]
teste <- amostra[-ind,]

rf <- randomForest(tem_med ~ ., data = treino,
                   ntree = 1000,
                   mtry = 5,
                   replace = T,
                   nodesize = 15,
                   keep.forest = T,
                   importance = TRUE
                   )

varImpPlot(rf, main = "Random Forest",)
  
importance(rf)

pred_rf <- predict(rf, newdata=teste)


#Modelo linear
lin <- lm(tem_med~., data=treino)
pred_lin <- predict(lin, newdata=teste)

#plot(teste$chuva~pred_rf)
ggplot(data.frame(teste=teste$et0, pred=pred_lin), aes(x=pred, y=teste))+
    geom_point()+
    geom_abline(slope=1, intercept = 0)

lm(teste$et0~pred_lin) %>% summary()


#Para calcular o Coeficiente de Correlação Linear de Pearson entre as variáveis,
#utilize a função cor:

cor(amostra$chuva,amostra$umd_med)

cor(amostra)

plot(amostra$chuva,amostra$umd_med)

abline(lm(amostra$umd_med ~ amostra$chuva))


library(ggplot2)
ggplot(amostra, aes(x=chuva, y=tem_max))+
    geom_point(alpha=0.1)+
    geom_smooth(method = "lm")




ggplot(cbs_ial, aes(x=chuva_cbs, y=chuva_ial))+
    geom_point()

