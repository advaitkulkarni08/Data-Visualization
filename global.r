require(tidyr)
require(ggplot2)
require(reshape2)
require(plotly)
require(data.table)
require(rgdal)
library(rworldmap)
require(ggcorrplot)
df <-   read.csv("./FIT5147_29271525_Kadek_A2/hfi_cc_2018.csv", header = T)

summary(df)
sapply(df, function(x) sum(is.na(x)))
#Replace Null Values
df[is.na(df)] <- 0
df[,5:ncol(df)] <- round(df[,5:ncol(df)], 2)

#adding selective columns new df1
#https://stackoverflow.com/questions/10085806/extracting-specific-columns-from-a-data-frame
df1<-  df[, (names(df) %in% c("year","countries","region","pf_rol",	"pf_ss_homicide","pf_ss_disappearances_violent",	"pf_ss_disappearances_fatalities","pf_ss_disappearances_injuries", "pf_ss_women_fgm", "pf_ss_women_inheritance", "pf_religion", "pf_association_sport", "pf_association_political",	"pf_expression_influence",	"pf_expression_internet", "pf_identity_sex", "pf_score", "pf_rank",	"ef_legal_judicial", "ef_legal_military",	"ef_legal_integrity",	"ef_legal_police",	"ef_money_growth",	"ef_trade_tariffs_revenue",	"ef_trade_movement_foreign",	"ef_trade_movement_visit",	"ef_regulation_business_adm",	"ef_regulation_business_bureaucracy",	"ef_regulation_business_start",	"ef_regulation_business_bribes",	"ef_regulation_business_licensing",	"ef_score","ef_rank", "hf_score","hf_rank"
))]

df2 <- df1[, (names(df1) %in% c("pf_rol",	"pf_ss_homicide","pf_ss_disappearances_violent",	"pf_ss_disappearances_fatalities","pf_ss_disappearances_injuries", "pf_ss_women_fgm", "pf_ss_women_inheritance", "pf_religion", "pf_association_sport", "pf_association_political",	"pf_expression_influence",	"pf_expression_internet", "pf_identity_sex", "pf_score", "pf_rank",	"ef_legal_judicial", "ef_legal_military",	"ef_legal_integrity",	"ef_legal_police",	"ef_money_growth",	"ef_trade_tariffs_revenue",	"ef_trade_movement_foreign",	"ef_trade_movement_visit",	"ef_regulation_business_adm",	"ef_regulation_business_bureaucracy",	"ef_regulation_business_start",	"ef_regulation_business_bribes",	"ef_regulation_business_licensing",	"ef_score","ef_rank", "hf_score","hf_rank" ))]

df3<-  df1[, (names(df1) %in% c("year","region","pf_rol",	"pf_ss_homicide","pf_ss_disappearances_fatalities", "pf_ss_women_fgm", "pf_ss_women_inheritance", "pf_religion","pf_association_sport","pf_association_political",	"pf_expression_internet", "pf_identity_sex", "ef_legal_judicial", "ef_legal_military",	"ef_money_growth",	"ef_trade_tariffs_revenue",	"ef_regulation_business_start","ef_regulation_business_bribes"
))]

netgraph <- df3 %>%
  group_by(year,region)


longdata <- gather(netgraph, key="freedom_factors", value="value", c("pf_rol",	"pf_ss_homicide","pf_ss_disappearances_fatalities", "pf_ss_women_fgm", "pf_ss_women_inheritance", "pf_religion","pf_association_sport","pf_association_political",	"pf_expression_internet", "pf_identity_sex", "ef_legal_judicial", "ef_legal_military",	"ef_money_growth",	"ef_trade_tariffs_revenue",	"ef_regulation_business_start","ef_regulation_business_bribes"))

select_ops <- unique(longdata$freedom_factors)

choromap <- df[, (names(df) %in% c("year","ISO_code","countries","region","pf_rol",	"pf_ss_homicide","pf_ss_disappearances_fatalities", "pf_ss_women_fgm", "pf_ss_women_inheritance", "pf_religion","pf_association_sport","pf_association_political",	"pf_expression_internet", "pf_identity_sex", "ef_legal_judicial", "ef_legal_military",	"ef_money_growth",	"ef_trade_tariffs_revenue",	"ef_regulation_business_start","ef_regulation_business_bribes"))]

 choromap <- choromap 
 select_ops2 <- c("Rule of Law"= "pf_rol",
                  "Homicides Reported" = "pf_ss_homicide",
                  "Deaths by Terrorism"="pf_ss_disappearances_fatalities",
                  "Female Mutiliation"= "pf_ss_women_fgm",
                  "Women Inheritance" = "pf_ss_women_inheritance",
                  "Freedom of Religion" = "pf_religion",
                  "Freedom of Sport" =  "pf_association_sport",
                  "Forming political parties" =  "pf_association_political",
                  "Inflecnce of  politics on internet"	= "pf_expression_internet",
                  "Same sex Marriage" =  "pf_identity_sex",
                  "Judicial System"	= "ef_legal_judicial",
                  "Influence of Military in Administration " = "ef_legal_military",
                  "Economic Growth" =  "ef_money_growth",
                  "Revenue by trade"  = "ef_trade_tariffs_revenue",
                  "Business Startups Recorded" =	"ef_regulation_business_start",
                  "Level of Corruption" = "ef_regulation_business_bribes")
 

corplots2016 <- df3%>%filter(year == 2016)
corplots2008 <- df3%>%filter(year == 2008)
corplots2012 <- df3%>%filter(year == 2012)

corplots2008 <- round(cor(corplots2008[,3:ncol(corplots2008)]),1)
corplots2012 <- round(cor(corplots2012[,3:ncol(corplots2012)]),1)
corplots2016 <- round(cor(corplots2016[,3:ncol(corplots2016)]),1)




