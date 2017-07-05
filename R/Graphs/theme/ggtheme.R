ggtheme=theme(
	panel.grid.major = element_blank(),
	panel.grid.minor = element_blank(),
	panel.border= element_blank(),
	panel.background = element_blank(),
	axis.text.x = element_text(angle=45,hjust=1,vjust=1),
	axis.line=element_line(colour='black',size=0.55)
	)

# A clean theme that gets rid of unnecessary gridlines and colored backgrounds.
ggtheme_blank = theme(legend.background = element_blank(), 
                legend.key = element_blank(), 
                panel.grid.minor = element_blank(), 
                panel.grid.major = element_blank(), 
                panel.background = element_blank(), 
                panel.border = element_blank(), 
                strip.background = element_blank(), 
                plot.background = element_blank()
                )




