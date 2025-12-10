install.packages(c("QCA","SetMethods","ggplot2"), type = "binary")
library(QCA)
library(SetMethods)
library(ggplot2)

# read
data <- read.csv("/Users/golden/Desktop/MIIS Semester1/Data in Envi Decision making/Replication/Replication_fuzzy_data.csv", check.names = TRUE)

# edit column name
names(data) <- c("Case","C1","C2","C3","C4","C5","Outcome")

# make sure the numeric
data[, c("C1","C2","C3","C4","C5","Outcome")] <- lapply(data[, c("C1","C2","C3","C4","C5","Outcome")], function(x) as.numeric(as.character(x)))

# quick check
str(data); head(data)

# Necessity of a single condition
nec_single <- pof(
  outcome    = "Outcome",
  conditions = c("C1","C2","C3","C4","C5"),
  relation   = "necessity",
  data       = data[, c("C1","C2","C3","C4","C5","Outcome")]
)
print(nec_single)
# ---------------------------------------------------------
# Table S4
# ============================

nec_neg <- pof(
  outcome    = "~Outcome",                    
  conditions = c("C1","C2","C3","C4","C5"),
  relation   = "necessity",
  data       = data_qca
)

print(nec_neg)
#---------------------------
# make sure we only have C1–C5 and Outcome：
data_qca <- data[, c("C1","C2","C3","C4","C5","Outcome")]

# ============================
# Table S5: Truth Table for sufficiency of LCR policy effectiveness

tt_eff <- truthTable(
  data       = data_qca,
  outcome    = "Outcome",
  incl.cut   = 0.75,                     
  n.cut      = 1,
  dir.exp    = c("~C1","C2","C3","C4","C5"),
  complete   = TRUE                     
)

# true table to data.frame
tt_eff_df <- as.data.frame(tt_eff$tt)
tt_eff_df

# midd result
sol_i <- minimize(
  input     = tt,
  details   = TRUE,
  show.cases= TRUE
)

print(sol_i, details = TRUE, show.cases = TRUE)


# Extract a summary of the solution including consistency/coverage of each path
sol_df <- as.data.frame(sol_i$i.sol$IC)

# Add the path name
sol_df$path <- rownames(sol_df)

# 1) Extract the intermediate solution paths each is a conjunction: connected with *
paths <- unlist(sol_i$solution)
Y <- data_qca$Outcome

# 2) Calculate the fuzzy membership of each path
path_membership <- function(expr, data) {
  terms <- strsplit(expr, "\\*")[[1]]
  terms <- trimws(terms)
  # Each factor ~X -> 1 - X； X -> X
  mats <- lapply(terms, function(tk) {
    if (startsWith(tk, "~")) {
      var <- substring(tk, 2)
      1 - data[[var]]
    } else {
      data[[tk]]
    }
  })
  # Conjunction * = element-wise minimum
  Reduce(pmin, mats)
}

# 3) Indicators of a path:consistency / PRI / coverage
one_path_metrics <- function(X, Y) {
  XY   <- pmin(X, Y)
  XnY  <- pmin(X, 1 - Y)  
  cons <- sum(XY) / sum(X)
  covS <- sum(XY) / sum(Y)
  PRI  <- (sum(XY) - sum(XnY)) / (sum(X) - sum(XnY))
  c(inclS = cons, PRI = PRI, covS = covS)
}


sol_sum <- do.call(rbind, lapply(paths, function(p) {
  X <- path_membership(p, data_qca)
  one_path_metrics(X, Y)
}))
sol_sum <- as.data.frame(sol_sum)
sol_sum$path <- paths
sol_sum <- sol_sum[, c("path","inclS","PRI","covS")]
print(sol_sum)

if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
library(ggplot2)
ggplot(sol_sum, aes(x = reorder(path, covS), y = covS)) +
  geom_col() +
  coord_flip() +
  labs(
    x = "Sufficient configuration (Intermediate Solution)",
    y = "Coverage (covS)",
    title = "Sufficient Configurations for LCR Policy Effectiveness"
  ) +
  theme_minimal()

# ---- Table 3 – Sufficiency for LCR ineffectiveness ----


# Construct ~C1 OR C5 (fuzzy logic OR = max)
data$notC1 <- 1 - data$C1
data$notC1_or_C5 <- pmax(data$notC1, data$C5)

# Necessary condition test
nec_metrics <- pof(
  setms    = data$notC1_or_C5,
  outcome  = data$Outcome,
  relation = "necessity"
)

nec_metrics

plot(
  x = data$notC1_or_C5,
  y = data$Outcome,
  xlab = "No restrictive LCR policy design (C1) OR high economic complexity (C5)",
  ylab = "LCR policy Effectiveness",
  xlim = c(0,1), ylim = c(0,1)
)
abline(a = 0, b = 1, lty = 1, col = "grey70")
abline(h = 0.5, v = 0.5, lty = 2, col = "grey70")
title("Necessity relation")

# ---------------------------------------------------------
# ============================
# Necessary conditions for NEGATED outcome (~Outcome)

# ---------------------------------

# str(data); head(data)
# ---------------------------------

data_qca <- data[, c("C1","C2","C3","C4","C5","Outcome")]

# ============================
# 1. Necessity of a single condition (Outcome = 1)
# ============================
nec_single <- pof(
  outcome    = "Outcome",
  conditions = c("C1","C2","C3","C4","C5"),
  relation   = "necessity",
  data       = data_qca
)
print(nec_single)

# ============================
# 2. Necessary conditions for NEGATED outcome (~Outcome)

nec_neg <- pof(
  outcome    = "~Outcome",
  conditions = c("C1","C2","C3","C4","C5"),
  relation   = "necessity",
  data       = data_qca
)
print(nec_neg)

# ============================
# 3. Table S5: Truth Table for sufficiency of LCR policy effectiveness
# ============================

tt_eff <- truthTable(
  data       = data_qca,
  outcome    = "Outcome",
  conditions = c("C1","C2","C3","C4","C5"),
  incl.cut   = 0.75,               
  n.cut      = 1,                   
  complete   = TRUE,              
  show.cases = TRUE
)

tt_eff     

tt_eff_df <- as.data.frame(tt_eff$tt)
tt_eff_df

# ============================
# 4. Intermediate Solution

# ============================

sol_i <- minimize(
  input      = tt_eff,
  details    = TRUE,
  show.cases = TRUE,
  include    = "?",                           
  dir.exp    = c("~C1","C2","C3","C4","C5")   
)

print(sol_i, details = TRUE, show.cases = TRUE)



sol_all <- minimize(
  input      = tt_eff,
  details    = TRUE,
  show.cases = TRUE,
  include    = "?",                         
  dir.exp    = c("~C1","C2","C3","C4","C5")
)

names(sol_all)

sol_i <- sol_all$i.sol

print(sol_i, details = TRUE, show.cases = TRUE)
