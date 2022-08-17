#Principal
rm(list=ls())
install.packages("tidyverse")
install.packages("dplyr")
install.packages("lubridate")
library(tidyverse)
library(lubridate)
library(data.table)
library(datasets)
source("df_inmet.R")
source("ETo_Calc.R")

###DADOS DIARIOS###
#carregar dados outras estações

CBS <- read.csv("https://joaobtj.github.io/boletim_inmet/data/CURITIBANOS.csv") %>% mutate(data = as_date(data))
ITA <- read.csv("https://joaobtj.github.io/boletim_inmet/data/ITUPORANGA.csv")
JCA <- read.csv("https://joaobtj.github.io/boletim_inmet/data/JOACABA.csv")
CDR <- read.csv("https://joaobtj.github.io/boletim_inmet/data/CACADOR.csv")
RDC <- read.csv("https://joaobtj.github.io/boletim_inmet/data/RIO%20DO%20CAMPO.csv")

IAL <- read_csv("https://joaobtj.github.io/boletim_inmet/data/INDAIAL.csv")
SJM <- read.csv("https://joaobtj.github.io/boletim_inmet/data/SAO%20JOAQUIM.csv")
ITA <- read.csv("https://joaobtj.github.io/boletim_inmet/data/ITUPORANGA.csv")
CDR <- read.csv("https://joaobtj.github.io/boletim_inmet/data/CACADOR.csv")
XNR <- read.csv("https://joaobtj.github.io/boletim_inmet/data/XANXERE.csv")
IPA <- read.csv("https://joaobtj.github.io/boletim_inmet/data/ITAPOA.csv")

# Ambiente de teste (para cada variavel selecionar uma parte dos dados sem falhas, retirar uma
# porcentagem dos dados e rodas os algoritmos para cada variavel)
#gerar vetor de datas separadas por dia, para gerar a tabela de teste dos algoritmos
pd <- seq.Date(from = as.date("2019-12-01"),
               to = as.date("2019-12-31"),
               by = "1 day")


## salvar xlsx ####
rio::export(boletim, "public/Boletim_curitibanos_dia.xlsx")