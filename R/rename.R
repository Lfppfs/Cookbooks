# script for moving and renaming mp3 files with names taken from a .xlsx file
library("xlsx")
library("dplyr")

# suppose file names must be taken from a given column named "file_names"
# one can read only the 1st line (to get column names) and use grep to retrieve the column index
# in order to then read only that column from the file
grep('file_names', colnames(read.xlsx("/home/user/target_folder/file.xlsx", 1, rowIndex = c(1,2))))

# supposing grep returns 17
df <- read.xlsx("/home/user/target_folder/file.xlsx", 1, colIndex = c(17,17)))

setwd("/home/user/some_folder/") # folder where the new files must be moved to

df_sorted <- df1 %>% arrange(file_names)

for (n in 1:length(df_sorted[,2])){
    if (grepl("*.mp3", sort(dir())[n])){
        file.rename(sort(dir())[n], paste("some_prefix", df_sorted[n,1], ".mp3", sep = ""))
    }
}
