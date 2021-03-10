# Used to create the source cohort for the synthetic dataset
# Read in, inspect, reduce, format, synthesise

# Read in
library(tidyverse)
library(synthpop)

APD_source <- "./MAR2020.csv"

cols_APD <- cols(
    APD_Inclusion = col_character(),
    ANZROD_Inclusion = col_character(),
    APACHE3_Inclusion = col_character(),
    `HRN/NIH` = col_character(),
    PatientId = col_character(),
    FirstName = col_character(),
    LastName = col_character(),
    Address = col_character(),
    Suburb = col_character(),
    State = col_character(),
    Country = col_character(),
    Postcode = col_character(),
    SLK = col_character(),
    AgeICU = col_double(),
    AgeHosp = col_double(),
    DOB = col_date(format = "%d/%m/%Y"),
    Sex = col_factor(),
    Indigenous = col_factor(),
    Ethnicity = col_character(),
    EthnicityOther = col_logical(),
    Height = col_double(),
    Weight = col_double(),
    CareUnitAdmID = col_character(),
    CareUnit = col_character(),
    CareType = col_character(),
    YearAdm = col_double(),
    FYAdm = col_double(),
    MonthYearAdm = col_integer(),
    HOSP_ADM_DTM = col_datetime(format = "%d/%m/%Y %H:%M:%S"),
    HOSP_DIS_DTM = col_datetime(format = "%d/%m/%Y %H:%M:%S"),
    ICU_ADM_DTM = col_datetime(format = "%d/%m/%Y %H:%M:%S"),
    ICU_DIS_DTM = col_datetime(format = "%d/%m/%Y %H:%M:%S"),
    ICU_DIS_DEC_DTM = col_datetime(format = "%d/%m/%Y %H:%M:%S"),
    ICU_ADM_DT = col_date(format = "%d/%m/%Y"),
    ICU_ADM_TM = col_time(format = ""),
    ICU_DS_DT = col_date(format = "%d/%m/%Y"),
    ICU_DS_TM = col_time(format = ""),
    ReadmissionLagHours = col_double(),
    ICUadm_count = col_double(),
    ICUSource = col_factor(),
    ICULOS = col_double(),
    LongStay_7 = col_character(),
    LongStay_14 = col_character(),
    ICUOutcome = col_factor(),
    DiedICU = col_character(),
    HOSLOS = col_double(),
    HospitalSource = col_factor(),
    TransferredFrom = col_character(),
    HospitalOutcome = col_factor(),
    TransferredTo = col_character(),
    DiedHospital = col_character(),
    DataComplete = col_character(),
    APACHEDiagnosis = col_factor(),
    APACHEDiagText = col_character(),
    APACHESubcode = col_double(),
    APACHECategory = col_character(),
    Med_Surg = col_character(),
    AP2score = col_double(),
    AP3score = col_double(),
    AP3ROD = col_double(),
    ANZROD = col_double(),
    ICUAdmission = col_character(),
    ReadmissionEpisode = col_double(),
    ElectiveSurg = col_factor(),
    PlannedAdm = col_factor(),
    METAdm = col_factor(),
    PregStatus = col_factor(),
    ThromboPro = col_factor(),
    TreatmentGoals = col_factor(),
    SmokingStatus = col_factor(),
    AfterhoursDis = col_character(),
    ExitBlockHrs = col_double(),
    GCSDateTime = col_datetime(format = "%d/%m/%Y %H:%M:%S"),
    GCS = col_integer(),
    GCSEye = col_integer(),
    GCSVerb = col_integer(),
    GCSMotor = col_integer(),
    GCSSedated = col_integer(),
    CardArrest = col_factor(),
    Diabetes = col_factor(),
    Frailty = col_factor(),
    Delirium = col_factor(),
    PressureInjury = col_factor(),
    ARF = col_factor(),
    ChronicRespiratory = col_factor(),
    ChronicCardiovascular = col_factor(),
    Cirrhosis = col_factor(),
    ChronicRenal = col_factor(),
    ImmuneDisease = col_factor(),
    ImmunoSuppressed = col_factor(),
    AIDS = col_factor(),
    HepaticFailure = col_factor(),
    Lymphoma = col_factor(),
    MetastaticCancer = col_factor(),
    Leukaemia = col_factor(),
    CABGGraft = col_logical(),
    CABGRedo = col_logical(),
    AMIThromboTher = col_character(),
    ECMO = col_character(),
    Inotropes = col_factor(),
    InvVent = col_factor(),
    NIVVent = col_factor(),
    RenalRep = col_factor(),
    Trachestomy = col_factor(),
    INVDayOne = col_factor(),
    INV_Hrs = col_double(),
    NIV_Hrs = col_double(),
    HFNC_Hrs = col_double(),
    PT_identifier = col_logical(),
    HOSP_identifier = col_character(),
    ICU_identifier = col_logical(),
    ALBUMHI = col_double(),
    ALBUMLO = col_double(),
    AP3FIO = col_double(),
    AP3PO2 = col_double(),
    AP3CO2O = col_double(),
    AP3PH = col_double(),
    Intubated = col_factor(),
    BILI = col_double(),
    CREATHI = col_double(),
    CREATLO = col_double(),
    DIASTOLICHI = col_double(),
    DIASTOLICLO = col_double(),
    FIO2 = col_double(),
    PAO2 = col_double(),
    PACO2 = col_double(),
    PH = col_double(),
    GLUCHI = col_double(),
    GLUCLO = col_double(),
    HCO3HI = col_double(),
    HCO3LO = col_double(),
    HCTHI = col_double(),
    HCTLO = col_double(),
    HMGNHI = col_double(),
    HMGNLO = col_double(),
    HRHI = col_double(),
    HRLO = col_double(),
    KHI = col_double(),
    KLO = col_double(),
    LACTATE = col_double(),
    MAPHI = col_double(),
    MAPLO = col_double(),
    NAHI = col_double(),
    NALO = col_double(),
    RRHI = col_double(),
    RRHI_VENT = col_factor(),
    RRLO = col_double(),
    RRLO_VENT = col_factor(),
    SYSTOLICHI = col_double(),
    SYSTOLICLO = col_double(),
    TEMPHI = col_double(),
    TEMPLO = col_double(),
    PLATHI = col_double(),
    PLATLO = col_double(),
    UREA = col_double(),
    WCCHI = col_double(),
    WCCLO = col_double(),
    URINEOP = col_double(),
    FreeVoiding = col_factor(),
    PatientEntityId = col_character(),
    HospitalAdmissionEntityId = col_character()
)

APD_reduced <- read_csv(file = APD_source, na = c("", "NA", "NULL"), col_types = cols_APD)

# Inspect 
codebook.syn(APD)

# Reduce if appropriate. Very reduced here. 
# Set.seed if need to check calculations.

APD_reduced <- APD_reduced %>% 
    dplyr::select(AgeICU:FreeVoiding) %>% 
    dplyr::select(-Ethnicity, -EthnicityOther, -(CareUnitAdmID:FYAdm), -DiedICU, -TransferredFrom, -TransferredTo, -DataComplete, -APACHEDiagnosis, -APACHEDiagText, -APACHECategory, -MonthYearAdm) %>% 
    dplyr::select(-Med_Surg, -ICUAdmission, -ElectiveSurg, -AfterhoursDis, -(CABGGraft:ECMO), -(PT_identifier:ICU_identifier), -LongStay_7, -LongStay_14, -DiedHospital, -AgeICU, -AgeHosp) %>% 
    dplyr::select(DOB:Weight, ICU_ADM_DTM, HOSP_ADM_DTM, ICUSource:SmokingStatus, GCS, Frailty:RenalRep) %>% 
    dplyr::sample_n(500)

# Format: I've gone through all the retained columns and coded them as factor For you. You're welcome.

# Synthesise. Gegen Zie, Synthpop! 

KraftAPD <- syn(APD_reduced %>% dplyr::select(-ICU_ADM_DTM, -HOSP_ADM_DTM), k=250)

# Workaround for Dates being insanely complex to simulate: randomly sample ICU and Hospital start dates and add to the synthetic dataset.

Synthetic_APD <- KraftAPD$syn %>% 
    mutate(ICU_start = sample(APD_reduced$ICU_ADM_DTM, replace = TRUE, size=250),
           Hospital_start = sample(APD_reduced$HOSP_ADM_DTM, replace = TRUE, size=250))

# Save the synthetic dataset
write_csv(Synthetic_APD, "Synthetic_APD.csv")
