library(xlsx)
library(reshape2)
evan$variable <- as.numeric(sub('m','',evan$variable))
evan <- na.omit(evan)
evan$date <- paste(evan$year,death$variable,'15',sep='-')
evan$dat <- as.Date(evan$date)

ggtheme = theme(legend.background = element_blank(), 
                legend.key = element_blank(), 
                panel.grid.minor = element_blank(), 
                panel.grid.major = element_blank(), 
                panel.background = element_blank(), 
                panel.border = element_blank(), 
                strip.background = element_blank(), 
                plot.background = element_blank())

p <- ggplot(evan,aes(dat,value))+geom_line()+geom_point(shape=1,colour='violet')
datebreaks <- seq(as.Date('1998-01-15'),as.Date('2005-06-15'),by='6 month')
p+scale_x_date(breaks=datebreaks,labels=date_format('%Y %b'))+xlab('Date')+ylab('Mortality Rate')+ggtitle('Mortality Rate from 1998 to 2005 in Chengdu')+theme_classic()+theme(axis.text.x=element_text(angle = 30,hjust = 1))



ggtheme = theme(legend.background = element_blank(), 
evan$variable <- as.numeric(sub('m','',death$variable))
ggtheme = theme(legend.background = element_blank(), 
evan <- na.omit(evan)
death$date <- paste(death$year,death$variable,'15',sep='-')
death$date <- paste(death$year,death$variable,'15',sep='-')
death$date <- paste(death$year,death$variable,'15',sep='-')
death$date <- paste(death$year,death$variable,'15',sep='-')
death$dat <- as.Date(death$date)

ggtheme = theme(legend.background = element_blank(), 
ggtheme = theme(legend.background = element_blank(), 
                legend.key = element_blank(), 
                panel.grid.minor = element_blank(), 
                panel.grid.major = element_blank(), 
                panel.background = element_blank(), 
                panel.border = element_blank(), 

p <- ggplot(death,aes(dat,value))+geom_line()+geom_point(shape=1,colour='violet')
datebreaks <- seq(as.Date('1998-01-15'),as.Date('2005-06-15'),by='6 month')
hours=datebreaks,labels=date_format('%Y %b'))+xlab('Date')+ylab('Mortality Rate')+ggtitle('Mortality Rate from 1998 to 2005 in Chengdu')+theme_classic()+theme(axis.text.x=element_text(angle = 30,hjust = 1))



