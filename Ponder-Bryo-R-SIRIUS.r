start.time <- Sys.time()

# ---------- Script ----------
# input directory
input_dir <- getwd()
#input_dir

# load the functions file
source(paste(input_dir, "/Workflow_R_Functions.r", sep = ""))


#spec_pr <- spec_Processing(input_dir,
                           #"./pos_08_autumn_Polstr_8_1-E-3_01_17214.mzML", 
                           #"./pos_08_autumn_Polstr_8_1-E-3_01_17214")

# Extract MS2 peak lists
#spec_pr2 <- ms2_peaks(pre_tbl = "/opt/workdir/pos_08_autumn_Polstr_8_1-E-3_01_17214/premz_list.txt", 
                      #proc_mzml =  "/opt/workdir/pos_08_autumn_Polstr_8_1-E-3_01_17214/processedSpectra.mzML",
                      #input_dir,
                      #result_dir = "./pos_08_autumn_Polstr_8_1-E-3_01_17214",
                     #file_id = "file_8")

# camera results for isotopes
#cam_res <- cam_func(input_dir,
                    #f = "./pos_08_autumn_Polstr_8_1-E-3_01_17214.mzML", 
                    #ms2features =  "/opt/workdir/pos_08_autumn_Polstr_8_1-E-3_01_17214/insilico/MS2DATA.csv")

# Extract MS1 peaks or isotopic peaks
ms1p <- ms1_peaks(x = '/opt/workdir/pos_08_autumn_Polstr_8_1-E-3_01_17214/insilico/MS2DATA.csv', 
                  y = '/opt/workdir/pos_08_autumn_Polstr_8_1-E-3_01_17214/CAMERAResults.csv', 
                  "./pos_08_autumn_Polstr_8_1-E-3_01_17214", 
                  input_dir, 
                  QCfile = TRUE)

#prepare sirius parameter files
sirius_param_files <- sirius_param(x = '/opt/workdir/pos_08_autumn_Polstr_8_1-E-3_01_17214/insilico/MS1DATA.csv', 
                                   "./pos_08_autumn_Polstr_8_1-E-3_01_17214", 
                                   input_dir,
                                   SL = FALSE)


# Run sirius
run_sirius(files = '/opt/workdir/pos_08_autumn_Polstr_8_1-E-3_01_17214/insilico/MS1DATA_SiriusP.tsv', 
           ppm_max = 5, 
           ppm_max_ms2 = 15, 
           QC = TRUE, 
           SL = FALSE, 
           SL_path = NA,
           candidates = 30,
          profile = "qtof")

# for (i in 9:nrow(input_table)){
    
#     #Preprocess and Read the mzMLfiles
#     spec_pr <- spec_Processing(input_dir,
#                                input_table[i, "mzml_files"], 
#                                input_table[i, "ResultFileNames"])
    
#     # Extract MS2 peak lists
#     spec_pr2 <- ms2_peaks(pre_tbl = paste(input_dir, str_remove(paste(input_table[i, "ResultFileNames"], "/premz_list.txt", sep = ""), "."), sep =""), 
#                           proc_mzml = paste(input_dir, str_remove(paste(input_table[i, "ResultFileNames"], "/processedSpectra.mzML", sep = ""), "."), sep =""),
#                           input_dir,
#                           result_dir = input_table[i, "ResultFileNames"],
#                          file_id = input_table[i, "File_id"])
    
#     # camera results for isotopes
#     cam_res <- cam_func(input_dir,
#                         f = input_table[i, "mzml_files"], 
#                         ms2features = paste(input_dir, str_remove(paste(input_table[i, "ResultFileNames"], "/insilico/MS2DATA.csv", sep = ""), "."), sep = ""))
    
#     # Extract MS1 peaks or isotopic peaks
#     ms1p <- ms1_peaks(x = paste(input_dir, str_remove(paste(input_table[i, "ResultFileNames"],'/insilico/MS2DATA.csv', sep = ""), "."), sep =""), 
#                       y = paste(input_dir, str_remove(paste(input_table[i, "ResultFileNames"],'/CAMERAResults.csv', sep = ""), "."), sep =""), 
#                       input_table[i, "ResultFileNames"], 
#                       input_dir, 
#                       QCfile = TRUE)
    
#     #prepare sirius parameter files
#     sirius_param_files <- sirius_param(x = paste(input_dir, str_remove(paste(input_table[i, "ResultFileNames"],'/insilico/MS1DATA.csv', sep = ""), "."), sep =""), 
#                                        result_dir = input_table[i, 'ResultFileNames'], 
#                                        input_dir,
#                                        SL = FALSE)
    
    
#     # Run sirius
#     run_sirius(files = paste(input_dir, str_remove(paste(input_table[i, "ResultFileNames"],'/insilico/MS1DATA_SiriusP.tsv', sep = ""), "."), sep =""), 
#                ppm_max = 5, 
#                ppm_max_ms2 = 15, 
#                QC = TRUE, 
#                SL = FALSE, 
#                SL_path = NA,
#                candidates = 30,
#               profile = "qtof")
# }

end.time <- Sys.time()

time.taken <- end.time - start.time
print(time.taken)
