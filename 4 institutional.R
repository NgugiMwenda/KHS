library(dplyr)
library(haven)
library(plotly)

setwd('C:/Users/Prof/Desktop/kiroria official/Housing and Rent Survey R shinny Dashboard/KRHS_Dashboard_GitHub')
#Building_Developments <- read.delim("raw/KhsInstitutional_3/Building_Developments.tab")


c3_2 <- read_stata("raw/KhsInstitutional_3/c3_2.dta") 
k<-c3_2%>% select(c3_2a, c3_3a)
#head(k)

b_k<- c3_2 |>dplyr::mutate(c3_2a = haven::as_factor(c3_2a),c3_3a = haven::as_factor(c3_3a)) |>
  dplyr::select(c3_2a ,c3_3a) |>
  dplyr::filter(!is.na(c3_2a)) |>
  dplyr::group_by(c3_2a ,c3_3a) |>
  dplyr::summarise(n=n())
# View(b_k)



Building_Developments <- read_stata("raw/KhsInstitutional_3/Building_Developments.dta")
#View(Building_Developments)
#buble plots cost
b_k1<-Building_Developments |> dplyr::select(interview__id,b2_20a,b2_20e)|>
  filter(b2_20a>0 & b2_20e) |> 
  group_by(interview__id)|>
  summarise(n2018=sum(b2_20a/10000, na.rm = TRUE),n2022=sum(b2_20e/10000, na.rm = TRUE))
b_k1$Gap<-b_k1$n2022-b_k1$n2018
b_k1 <-b_k1 %>% filter(Gap>0)
#head(b_k1)

c3_2 <- read_dta("raw/KhsInstitutional_3/c3_2.dta")
type_house<-c3_2 |> dplyr::select(interview__id,c3_1b__1,c3_1b__2,c3_1b__3,c3_1b__4,c3_1b__5,c3_1b__6) |>
#dplyr::mutate(c3_1b__1=haven::as_factor(c3_1b__1))|>
  dplyr::group_by(interview__id) |>
  summarise(bung=sum(c3_1b__1, na.rm = TRUE),
            apart=sum(c3_1b__2, na.rm = TRUE),
            mansion=sum(c3_1b__3, na.rm = TRUE),
            swahili=sum(c3_1b__4, na.rm = TRUE),
            townhous=sum(c3_1b__5, na.rm = TRUE),
            ownComp=sum(c3_1b__6, na.rm = TRUE))
#View(type_house)
bung<-sum(type_house$bung)
apart<-sum(type_house$apart)
mansion<-sum(type_house$mansion)
swahili<-sum(type_house$swahili)
townhous<-sum(type_house$townhous)
ownComp<-sum(type_house$ownComp)
th1<-c("Bungalow","Apartment","Mansionate","Swahili","Town house","Own Compound")
th2<-c(bung,apart,mansion,swahili,townhous,ownComp)
l<-data.frame(th1,th2)
fig_th <- plot_ly(l, x = ~th1, y = ~th2, type = 'bar', name = 'House types', marker = list(color = 'rgb(128,0,1)'))
fig_th<-fig_th %>% layout(xaxis = list(title = "Type of structure", tickangle = -45),
                       yaxis = list(title = "Number constructed"),
                       margin = list(b = 100),
                       barmode = 'group')

#------------------------------------------------------------------------------End Types of houses
#----------------------------------------commmercial property
pp <- read.delim("C:/Users/Prof/Desktop/kiroria official/Housing and Rent Survey R shinny Dashboard/KRHS_Dashboard/raw/KhsInstitutional_3/propertprice.txt")
#head(pp)

pih<-plot_ly(pp, x = ~County, y = ~Price, type = 'bar', color = ~TypeHouse)
pih<-pih%>% layout(xaxis = list(title = "County", tickangle = -45),
           yaxis = list(title = "Price in '(Millions)"),
           margin = list(b = 100),
           barmode = 'group')


#-------------------------------------------------end advertised sale

hf1_in<- plot_ly() 
hf1_in <- hf1_in %>%
  add_trace(
    type = "funnel",
     marker = list(color = 'rgb(0,128,1)'),
    y = c("Mansionnate", "Bungalow", "Flats", "Bedsitter", "Own compound"),
    x = c(39, 27.4, 20.6, 11, 2)) 
hf1_in <- hf1_in %>%
  layout(yaxis = list(categoryarray = c("Mansionnate", "Bungalow", "Flats", "Bedsitter", "Own compound")))


