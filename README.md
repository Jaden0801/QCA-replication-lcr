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

## How to Run (will update)
```r
# in /code/qca_replication.R
# 1) read data/qca_lcr_calibrated.csv
# 2) run superSubset(), truthTable(), minimize()
# 3) export figures to /figures
