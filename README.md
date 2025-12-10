# QCA-replication-lcr
For Data in Env Decision-making Assignment
# QCA Replication – Local Content Requirements (LCR)

**Course**: Data & Environmental Decision-Making  
**Project Type**: Replication & Reflection  

## Paper to Replicate
- Title: Does policy design matter for the effectiveness of local content requirements?  
- Journal: Policy Studies Journal (PSJ)  
- DOI/Link: https://doi.org/10.1111/psj.12590

## What I Will Replicate
- QCA pipeline using calibrated fuzzy-set scores (C1–C5, OUTCOME)
- Necessity tests, sufficiency truth tables, conservative/intermediate/parsimonious solutions
- XY-plots for selected solution paths

## Data Source
- Annex tables provided by the authors (Raw & Calibrated Data; Truth Tables; Solution Paths).  
- File: `data/qca_lcr_calibrated.csv` (to be added; transcribed from Annex Table S1).

## Methods & Tools
- R (packages: `QCA`, `SetMethods`, `dplyr`, `ggplot2`)
- Parameters following Annex (e.g., `incl.cut = 0.75`, `freq = 1`, specified `dir.exp`)

## How to Run
```r
# in /code/qca_replication.R
# 1) read data/qca_lcr_calibrated.csv
# 2) run superSubset(), truthTable(), minimize()
# 3) export figures to /figures
```
## Reflection: Process, Challenges, and Next Steps

1. Replication Process

In this project, I reproduced the necessity analysis and the sufficiency truth table from the original study using fuzzy-set QCA in R. I began by loading and cleaning the dataset, checking calibration ranges, and ensuring the fuzzy membership scores were correctly interpreted. I then used the `pof()` function to test necessary conditions and `truthTable()` to reproduce Table S5. Finally, I generated visualizations to better communicate the patterns in the data.

2. Challenges

Several challenges emerged during the replication.
First, the study did not provide open code, so I had to infer the authors’ workflow from the text and supplementary materials. This required repeated testing of parameters such as incl.cut, n.cut, and direction expectations (dir.exp). Second, QCA packages in R behave differently such as QCA and SetMethods, and functions like minimize() can produce multiple types of solutions such as conservative, intermediate and parsimonious, which initially made interpretation confusing. Third, the data were provided only in calibrated fuzzy-set form, meaning I could not examine how the authors performed calibration or whether alternative calibration strategies would change the results. Finally, replicating the exact solution pathways proved difficult because small changes in thresholds or treatment of logical remainders produced different outputs.

3. Next Steps

If I were to extend this replication, I would attempt to fully reproduce the intermediate solutions reported in the paper and compare their coverage and consistency to the original results. Also, extending the analysis to additional countries would strengthen the policy insights.
