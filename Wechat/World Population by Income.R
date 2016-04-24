library(httr)     # getting data
suppressMessages(library(rgdal))    # working with shapefile
suppressMessages(library(dplyr))    # awesome data manipulation
library(readr)   # faster reading of CSV data
library(stringi)  # string manipulation
library(stringr)  # string manipulation
library(tidyr)    # reshaping data
library(grid)     # for 'unit'
library(scales)   # for 'percent'
library(ggplot2)  # plotting
library(ggthemes) # theme_map
 
# this ensures you only download the shapefile once and hides
# errors and warnings. remove `try` and `invisible` to see messages
try(invisible(GET("http://www.pewglobal.org/wp-content/lib/js/world-geo.json",
                  write_disk("world-geo.json"))), silent=TRUE)
 
# use ogrListLayers("world-geo.json") to see file type & 
# layer info to use in the call to readOGR
 
world <- readOGR("world-geo.json", "OGRGeoJSON")
world_wt <- spTransform(world, CRS("+proj=robin"))
world_map <- fortify(world_wt)

world_map %>%
  left_join(data_frame(id=rownames(world@data), name=world@data$name)) %>%
  select(-id) %>%
  rename(id=name) -> world_map



# a good exercise would be to repeat the download code above 
# rather and make repeated calls to an external resource
read_csv("http://www.pewglobal.org/wp-content/themes/pew-global/interactive-global-class.csv") %>%
  mutate_each(funs(str_trim)) %>%
  filter(id != "None") %>%
  mutate_each(funs(as.numeric(.)/100), -name, -id) -> dat
  dat


# 读取数据

dat %>%
  gather(share, value, starts_with("Share"), -name, -id) %>%
  select(-starts_with("Change")) %>%
  mutate(label=factor(stri_trans_totitle(str_match(share, "Share ([[:alpha:]- ]+),")[,2]),
                      c("Poor", "Low Income", "Middle Income", "Upper-Middle Income", "High Income"),
                      ordered=TRUE)) -> share_dat

# use same "cuts" as poynter
poynter_scale_breaks <- c(0, 2.5, 5, 10, 25, 50, 75, 80, 100)
 
sprintf("%2.1f-%s", poynter_scale_breaks, percent(lead(poynter_scale_breaks/100))) %>%
  stri_replace_all_regex(c("^0.0", "-NA%"), c("0", "%"), vectorize_all=FALSE) %>%
  head(-1) -> breaks_labels
 
share_dat %>%
  mutate(`Share %`=cut(value,
                       c(0, 2.5, 5, 10, 25, 50, 75, 80, 100)/100,
                       breaks_labels))-> share_dat
 
share_pal <- c("#eaecd8", "#d6dab3", "#c2c98b", "#949D48", "#6e7537", "#494E24", "#BB792A", "#7C441C", "#ffffff")
  
# 绘制地图

gg <- ggplot()
 
gg <- gg + geom_map(data=world_map, map=world_map,
                    aes(x=long, y=lat, group=group, map_id=id),
                    color="#7f7f7f", fill="white", size=0.15)
 
gg <- gg + geom_map(data=share_dat, map=world_map,
                    aes(map_id=name, fill=`Share %`),
                    color="#7f7f7f", size=0.15)
 
gg <- gg + scale_fill_manual(values=share_pal)
 
gg <- gg + guides(fill=guide_legend(override.aes=list(colour=NA)))
gg <- gg + labs(title="World Population by Incomen")
gg <- gg + facet_wrap(~label, ncol=2)
 
gg <- gg + coord_equal()
 
gg <- gg + theme_map()
 
gg <- gg + theme(panel.margin=unit(1, "lines"))
gg <- gg + theme(plot.title=element_text(face="bold", hjust=0, size=24))
gg <- gg + theme(legend.title=element_text(face="bold", hjust=0, size=12))
gg <- gg + theme(legend.text=element_text(size=10))
gg <- gg + theme(strip.text=element_text(face="bold", size=10))
gg <- gg + theme(strip.background=element_blank())
gg <- gg + theme(legend.position="bottom")
 
gg