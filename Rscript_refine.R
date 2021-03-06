library(dplyr)
library(stringr)
library(tidyr)
refine = read.csv("refine_original.csv", header = T, check.names = T, stringsAsFactors = T)
head(refine)
class(refine)
refinenew = refine
refine$�..company = gsub("^ph.*","philips",refine$�..company, ignore.case = T)
refine$�..company = gsub("^fi.*","philips", refine$�..company, ignore.case = T)
refine$�..company = gsub("^ak.*", "akzo", refine$�..company, ignore.case = T)
refine$�..company = gsub("^va.*", "van houten", refine$�..company, ignore.case = T)
refine$�..company = gsub("^uni.*","unilever", refine$�..company, ignore.case = T)
colnames(refine)

colnames (refine)[1] = "company"
colnames (refine)[2] = "ProductCode_Number"
refine = refine %>% separate(ProductCode_Number, into = c("ProductCode", "ProductNumber"), sep = "-")
refine$ProductCategory = refine$ProductCode
refine$ProductCategory = recode(refine$ProductCode, p = "Smartphone", v = "TV", x = "Laptop", q = "Tablet")
refine$ProductCategory
refine$Fulladdress = paste(refine$address,refine$city, refine$country, sep = ",")
refine$Fulladdress

refine$company_philips  = ifelse(refine$company == "philips", 1,0)
refine$company_philips
refine$company_akzo = ifelse(refine$company == "akzo",1,0)
refine$company_van_houten = ifelse(refine$company == "van houten", 1,0)
refine$company_unilever = ifelse(refine$company == "unilever",1,0)
refine$product_smartphone = ifelse(refine$ProductCategory == "Smartphone", 1,0)
refine$product_tv = ifelse(refine$ProductCategory == "TV", 1,0)
refine$product_laptop = ifelse(refine$ProductCategory == "Laptop", 1,0)
refine$product_tablet = ifelse(refine$ProductCategory == "Tablet", 1,0)
write.csv(refine, file = "refine_clean.csv")