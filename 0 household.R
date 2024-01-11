setwd('C:/Users/Prof/Desktop/kiroria official/Housing and Rent Survey R shinny Dashboard/KRHS_Dashboard_GitHub')

#load allocated sample households with the supervisors, and coverage so far
Pilot_Sample <- read.delim("uploaded sample to server/Pilot_Sample.txt")
alias_with_sup_name <- read.delim("uploaded sample to server/alias_with_sup_name.txt")
sample_with_names<-full_join(Pilot_Sample, alias_with_sup_name)  
#unique to use in the whole dataset
sh<-sample_with_names%>% select(A01,A08,A09,A10,Supervisor.Name)
#head(sh)
#sh1<-sh %>%  rename( County=A01,  'Cluster number'=A08, 'Structure number'=A09, 'Housing unit number'=A10)

#read data in the server
KHS202324 <- read.delim("raw/KHS202324_6/KHS202324.tab")
#View(KHS202324)
#----------------------------------------------------------------------------------------------------------------------->completed,allocated,Incompleted
#completed households
household_completed<-KHS202324 %>% group_by(A01) %>% summarise('Completed households'=n())
#View(household_completed)
#allocated sample
household_allocated<-Pilot_Sample %>%group_by(A01) %>% summarise('Allocated households'=n())
#View(household_allocated)
#merge allocated vs completed
aloc_comp<-full_join(household_allocated,household_completed) %>%
  rename(County=A01)
aloc_comp[is.na(aloc_comp)]<-0  ##replace NA with zero
aloc_comp$'Incompleted households'<-aloc_comp$`Allocated households`- aloc_comp$`Completed households`
#head(aloc_comp)
aloc_comp$`Completed households`
#View(aloc_comp)
ps1<-plot_ly(aloc_comp, x = ~County, y = ~`Completed households`, type = 'bar', name = 'Completed households')%>% 
    add_trace(y = ~`Incompleted households`, name = 'Incomplete households')%>% 
    add_trace(y = ~ `Allocated households`, name = 'Allocated households')%>% 
    layout(yaxis = list(title = 'Count'), barmode = 'group')%>%
    layout(title = "Allocated, Completed and Incomplete households",
           xaxis = list(title = "County"), yaxis = list(title = "Number of households"))
#---------------------------------------------------------------------------------------------------------------------------->END
vs<-KHS202324 %>% group_by(a11) %>% summarise(ins=n())
vs$intervStatus<-ifelse(vs$a11==1, "Household found",
                        ifelse(vs$a11==2,"No household member at home",
                               ifelse(vs$a11==3,"Entire household absent ",
                                      ifelse(vs$a11==4,"Postponed",
                                             ifelse(vs$a11==5,"Refused",
                                                    ifelse(vs$a11==6,"Dwelling vacant ",
                                                           ifelse(vs$a11==7,"Dwelling destroyed",
                                                                  ifelse(vs$a11==8,"Dwelling not found",
                                                                         ifelse(vs$a11==8,"Dwelling no longer household",
                                                                                "RA did not answer")))))))))

ps2<-plotly::plot_ly(vs)%>%
  add_pie(vs,labels=~factor(intervStatus),values=~ins,
          textinfo="label+percent",type='pie',hole=0.3)%>%
  layout(title="Household visit status")
##--------------------------------------------------------------------------------------------------------visit status by county
ks1<-KHS202324 %>% 
  select(A01,a11) %>%
  group_by(A01,a11) %>%
  summarise(n=n())
ks1$interks1tatus<-ifelse(ks1$a11==1, "Household found",
                          ifelse(ks1$a11==2,"No household member at home",
                                 ifelse(ks1$a11==3,"Entire household absent ",
                                        ifelse(ks1$a11==4,"Postponed",
                                               ifelse(ks1$a11==5,"Refused",
                                                      ifelse(ks1$a11==6,"Dwelling vacant ",
                                                             ifelse(ks1$a11==7,"Dwelling destroyed",
                                                                    ifelse(ks1$a11==8,"Dwelling not found",
                                                                           ifelse(ks1$a11==8,"Dwelling no longer household",
                                                                                  "RA did not answer")))))))))
ks2<-ks1 %>% 
  select(A01,n,interks1tatus)
ks2_1<-ks2 %>% group_by(A01) %>% summarise('Total Interviews Completed'=sum(n))
ks3<-full_join(ks2,ks2_1) %>%
  mutate('% of Total Interviews'=round(n/`Total Interviews Completed`*100,1)) %>%
  rename(County=A01, 'Household visit status'=interks1tatus, 'Number of interviews'=n)%>%
  select(County,`Total Interviews Completed`, `Household visit status`,`Number of interviews`,`% of Total Interviews`)


#--------------------------------------------------------------------------------------------------------------------->GPS households
#read the gps data
gps.pick1<-KHS202324 %>% 
  filter(Gps1__Latitude!=-999999999)%>%
  select(Gps1__Longitude,Gps1__Latitude)%>% 
  rename(longitude=Gps1__Longitude, latitude=Gps1__Latitude)
gps.pick2<- st_as_sf(gps.pick1, coords = c("longitude", "latitude"), crs = 4326)

#load the shapefiles by regions
kenya.polys <- st_read("shapefiles/county/Counties_for_pilot.shp")
kenya.polys2 <- st_read("shapefiles/EA/Updated_EAs.shp")
#----------------------------------------------------------------------------------------------------------------------->END

#---------------------------------------------------------------------------------------------------------------->Daily interview Submit date 
dd1<-KHS202324 %>% select(A01,b_date) %>% filter(b_date!='##N/A##')
dd1$new_date <- as.Date(substr(dd1$b_date,1,10))
dd2<-dd1 %>% select(A01, new_date) %>%
  group_by(A01, new_date) %>%
  summarise(n=n()) %>% 
  filter(!is.na(new_date)) %>%
  rename(County=A01)

ps3<-ggplot(dd2, aes(x = new_date, y = n, fill = County)) +
  geom_line() +
  geom_point(size = 4, shape = 21)+
  labs(x = "Date of submission", y = "Number of interviews submitted to the server", color = "County") 
#------------------------------------------------------------------------------------------------------------------------>End
#
#View(KHS202324)
#-------------------------------------------------------------------------------------------------------------------->Errors start here
#Missing household visit status
mvs<-KHS202324 %>% select(interview__id,A01, A08,A09,A10,a11) %>%
  filter(a11==-999999999)%>%
  rename('Missing house visit status(a11)'=a11)


#missing source of water
msw<-KHS202324 %>% select(interview__id,A01, A08,A09,A10,C01_1) %>%
  filter(C01_1==-999999999) %>%
  rename('Missing source of water (C01_1)'=C01_1)
#missing
hhid <- read.delim("raw/KHS202324_6/hhid.tab")
#missing relationship status to the head
m_rs<-hhid %>% select(interview__id,b02, b03) %>%
  filter(b03==-999999999) %>%
  rename('member name'=b02, 'relationship to the head'=b03)

m_ag<-hhid %>% select(interview__id,b02, b05_years) %>%
  filter(b05_years==-999999999) %>%
  rename('member name'=b02, 'Age in Years'=b05_years)

m_yb<-hhid %>% select(interview__id,b02, b05_yrofbirth) %>%
  filter(b05_yrofbirth==-999999999) %>%
  rename('member name'=b02, 'Year of birth'=b05_yrofbirth)

m1<-full_join(m_rs,m_ag)
m2<-full_join(m1, m_yb)
#View
#head(m3)
sh<-sample_with_names%>% select(A01,A08,A09,A10,Supervisor.Name)
#head(sh)
m3<-m2 %>% left_join(KHS202324) %>% 
  select(interview__id,A01, A08,A09,A10, 'member name', 'relationship to the head', 'Age in Years', 'Year of birth')
m4<-m3 %>% left_join(sh, by=c("A01", "A08","A09","A10"))%>%
  rename( County=A01,  'Cluster number'=A08, 'Structure number'=A09, 'Housing unit number'=A10)
#View(m4)
#

ma<-full_join(mvs,msw)

sh<-sample_with_names%>% select(A01,A08,A09,A10,Supervisor.Name)
#head(sh)
ern<-full_join(ma,sh)%>%
  rename( County=A01,  'Cluster number'=A08, 'Structure number'=A09, 'Housing unit number'=A10) %>%
  filter(!is.na(interview__id))

#-------------------------------------------------------------------------------------------------------------------------------------Errors section C
ersc<-KHS202324 %>% filter(C01_1==-999999999|C01_2==-999999999|C01_3==-999999999|C01_4==-999999999| C02_1==-999999999|
                             C02_2==-999999999| C02_3==-999999999|C02_4==-999999999|C02_5==-999999999|
                             C03==-999999999|C04==-999999999|C05==-999999999|C06==-999999999|
                             C07==-999999999|C10==-999999999|C11==-999999999|C12==-999999999|
                             C14_1==-999999999|C14_2==-999999999|C14_2==-999999999 ) %>% 
  select(A01,A08,A09,A10, C01_1,C01_2,C01_3,   C01_4, C02_1,  C02_2, C02_3,  C02_4,  C02_5,  C03,
         C04,  C05,  C06,  C07,  C10,  C11,  C12,  C14_1,  C14_2,C14_2)
ersc<-ersc %>% left_join(sh)%>%
  rename( County=A01,  'Cluster number'=A08, 'Structure number'=A09, 'Housing unit number'=A10,)

#--------------------------------------------------------------------------------------------------------------------------------------->END




#load the users and assignments
PreloadPretest_attached <- read.csv("uploaded sample to server/PreloadPretest_attached.csv")
#View(PreloadPretest_attached)
d1<-PreloadPretest_attached %>% 
  group_by(A08,A09,A10,X_responsible) %>%
  summarise(n=n())  # all are unique
d2<-d1 %>% 
  select(A08,A09,A10,X_responsible) %>% 
  rename(sup=X_responsible)


Housing.Survey.pilot_users <- read.csv("uploaded sample to server/Housing Survey pilot_users.csv")
s1<-Housing.Survey.pilot_users %>% filter(role=='supervisor')%>% 
  select(fullname, login) %>% 
  rename(sup= login)
#head(s1)
name_sup_int<-full_join(d2,s1) %>%filter(!is.na(A08))

KRHS <- read.delim("raw/KHS202324_6/KHS202324.tab")
#C:\Users\Prof\Desktop\kiroria official\Housing and Rent Survey R shinny Dashboard\KRHS_Dashboard\raw\KHS202324_6

Land_Parcels <- read.delim("raw/KHS202324_6/Land_Parcels.tab")

#--------------------------------------------------------------------------------------->Household Visit Status
df1_with_sup_name<-KRHS %>% left_join(name_sup_int, by=c("A08","A09", "A10"))

#View(df1_with_sup_name)
#table(df1_with_sup_name$C01_2)
#table(df1_with_sup_name$C01_3)

##-------------------------------------------------------------------->try
v1<-df1_with_sup_name %>% 
  filter(a11==1) %>%
  group_by(a11,fullname) %>%
  summarise("household found"=n()) %>%
  as.data.frame()
v1_1<-v1 %>%select(fullname,`household found`)
v2<-df1_with_sup_name %>% 
  filter(a11!=1) %>%
  group_by(a11,fullname) %>%
  summarise("Household not found"=n()) %>%
  as.data.frame()
v2_1<-v2 %>%select(fullname,`Household not found`)
v_1_2<-full_join(v1_1,v2_1)
v_1_3<-v_1_2  %>% replace(is.na(.), 0)
fig_hvs <- plot_ly(v_1_3, x = ~fullname, y = ~`household found`, type = 'bar', name = '`household found`')
fig_hvs <- fig_hvs %>% add_trace(y = ~`Household not found`, name = '`Household not found`')
fig_hvs <- fig_hvs %>% layout(yaxis = list(title = 'Count'), barmode = 'stack')
#---------------------------------------------------------------------------------------------------------->summary by county Visit status
sum_bc<-KRHS %>% select(A01,a11)%>%
  group_by(A01,a11)%>%
  summarise("house visit status"=n())
#head(sum_bc)
#---------------------------------------------------------------------------------------------------------> Process errors

#house visits missing a status
hmvs<-df1_with_sup_name %>% 
  filter(a11==-999999999) %>%
  select(A01,A07,A08,A09,A10,a11,fullname)

hmvs_d<-hmvs %>% rename(County=A01, "Cluster Name"=A07, "Cluster number"=A08, "Structure Number"=A09,
                        "Housing Unit number"=A10,"Housing Visit Status"=a11 ,"Name of the supervisor"=fullname)

hmvs2<-hmvs %>% select(A01,A07,A08,fullname)
#hmvs2$error<-'missing housing visit status'

hmin<-df1_with_sup_name %>% 
  filter(a11==-999999999) %>%
  select(A01,A07,A08,A09,A10,interviewer,fullname)

hmin_d<-hmin %>% rename(County=A01, "Cluster Name"=A07, "Cluster number"=A08, "Structure Number"=A09,
                        "Housing Unit number"=A10,"Interviewer Name"=interviewer,"Name of the supervisor"=fullname)

hmin2<-hmin %>% select(A01,A07,A08,fullname)
#hmin2$error<-'missing interviewer name'


all_errors<-rbind(hmvs2,hmin2)
#head(all_errors)
#read the sample of households from the samplers and add the pretest cluster
clusters <- read.csv("alocated_clusters/clusters.csv")
clusters<-clusters%>% select(supervisors_name)%>% 
  group_by(supervisors_name) %>% summarise(allocated_cluster=n())
#------------------------------------------------------------------->introduce a date
date_1<-as.Date("2023-11-24") 
date_today<-Sys.Date()
clusters$date_today<-date_today
clusters$date_start<-date_1
clusterstotal_days_for_survey<-90
clusters$days_so_far<-clusters$date_today-clusters$date_start
clusters$completed<-1
clusters$undone<-clusters$allocated_cluster-clusters$completed
##fix the completed by reading the data in the server

#------------------------------------------------------------------->date ends

#------------------------------------------------------------------------------------>households starts here
#read allocated households and add pretest households
households <- read.csv("alocated_clusters/households.csv")
household_per_clu_allocated<-households %>% group_by(CLUSTER_NUMBER) %>% summarise(number_hh=n())


household_per_clu_allocated$interviewed<-15

#processing Errors
#cluster allocated by the sup alias gives us all information needed
#we process errors by the supervisor since he/she has freedom of allocation of the clusters
#its upto him to know the RA

#



