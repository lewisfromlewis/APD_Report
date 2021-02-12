# APD_Report
Wrangling and a basic report for unit specific data from the ANZICS CORE Adult Patient Database

## Introduction

The ANZICS APD is a registry covering every adult patient admitted to the majority of Intensive Care Units in Australia and New Zealand. The explanation and supporting materials are available from https://www.anzics.com.au/anzics-registries. We contributed to the benchmarking of illness and treatment in the Northern Territory https://www.nt.gov.au by entering every patient into this database. 

## The data 
When using the APD output for research, it's delivered for the requested period and geographical area with patient identifiers removed, as a flat file. 

When retrieving data automatically for our own unit from the database, it's delivered as an Excel files. To get around some of Excel's behaviour, numbers are formatted as text, but there are also four ways to note missing data, and fields are not named exactly the same as in the research flat files.

## The wrangling 
This project started as a repository for the instructions to turn the APD output into something reproducible and predictable to use. Ideally an Excel expert would have been involved to undo some of the more egregious workarounds, but after many false starts I decided it's easiest to retrieve the data, then "Save as .csv", before cleaning and formatting. A little processing with `dplyr` should hopefully produce a useful occupancy table and select commonly requested subgroups of patients for further inquiry.

## The kickstarter 
In the base scenario we start with an introduction describing the total patient cohort over the period, with some slightly novel visualisations. There is also some skeleton code for subgroups, along with basic summary statistics or exploratory visualisation. 

## The plan 
It would be nice to serve this up as a Shiny app. Maybe at the weekend ... 
