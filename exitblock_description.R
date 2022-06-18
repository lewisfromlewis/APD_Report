library(magrittr)
data_name <- "APD_2021.csv"
blocked <- function(data_name){
    blocksavings <<- data.table::fread(file = data_name, 
                      header = TRUE, 
                      na.strings = c("", "NA", "NULL"), 
                      select = c("ICULOS", "HOSLOS", "HospitalOutcome", "APACHEDiagnosis", "APACHECategory", "ANZROD", "ElectiveSurg", "ExitBlockHrs", "Inotropes", "InvVent", "INVDayOne", "NIVVent", "RenalRep", "Trachestomy")) %>%
        dplyr::mutate(nointervention = Inotropes =="No" & InvVent =="No" & INVDayOne == "No" & NIVVent == "No" & RenalRep =="No" & Trachestomy == "No", ERU_suitable = nointervention==TRUE & ElectiveSurg=="Yes") %>% 
        dplyr::group_by(APACHECategory) %>%
        dplyr::summarise(mean_block_hrs = round(mean(ExitBlockHrs, na.rm=T), 1), target_eighth_hrs = round(sum(ExitBlockHrs[ExitBlockHrs>quantile(ExitBlockHrs, probs = 0.875, na.rm=TRUE)], na.rm=T), 1), block_save = round(target_eighth_hrs*5333/24, 1), ERU_suitable_pts = sum(ERU_suitable), ERU_save = round(sum(ERU_suitable*ICULOS*5333/24, na.rm=T), 1))
        write.csv(blocksavings, file = paste0("savings", data_name))
        View(blocksavings)
}

blockedpatients <- function(data_name){
    ERU_people <<- data.table::fread(file = data_name, 
                                       header = TRUE, 
                                       na.strings = c("", "NA", "NULL"), 
                                       select = c("HRN/NIH", "ICULOS", "HOSLOS", "HospitalOutcome", "APACHESubcode", "APACHECategory", "ANZROD", "ElectiveSurg", "ExitBlockHrs", "Inotropes", "InvVent", "INVDayOne", "NIVVent", "RenalRep", "Trachestomy")) %>%
        dplyr::mutate(nointervention = Inotropes =="No" & InvVent =="No" & INVDayOne == "No" & NIVVent == "No" & RenalRep =="No" & Trachestomy == "No", ERU_suitable = nointervention==TRUE & ElectiveSurg=="Yes") %>% 
        dplyr::filter(nointervention == TRUE)
        write.csv(ERU_people, file = paste0("nointervention_patients", data_name))
        View(ERU_people)
}

traches <- function(data_name){
    trache_people <<- data.table::fread(file = data_name,
                                        header = TRUE, 
                                        na.strings = c("", "NA", "NULL"),
                                        select = c("ICULOS", "HOSLOS", "HospitalOutcome", "ANZROD", "ElectiveSurg", "Trachestomy")) %>% 
        dplyr::group_by(ElectiveSurg) %>% 
        dplyr::summarise(Traches = sum(Trachestomy=="Yes"), TracheProportion = mean(Trachestomy=="Yes"), ICUtime = mean(ICULOS[Trachestomy=="Yes"])/24, Hosptime = mean(HOSLOS[Trachestomy=="Yes"])/24)
}


List2021 <- data.table::fread(file = "APD_2021.csv", 
                                 header = TRUE, 
                                 na.strings = c("", "NA", "NULL"), 
                                 select = c("HRN/NIH"))
write.csv(List2021, file = "patients_2021.csv")
View(ERU_people)