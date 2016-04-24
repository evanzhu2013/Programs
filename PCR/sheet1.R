library(ggplot2)
library(reshape2)
library(dplyr)
library(stringr)

ggtheme=theme(
	panel.grid.major = element_blank(),
	panel.grid.minor = element_blank(),
	panel.border= element_blank(),
	panel.background = element_blank(),
	axis.text.x = element_text(angle=45,hjust=1,vjust=1,colour='black',size=14),
	axis.title.y=element_text(size=14,colour='black'),
	axis.text.y=element_text(size=14,colour='black'),
	axis.line=element_line(colour='black',size=0.55)
	)
	

# Input data and clean
sheet1_1 = read.csv('/Users/Evan/DataScience/R-Programming/PCR/csv/sheet1.csv',header=T)[1:14,1:3][-c(5,7),]
sheet1_2 = read.csv('/Users/Evan/DataScience/R-Programming/PCR/csv/sheet1.csv',header=T)[1:14,1:3][c(5,7),]

names(sheet1_1) = c('Fatty_Acid','Control','Treatment')
names(sheet1_2) = c('Fatty_Acid','Control','Treatment')

sheet1_1$control_mean = substr(sheet1_1$Control,1,5)
sheet1_1$Treatment_mean = substr(sheet1_1$Treatment,1,5)
sheet1_1$control_sd = substr(sheet1_1$Control,7,13)
sheet1_1$Treatment_sd = substr(sheet1_1$Treatment,7,13)
sheet1_1 = sheet1_1[,-c(2,3)]

sheet1_2$control_mean = substr(sheet1_2$Control,1,6)
sheet1_2$Treatment_mean = substr(sheet1_2$Treatment,1,6)
sheet1_2$control_sd = substr(sheet1_2$Control,9,14)
sheet1_2$Treatment_sd = substr(sheet1_2$Treatment,9,14)
sheet1_2 = sheet1_2[,-c(2,3)]

dt2 = melt(sheet1_2,id=c('Fatty_Acid','control_sd','Treatment_sd'))
dt2 = melt(dt2,id=c('Fatty_Acid','variable','value'))[-c(3:6),-4]
names(dt2)[2:4] = c('Group','mean','sd')

dt2$mean = as.numeric(dt2$mean)
dt2$sd = as.numeric(dt2$sd)
dt2$num = as.numeric(str_sub(dt2$Fatty_Acid,-5,-4))

dt2 = arrange(dt2,num)

dt2$Group = sub('_mean','',dt2$Group)

dt2$Fatty_Acid=reorder(dt2$Fatty_Acid,dt2$num)

p=ggplot(dt2,aes(x=Fatty_Acid,y=mean,fill=Group))+geom_bar(position = position_dodge(0.9),colour='black',stat="identity",width=0.8)

q=p+theme_light()+ylab('Concentration(mg/kg)')+guides(fill=guide_legend(reverse=FALSE,title=NULL)) + xlab('Fatty Acid')+geom_errorbar(aes(ymin=mean-sd,ymax=mean+sd),position=position_dodge(.9),width=0.2,color='black',size=0.35)+scale_fill_manual(values=c("grey60",'white'),labels=c("Control", "Treatment"))

q+theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),axis.text.x = element_text(angle=45,hjust=1,vjust=1),axis.title.y=element_text(size=10),axis.title.x=element_text(size=10),panel.border=element_blank(),axis.line=element_line(colour='grey',size=0.5))


# Pic 1

dt = melt(sheet1_1,id=c('Fatty_Acid','control_sd','Treatment_sd'))
dt = melt(dt,id=c('Fatty_Acid','variable','value'))[-c(13:36),-4]
names(dt)[2:4] = c('Group','mean','sd')

dt$mean = as.numeric(dt$mean)
dt$sd = as.numeric(dt$sd)
dt$num = as.numeric(str_sub(dt$Fatty_Acid,-5,-4))

dt = arrange(dt,num)

dt$Group = sub('_mean','',dt$Group)

dt$Fatty_Acid=reorder(dt$Fatty_Acid,dt$num)

p=ggplot(dt,aes(x=Fatty_Acid,y=mean,fill=Group))+geom_bar(position = position_dodge(0.9),colour='black',stat="identity",width=0.9)

q=p+theme_light()+ylab('Concentration(mg/kg)')+guides(fill=guide_legend(reverse=FALSE,title=NULL)) + xlab('Fatty Acid')+geom_errorbar(aes(ymin=mean-sd,ymax=mean+sd),position=position_dodge(.9),width=0.2,color='black',size=0.35)+scale_fill_manual(values=c("grey60",'white'),labels=c("Control", "Treatment"))

q+theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),axis.text.x = element_text(angle=45,hjust=1,vjust=1),axis.title.y=element_text(size=10),axis.title.x=element_text(size=10),panel.border=element_blank(),axis.line=element_line(colour='grey',size=0.5))








