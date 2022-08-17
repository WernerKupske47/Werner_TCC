########Preenchimento das falhas atraves da Ponderação Regional######

#construir tabela com variaveis dos vizinhos para prever CBS
#CBS,ITA,JCA,RDC
#para a variavel chuva, coluna 2
var_CBS <- CBS[1:3000, ]
var_ITA <- ITA[1:3000, 2]
var_JCA <- JCA[1:3000, 2]
var_RDC <- RDC[1:3000, 2]
tabela_var <- data.frame(var_CBS, var_ITA) %>% 
    data.frame(var_JCA, var_RDC) %>% drop_na()

##Cria coluna: ano e mes
nv_dado <- tabela_var 
nv_dado$ano <- strftime(nv_dado$data, "%y")
nv_dado$mes <- strftime(nv_dado$data, "%m")

nv_dado <- nv_dado %>% select(-data)

#agrega valores mensais de cada ano da variavel analisada
dados_agg_mensal <- aggregate(. ~ mes + ano,
                              nv_dado,
                              FUN = sum)

#média do mes em todos os anos para CBS, ITA, RDC, JCD 
Filter(dados_agg_mensal$var_ITA, mes == "1")

#ARRUMAR A MEDIA DAS VARIAVEIS A CIMA E JOGAR NA FORMULA DA PONDERAÇÃO REGIONAL

### FORMULA PONDERAÇÃO REGIONAL ###
#Prec_cbs_Jun_2009 <-  1/3*((Prec_ita_Jun_2009/Prec_ita_med_Jun)+(Prec_jca_Jun_2009/Prec_jca_med_Jun)+(Prec_rdc_Jun_2009/Prec_rdc_med_Jun))
                                












