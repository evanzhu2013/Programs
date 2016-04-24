
# 利用Nobel Prize API 接口,分析诺贝奖获奖人特征

setwd('/Users/Evan/DataScience/R-Programming/')

library(ggplot2)
library(jsonlite)
library(plyr)
library(dplyr)
library(networkD3)
library(xtable)

u <-  "http://api.nobelprize.org/v1/laureate.json"
nobel <- fromJSON(u) # 将JSON格式数据变成R语言对象

# 查看数据
names(nobel)
names(nobel$laureates)
names(nobel$laureates$prizes[[1]])

multi <- which(sapply(nobel$laureates$prizes, function(x) nrow(x)) > 1)
winners <- nobel$laureates[multi, c("firstname", "surname", "born", "bornCountry")]
print(xtable(winners), type = "html", comment = FALSE, include.rownames = FALSE)

gender <- as.data.frame(table(nobel$laureates$gender), stringsAsFactors = FALSE)
ggplot(gender) + geom_bar(aes(Var1, Freq), stat = "identity", fill = "skyblue3") +
    theme_bw() + labs(x = "gender", y = "count", title = "All Nobel Prizes by Gender")

cnt <- sapply(nobel$laureates$prizes, function(x) nrow(x))

prizes <- ldply(nobel$laureates$prizes, as.data.frame)

prizes$id <- rep(nobel$laureates$id, cnt)
prizes$gender <- rep(nobel$laureates$gender, cnt)
pg <- as.data.frame(table(prizes$category, prizes$gender), stringsAsFactors = FALSE)
ggplot(pg) + geom_bar(aes(Var1, Freq), stat = "identity", fill = "skyblue3") +
    theme_bw() + facet_grid(Var2 ~ .) + labs(x = "category", y = "count", title = "All Nobel Prizes by Gender and Category")

p5 <- as.data.frame(table(prizes$year, prizes$gender), stringsAsFactors = FALSE)
colnames(p5) <- c("year", "gender", "Freq")
p5.1 <- mutate(group_by(p5, gender), cumsum = cumsum(Freq))
ggplot(subset(p5.1, gender != "org")) + geom_point(aes(year, log(cumsum), color = gender)) +
    theme_bw() + scale_x_discrete(breaks = seq(1900, 2015, 10)) + scale_color_manual(values = c("darkorange",
    "skyblue3")) + labs(x = "year", y = "log(cumulative sum) of laureates",
    title = "Cumulative Sum of Nobel Laureates by Gender over Time")


p6 <- as.data.frame(table(prizes$year, prizes$category, prizes$gender), stringsAsFactors = FALSE)
colnames(p6) <- c("year", "category", "gender", "Freq")
p6.1 <- mutate(group_by(p6, category, gender), cumsum = cumsum(Freq))
ggplot(subset(p6.1, gender != "org")) + geom_point(aes(year, log(cumsum), color = gender)) +
    facet_grid(category ~ .) + theme_bw() + scale_x_discrete(breaks = seq(1900,
    2015, 10)) + scale_color_manual(values = c("darkorange", "skyblue3")) +
    labs(x = "year", y = "log(cumulative sum) of laureates", title = "Cumulative Sum of Nobel Laureates by Gender and Category over Time")

share <- as.data.frame(table(prizes$year, prizes$category), stringsAsFactors = FALSE)
colnames(share) <- c("year", "category", "Freq")
share1 <- as.data.frame(table(share$Freq), stringsAsFactors = FALSE)
ggplot(share1[share1$Var1 != 0, ]) + geom_bar(aes(Var1, Freq), stat = "identity",
    fill = "skyblue3") + theme_bw() + labs(x = "number of laureates", y = "count",
    title = "Laureates per Nobel Prize")

share2 <- as.data.frame(table(share$category, share$Freq), stringsAsFactors = FALSE)
colnames(share2) <- c("category", "share", "Freq")
ggplot(subset(share2, share > 0)) + geom_bar(aes(category, Freq), stat = "identity",
    fill = "skyblue3") + theme_bw() + facet_grid(share ~ .) + labs(x = "category",
    y = "count", title = "Laureates per Nobel Prize by Category")

prizes$born <- rep(nobel$laureates$born, cnt)
prizes$age <- as.Date(paste(prizes$year, "12-31", sep = "-"), "%Y-%m-%d") - as.Date(prizes$born, "%Y-%m-%d")
ggplot(prizes[!is.na(prizes$category), ]) + geom_violin(aes(category, as.numeric(age) / 365), fill = "skyblue3") + theme_bw() + stat_summary(aes(category, as.numeric(age) / 365), fun.y = "median", geom = "point") + labs(x = "category", y = "age (years)", title = "Age Distribution of Nobel Laureates by Category")

ggplot(prizes[!is.na(prizes$category), ]) + geom_point(aes(year, as.numeric(age)/365)) +
    theme_bw() + geom_smooth(aes(year, as.numeric(age)/365, group = 1)) + facet_wrap(~category) +
    scale_x_discrete(breaks = seq(1900, 2015, 25)) + labs(x = "year", y = "age(years) at end of year",
    title = "Age of Nobel Laureates Over Time by Category")

# data(iso3166)
prizes$country <- rep(nobel$laureates$bornCountryCode, cnt)
p3 <- as.data.frame(table(prizes$category, prizes$country), stringsAsFactors = FALSE)
ggplot(p3) + geom_bar(aes(Var2, Freq, fill = Var1), stat = "identity", position = "stack") +
    theme_bw() + theme(axis.text.x = element_text(angle = 90, size = rel(0.82))) +
    labs(x = "country code", y = "count", title = "All Nobel Prizes by Country and Category") +
    scale_fill_manual(values = c("#ffffcc", "#c7e9b4", "#7fcdbb", "#41b6c4",
        "#2c7fb8", "#253494"), name = "category")

country <- as.data.frame(table(nobel$laureates$bornCountryCode, nobel$laureates$diedCountryCode),
    stringsAsFactors = FALSE)
c1 <- subset(country, Freq > 0 & Var1 != Var2)
c2 <- data.frame(nodes = unique(c(nobel$laureates$bornCountryCode, nobel$laureates$diedCountryCode)))
c2 <- na.omit(c2)

m1 <- match(c1$Var1, c2$nodes)
m2 <- match(c1$Var2, c2$nodes)
c1$Var1 <- m1 - 1
c1$Var2 <- m2 - 1
sn <- sankeyNetwork(Links = c1, Nodes = c2, Source = "Var1", Target = "Var2",
    Value = "Freq", fontSize = 12, nodeWidth = 30)

country <- as.data.frame(table(nobel$laureates$bornCountryCode, nobel$laureates$diedCountryCode),
    stringsAsFactors = FALSE)
c1 <- subset(country, Freq > 0 & Var1 != Var2)
c2 <- data.frame(nodes = unique(c(nobel$laureates$bornCountryCode, nobel$laureates$diedCountryCode)))
c2 <- na.omit(c2)

m1 <- match(c1$Var1, c2$nodes)
m2 <- match(c1$Var2, c2$nodes)
c1$Var1 <- m1 - 1
c1$Var2 <- m2 - 1
sn <- sankeyNetwork(Links = c1, Nodes = c2, Source = "Var1", Target = "Var2",
    Value = "Freq", fontSize = 12, nodeWidth = 30)
sn
