# script for moving and renaming mp3 files with names taken from a .xlsx file
# this is a modified version of this code: https://www.r-bloggers.com/2019/10/renaming-all-files-in-a-folder-in-r/
library("xlsx")
library("dplyr")

# suppose file names must be taken from a given column named "file_names"
# one can read only the 1st line (to get column names) and use grep to retrieve the column index
# in order to then read only that column from the file
grep('file_names', colnames(read.xlsx("/home/user/target_folder/file.xlsx", 1, rowIndex = c(1,2))))

# supposing grep returns 17
df <- read.xlsx("/home/user/target_folder/file.xlsx", 1, colIndex = c(17,17))

setwd("/home/user/some_folder/") # folder where the files are located

df_sorted <- df %>% arrange(file_names)
old_files <- list.files(getwd())

new_files <- c()
for (n in seq_along(old_names)){
    if (grepl("*.mp3", old_names[n])){ # only get files with mp3 format
        new_files <- c(new_files, paste0("some_prefix", df_sorted$numero[n],".mp3"))
    }
}

file.copy(from = old_files, to = new_files)
file.remove(from = old_files) # remove old files
# there is also a file.rename function but I couldn't make it work properly
