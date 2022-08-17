## Função para extrair dados dos arquivos INMET

df_inmet <- function(x, path=".") {
    col <- c("data", "hora","prec","patm","patm.max","patm.min",
             "rg","tar","tpo","tar.max","tar.min","tpo.max","tpo.min",
             "ur.max","ur.min","ur","vento.dir","vento.raj","vento.vel","drop")
    
    df <- c()
    for (i in x) {
        df <- rbind(df, rio::import(paste0(path, i),
                                    skip = 8,
                                    dec = ",",
                                    col.names=col
        )) 
    }
    
    df <- df %>%
        mutate(data, ymd_hm(paste(data, hora), tz = "UTC")) %>%
        mutate(data = with_tz(data, tzone="America/Sao_Paulo")) %>%
        select(-c(hora, drop))
     
    return(tibble(df))
}

muni_sc  <- function(mun, alt, lat) {
    x <- list.files(path="dados", pattern = mun)%>%
        df_inmet(path = "dados/")%>%
        na_if(-9999)%>%
        drop_na()%>%
        group_by(date(data))%>%
        summarise(
            prec = sum(prec),
            TMax = max(tar.max),
            TMin = min(tar.min),
            TMed = mean(tar),
            UR = mean(ur),
            Vv = mean(vento.vel),
            Rg = sum(rg),
            ETO = ETOCalc(TMax, TMin, TMed, UR, Vv, Rg, alt, zv=2, lat))
}
