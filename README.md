# clinical-trial-data-pipeline
# Clinical Trial Data Integration & Reporting Pipeline (SAS)

## Project Overview
This repository contains a production-ready SAS script designed to simulate and process clinical trial data domains. The pipeline ingests separate Demographics (DM) and Adverse Events (AE) datasets, applies clinical filtering logic, and executes an inner join to construct a master safety analysis file.

## Core Features
- **Data Simulation:** Generates industry-standard clinical tables matching CDISC variable structures.
- **Data Cleansing:** Implements rule-based filtering to remove protocol screen failures.
- **Relational Joining:** Integrates multi-domain attributes using unique subject identifiers (`USUBJID`).

## Technologies Used
- SAS 9.4 / SAS Viya
- PROC SQL
- DATA step programming
