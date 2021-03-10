# APD_Report
Wrangling and a basic report for unit specific data from the ANZICS CORE Adult Patient Database

## Introduction

The ANZICS APD is a registry covering every adult patient admitted to the majority of Intensive Care Units in Australia and New Zealand. The explanation and supporting materials are available from https://www.anzics.com.au/anzics-registries. We contributed to the benchmarking of illness and treatment in the Northern Territory https://www.nt.gov.au by entering every patient into this database. 

## Getting the data 
When using the APD output for research, it's delivered for the requested period and geographical area with patient identifiers removed, as a flat file. 

When retrieving data automatically for our own unit from the database, it's delivered as an Excel files. To get around some of Excel's behaviour, numbers are formatted as text, but there are also four ways to note missing data, and fields are not named exactly the same as in the research flat files.

## The wrangling 
This project started as a repository for the instructions to turn the APD output into something reproducible and predictable to use. Ideally an Excel expert would have been involved to undo some of the more egregious workarounds, but after many false starts I decided it's easiest to retrieve the data, then "Save as .csv", before cleaning and formatting. A little processing with `dplyr` has been useful, straightforward, and (relatively) human readable.

## The first run 
In the base scenario we start with an introduction describing the total patient cohort over the period, with some slightly novel visualisations. There is also some skeleton code for subgroups, along with basic summary statistics or exploratory visualisation. This can be altered and expanded to add more inferences.

## Practice dataset 
`Synthetic_APD.csv` is a _synthetic_ dataset. The process is decribed in the script `Synthesise_a_COMET.R`. It takes a real set of patients, removes identifiers and creates a completely made-up set of imaginary patients which is fake. This synthetic dataset has the same marginal characteristics (totals and proportions across rows and columns), the same proportions of missing data, the same distribution of values within rows and columns, as the dataset from which is was derived. 

Because it doesn't contain any patient information, it can be shared freely. New analyses, scripts and visualisations can be practiced on it, and fingers crossed they will work on the real output from COMET. There are a couple of tips: 

1 Many columns have been removed because they weren't important. It would take a long time to generate something exactly the same form as the input dataset, because of blah blah reasons about dates and a few other formats, and the rules needed to allow dates to make sense. 

2 You probably don't need all the columns but if you find you do (for example you need to work on manipulating timespans, and if so may you find peace), could I suggest using a further step instead of using synthpop for all of the work? And example is given with start dates for ICU and Hospital, feel free to adapt and adopt. 

3 The process hasn't gone into great detail about dependencies between values (partly because that's not well explored in any ICU set, partly because it's heaps of work for a small audience). If you're keen you could use `synthpop::syn(rules())` to create some, so that you don't have the mean of men's heights being less than the mean of women's, and so on.

## The plan 
It would be nice to serve this up as a Shiny app. Maybe at the weekend ... 
