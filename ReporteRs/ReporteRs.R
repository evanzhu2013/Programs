
# Title: ReporteRs exmaple
# Date Created : 2016年5月22日

# Exmaple 1

library(boot)
library(dplyr)
library(ReporteRs)

data(melanoma)

melanoma$Status = c( 'Melanoma', 'Alive' , 'Non-melanoma' )[melanoma$status]
melanoma$Gender = ifelse( melanoma$sex > 0, 'Male', 'Female' )
melanoma$Ulceration = ifelse( melanoma$ulcer > 0, 'Present', 'Absent' )

data = melanoma %>% group_by(Status, Gender, Ulceration ) %>% summarize(n = n(),Mean = round(mean(thickness, na.rm = T), 3 ),SD = round( sd( thickness, na.rm = T ), 3))

melanoma
a <- group_by(melanoma,Status,Gender,Ulceration)
summarize(a, n = n(),Mean = round(mean(thickness, na.rm = T), 3 ),SD = round(sd(thickness, na.rm = T),3))

data = as.data.frame(data)

mydoc <- docx()

data %>% vanilla.table %>% setZebraStyle(., odd = '#eeeeee', even = 'white' ) %>% addFlexTable(mydoc,.) %>% writeDoc(.,'~/Desktop/mydoc.docx')


# Example 2

library(boot)
library(dplyr)
library(ReporteRs)

data(melanoma)

melanoma$Status = c('Melanoma','Alive','Non-melanoma')[melanoma$status]
melanoma$Gender = ifelse(melanoma$sex > 0, 'Male', 'Female')
melanoma$Ulceration = ifelse(melanoma$ulcer > 0, 'Present', 'Absent')

data = melanoma %>% group_by(Status,Gender,Ulceration) %>% summarize(n = n(),Mean = round(mean(thickness, na.rm = T), 3),SD =round(sd(thickness, na.rm = T),3))

data = as.data.frame(data)

# create a FlexTable
# do not print header column names
MyFTable = FlexTable(data = data[ , c("Status","Gender","Ulceration","n", "Mean")],header.columns = FALSE)

# span rows of columns Status and Gender
MyFTable = spanFlexTableRows(MyFTable, j = "Status", runs = as.character( data$Status))
MyFTable = spanFlexTableRows(MyFTable, j = "Gender", runs = as.character( data$Gender))

# add "(sd)" to column 5
MyFTable[, "Mean"] = paste0(" (&plusmn;", formatC(data$SD, digits=3, format = "f"), ")")

#create a first header row
MyFTable = addHeaderRow(MyFTable,
  value = c("", "Summary statistics for thickness"), colspan = c( 3, 2 ))

#create a second header row with names
MyFTable = addHeaderRow(MyFTable, value = c("Status"
  , "Gender", "Ulceration", "Count", "Mean (&plusmn; sd)"))

#create a footer row
MyFTable = addFooterRow(MyFTable, value = c("* This is a footer note"), colspan = 5)
MyFTable[2,5, to="header"] = pot("*", textProperties(vertical.align = "superscript"))

# border properties to use later
no_border = borderProperties(width = 0)
big_border = borderProperties(width = 2)
std_border = borderProperties(width = 1)
another_border = borderProperties(width = 2, color = "red", style = "dashed")

# format the table grid borders
MyFTable = setFlexTableBorders(MyFTable, footer = TRUE,
  inner.vertical = no_border, inner.horizontal = std_border,
  outer.vertical = no_border, outer.horizontal = big_border)

MyFTable[2,1:3, to="header", side = "top"] = no_border
MyFTable

# Example 3

data(mtcars)
mtcars$cyl = as.factor(mtcars$cyl)
data = summary(lm(mpg ~ wt + cyl, data=mtcars))$coefficients

data = as.data.frame(data)

# get signif codes
signif.codes = cut(data[,4],breaks = c(-Inf, 0.001, 0.01, 0.05, Inf),labels= c("***", "**", "*", "" ))

# format the data values
data[, 1] = formatC(data[, 1], digits=3, format = "f")
data[, 2] = formatC(data[, 2], digits=3, format = "f")
data[, 3] = formatC(data[, 3], digits=3, format = "f")
data[, 4] = ifelse(data[, 4] < 0.001, "&lt; 0.001", formatC(data[, 4], digits=5, format = "f"))
# add signif codes to data
data$Signif = signif.codes

# create an empty FlexTable
coef_ft = FlexTable(data = data, add.rownames=TRUE
  , body.par.props = parRight(), header.text.props = textBold()
  , header.columns = T
)

# center the first column and set text as bold italic

coef_ft[,1] = parCenter()
coef_ft[,1] = textBoldItalic()

# define borders

coef_ft = setFlexTableBorders(coef_ft
  ,inner.vertical = borderNone(),inner.horizontal = borderDotted()
  ,outer.vertical = borderNone(),outer.horizontal = borderSolid()
)

coef_ft
