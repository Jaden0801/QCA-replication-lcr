# QCA replication skeleton
# Paper: Does policy design matter for the effectiveness of local content requirements?
# Data: data/qca_lcr_calibrated.csv

libs <- c("QCA","dplyr","readr")
invisible(lapply(libs, require, character.only = TRUE))

dat <- read_csv("data/qca_lcr_calibrated.csv") 
head(dat)


# tt_eff <- truthTable(dat, outcome="OUTCOME", incl.cut=0.75, freq=1, complete=TRUE)
# sol_eff <- minimize(tt_eff, details=TRUE, dir.exp=c("~C1","C2","C3","C4","C5"), include="?")
# print(sol_eff)
