# Jewish Communities in 18th Century Poland - Historical Data Analysis

This repository contains data analysis and processing tools for studying Jewish communities in 18th century Poland, primarily based on tax records and demographic data from various historical sources.

## Project Overview

This project aims to analyze and integrate various historical data sources about Jewish communities in 18th century Poland, with a particular focus on:
- Tax payment records from 1717 to 1764
- Geographic distribution of communities
- Administrative divisions and community hierarchies
- Demographic information
- Economic activities and professional occupations

## Data Sources

### Primary Sources

1. **Kalik's Data**
   - Comprehensive tax payment records between 1717-1764
   - Community hierarchy information
   - Administrative divisions data

2. **KUL (Catholic University of Lublin) Atlas**
   - Religious buildings data from 18th century
   - Geographic identification of communities
   - 1765 census data integration

3. **Historical Documents**
   - Pinkas Va'ad Arba Aratzot (Council of Four Lands records)
   - Lithuanian Community Records
   - "Yidn in Amaliken Poyln" (Jews in Ancient Poland) - translated from Yiddish
   - Białystok Census of 1800

4. **Additional Geographic Data**
   - JewishGen community database
   - Modern Polish administrative boundaries
   - Historical Polish Atlas project data

## Repository Structure
``
to do
``

## Key Datasets

1. **Main Results Dataset (`/result.csv`)**
   - Tax payments (in złoty) from 1717 to 1764
   - Unique community identifiers
   - Tax potential calculations
   - Geographic coordinates
   - Administrative divisions
   - Community hierarchies

2. **Geographic Data**
   - Administrative boundaries (historical and modern)
   - Religious buildings locations
   - Community locations with coordinates

3. **Professional Census Data**
   - Occupation records from Białystok (1800)
   - Ethnic identification of professions
   - Name-based ethnicity classification

## Data Processing

The data processing pipeline includes:
1. OCR and text extraction from historical sources
2. Geographic location matching and verification
3. Community hierarchy reconstruction
4. Administrative division mapping
5. Data integration from multiple sources

Key processing scripts:
- `run.r`: Main processing pipeline
- `1.Unify.r` to `8_data_to_longer.r`: Individual processing steps
- `7.1.kul_data_mutate.r`: KUL data integration
