# script for moving and renaming mp3 files with names taken from a .xlsx file
# this is a modified version of this code: https://www.r-bloggers.com/2019/10/renaming-all-files-in-a-folder-in-r/
library("xlsx")
library("dplyr")

# suppose file names must be taken from a given column named "number"
# one can read only the 1st line (to get column names) and use grep to retrieve the column index
# in order to then read only that column from the file
# col_number <- grep('file_names', colnames(read.xlsx("/home/user/target_folder/file.xlsx", 1, rowIndex = c(1,2))))

col_number1 <- grep('^numero$', colnames(read.xlsx("/home/lfppfs/Desktop/Programming/Tests/test1/test.xls", 1, rowIndex = c(1,2))))
# print(col_number1)
col_number2 <- grep('^registro$', colnames(read.xlsx("/home/lfppfs/Desktop/Programming/Tests/test1/test.xls", 1, rowIndex = c(1,2))))
# print(col_number2)

# df <- read.xlsx("/home/user/target_folder/file.xlsx", 1, colIndex = c(col_number,col_number))
df <- read.xlsx("/home/lfppfs/Desktop/Programming/Tests/test1/test.xls", 1, colIndex = c(col_number1,col_number2))

# # setwd("/home/user/some_folder/") # folder where the files are located
setwd("/home/lfppfs/Desktop/Programming/Tests/test1") # folder where the files are located

new_files <- c()
for (n in seq_along(df[names(df)[1]][,1])){
    if (grepl("*.wav", list.files(getwd())[n])){ # only get files with wav format
        new_files <- c(new_files, paste0("FNJV_", df[names(df)[1]][n,],".mp3"))
    }
}

dir.create('renamed-files')
file.copy(from = as.character(df$antigos), to = file.path(getwd(), 'renamed-files', new_files))

# remove old files
remove_or_not = TRUE
if (remove_or_not){
    file.remove(from = levels(df$registro))
}
# # there is also a file.rename function but I couldn't make it work properly

######################################################################
############################## Version2 ##############################
######################################################################
# library("xlsx")
# library("dplyr")

# suppose file names must be taken from a given column named "file_names"
# one can read only the 1st line (to get column names) and use grep to retrieve the column index
# in order to then read only that column from the file
# col_number <- grep('^file_names$', colnames(read.xlsx("/home/user/target_folder/file.xlsx", 1, rowIndex = c(1,2))))

# df <- read.xlsx("/home/user/target_folder/file.xlsx", 1, colIndex = c(col_number,col_number))

# setwd("/home/user/some_folder/") # folder where the files are located

# df_sorted <- df %>% arrange(df[1])
# str(df_sorted)
# old_files <- list.files(getwd())
# str(old_files)

# new_files <- c()
# for (n in seq_along(old_files)){
#     if (grepl("*.mp3", old_files[n])){ # only get files with mp3 format
#         new_files <- c(new_files, paste0("FNJV_", df_sorted[names(df_sorted)[1]][n,],".mp3"))
#     }
# }
# new_files
# file.copy(from = old_files, to = new_files)

# # remove old files
# remove_or_not = FALSE
# if (remove_or_not){
# file.remove(from = old_files)
# }
# # there is also a file.rename function but I couldn't make it work properly
