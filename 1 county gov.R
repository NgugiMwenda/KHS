setwd('C:/Users/Prof/Desktop/kiroria official/Housing and Rent Survey R shinny Dashboard/KRHS_Dashboard_GitHub')

approvalcosts <- read.delim("raw/KHS_County_Government_Quest_1/approvalcosts.tab")
ChangeofUserExtension <- read.delim("raw/KHS_County_Government_Quest_1/ChangeofUserExtension.tab")
ChangeofUserExtensionType <- read.delim("raw/KHS_County_Government_Quest_1/ChangeofUserExtensionType.tab")
completion_certificates <- read.delim("raw/KHS_County_Government_Quest_1/completion_certificates.tab")
KHS_County_Government_Quest <- read.delim("raw/KHS_County_Government_Quest_1/KHS_County_Government_Quest.tab")
Numberapproved <- read.delim("raw/KHS_County_Government_Quest_1/Numberapproved.tab")
Percentage_of_Budget <- read.delim("raw/KHS_County_Government_Quest_1/Percentage_of_Budget.tab")
#View(KHS_County_Government_Quest)

#submisions and dates
#---------------------------------------------------------------------------------------------------------------->Daily interview Submit date County

c_dd1<-KHS_County_Government_Quest %>% select(a1_5a,Date_of_Interview) %>% filter(Date_of_Interview!='##N/A##')
c_dd1$new_date <- as.Date(substr(c_dd1$Date_of_Interview,1,10))
c_dd2<-c_dd1 %>% select(a1_5a,new_date) %>%
  group_by(a1_5a,new_date) %>%
  summarise(n=n()) %>% 
  filter(!is.na(new_date)) %>%
  rename(county=a1_5a)

county <- read.delim("raw/KHS_County_Government_Quest_1/county.txt") %>% rename(county=value)
head(county)
c_dd3<-c_dd2 %>% left_join(county, by="county") %>% 
  ungroup() %>%
  select(title,n,new_date) %>% 
  rename(county=title)
  
c_ps3<-ggplot(c_dd3, aes(x = new_date, y = n, fill = county)) +
  geom_line() +
  geom_point(size = 2, shape = 15)+
  labs(x = "Date of submission", y = "Number of interviews submitted to the server", color = "county") 

#------------------------------------------------------------------------------------------------------------------------>End
#------------------------------------------------------------------------------------------------>request for approvals
table(KHS_County_Government_Quest$CG1a,KHS_County_Government_Quest$a1_5a)#request 2021
table(KHS_County_Government_Quest$CG1b,KHS_County_Government_Quest$a1_5a)#request 2022
table(KHS_County_Government_Quest$CG4a,KHS_County_Government_Quest$a1_5a)#aproved 2021
table(KHS_County_Government_Quest$CG4b,KHS_County_Government_Quest$a1_5a)#approved 2022
#----------------------------------------------------------------------------------------2020
c_r1<-KHS_County_Government_Quest %>% 
  filter(a1_5a!=-999999999) %>%
  filter(CG1a!=-999999999) %>%
  group_by(a1_5a,CG1a) %>%
  summarise(n=n()) %>%
  rename(request2021=CG1a)
c_r11<-c_r1 %>% group_by(a1_5a)%>%
  summarise(med_req_2021=median(request2021))
head(c_r11)

c_a1<-KHS_County_Government_Quest %>% 
  filter(a1_5a!=-999999999) %>%
  filter(CG4a!=-999999999) %>%
  group_by(a1_5a,CG4a) %>%
  summarise(n=n()) %>%
  rename(approved2021=CG4a)
c_a11<-c_a1 %>% group_by(a1_5a)%>%
  summarise(med_app_2021=median(approved2021))
head(c_a11)

ra21<-full_join(c_r11,c_a11)
#---------------------------------------------------------------------------------------2021
c_r2<-KHS_County_Government_Quest %>% 
  filter(a1_5a!=-999999999) %>%
  filter(CG1b!=-999999999) %>%
  group_by(a1_5a,CG1b) %>%
  summarise(n=n()) %>%
  rename(request2022=CG1b)
c_r12<-c_r2 %>% group_by(a1_5a)%>%
  summarise(med_req_2022=median(request2022))
head(c_r12)

c_a2<-KHS_County_Government_Quest %>% 
  filter(a1_5a!=-999999999) %>%
  filter(CG4b!=-999999999) %>%
  group_by(a1_5a,CG4b) %>%
  summarise(n=n()) %>%
  rename(approved2022=CG4b)
c_a12<-c_a2 %>% group_by(a1_5a)%>%
  summarise(med_app_2022=median(approved2022))
head(c_a12)

ra22<-full_join(c_r12,c_a12)
#full dataset for request and approval
ra_al<-full_join(ra21,ra22) %>%
  rename(county=a1_5a) %>% 
  left_join(county, by='county') 

fig_ra <- plot_ly(ra_al, x = ~title, y = ~med_req_2021, type = 'bar', name = 'Building Approvals Requested 2021', marker = list(color = 'rgb(49,130,189)'))
fig_ra <- fig_ra %>% add_trace(y = ~med_app_2021, name = 'Building Approvals granted 2021', marker = list(color = 'rgb(204,204,204)'))
fig_ra <- fig_ra %>% add_trace(y = ~med_req_2022, name = 'Building Approvals Requested 2022', marker = list(color = 'rgb(255,255,153)'))
fig_ra <- fig_ra %>% add_trace(y = ~med_app_2022, name = 'Building Approvals granted 2022', marker = list(color = 'rgb(214,20,294)'))
fig_ra <- fig_ra %>% layout(xaxis = list(title = "County", tickangle = -45),
                      yaxis = list(title = "Number of request"),
                      margin = list(b = 100),
                      barmode = 'group')

#average time to get approval
table(KHS_County_Government_Quest$a1_5a,KHS_County_Government_Quest$CG3)
at<-KHS_County_Government_Quest %>% select(a1_5a,CG3)%>% 
  filter(a1_5a!=-999999999) %>%
  filter(CG3!=-999999999)
at_1<-at %>% group_by(a1_5a)%>%
  summarise(med_app_time=median(CG3), mean_app_time=mean(CG3)) %>%
  rename(county=a1_5a) %>% 
  left_join(county, by='county')
fig_ta <- plot_ly(at_1, x = ~title, y = ~med_app_time, type = 'bar', name = 'Median days approval time', marker = list(color = 'rgb(255,110,189)'))
fig_ta <- fig_ta %>% add_trace(y = ~mean_app_time, name = 'Mean days approval time', marker = list(color = 'rgb(204,204,204)'))
fig_ta <- fig_ta %>% layout(xaxis = list(title = "County", tickangle = -45),
                            yaxis = list(title = "Number of days"),
                            margin = list(b = 100),
                            barmode = 'group')
table(KHS_County_Government_Quest$CG2__1)
table(KHS_County_Government_Quest$CG2__2)
