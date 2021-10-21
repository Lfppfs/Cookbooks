pkgs_to_load = c("ellipse", "ggplot2", "RColorBrewer", "reshape2", "ggrepel", "extrafont", "stringr", "gridExtra", "dplyr", "tidyr", "forcats")
pkgs_loaded = lapply(pkgs_to_load, library, character.only = TRUE)

rm(list = ls())
gc()

payoffs <- c()
pay_list <- list()
game <- "PD"
if (game == "PD") {
    setwd("/home/lfppfs/Desktop/finite/")
}else if (game == "HD") {
  setwd("/home/lfppfs/Desktop/shape/HD/")
}
dataset <- "shape"
file_path = getwd()
dir_content <- dir(file_path)

# this block iterates over dir_content and creates a named vector whose
# names are the objects of dir_content and values are logical;
# payoffs is thus a named vector containing TRUE for payoff folders
payoffs <- sapply(dir_content, FUN = function(x){
    if(length(x[which(str_starts(x, "b")) &
        which(str_ends(x, "[0-9]"))] != 0)){TRUE}else{FALSE}
    })
writeLines("\npayoffs =")
str(payoffs)
writeLines("\n")

# this block iterates over payoff and creates a list whose
# names are the names of objects of dir_content which are TRUE (i.e., payoffs) and values are a path;
# pay_list is thus a list containing paths
payoff_paths <- as.list(sapply(names(which(payoffs)), FUN = function(x){file.path(getwd(), x)}))
writeLines("\npayoff_paths =")
str(payoff_paths)
writeLines("\n")

pay_list_contents <- lapply(payoff_paths, dir)
# this block iterates over pay_list_contents and creates a list whose
# names are payoffs and values are names of folders that contain the data to be analysed;
# data_folders is thus a list containing alpha[number]...qmat[number] folder names
data_folders <- lapply(pay_list_contents, FUN = function(x){grep("alpha0{1,2}.[0-9]", x, value = TRUE)})
writeLines("\ndata_folders =")
str(data_folders)
writeLines("\n")

# this block iterates over payoff_paths and creates a list whose
# names are payoffs and values are paths containing files with data to be analysed;
# data_paths is thus a list containing paths for each folder to be analysed
data_paths <- lapply(payoff_paths, FUN = function(x){file.path(x,data_folders[[1]])})
writeLines("\ndata_paths =")
str(data_paths)
writeLines("\n")

# this block iterates over data_paths and creates a list whose
# names are payoff values and entries are a file name
arqs <- lapply(data_paths, dir)

# the block below allocates names to the entries of arqs so that
# each entry of arqs (a file) has the name from the folder that it comes from
# thus arqs is now a list whose entries are vectors with associated names
for (n in seq_along(data_folders)){
    names(arqs[[n]]) <- c(rep(data_folders[[n]], 177)) # 177 is the length of each arqs entry (708) divided by 4 (4 alpha folders)
}
writeLines("\narqs =")
str(arqs)
writeLines("\n")

# expression contains the indices of arqs referring to the target files,
# colnames are payoff values
expression <- sapply(arqs, function(x){grep("ntgasns-rep-[0-9]{1,2}.dat", x)})
colnames(expression) <- names(arqs)
str(expression)
writeLines("\nexpression =")
str(expression)
writeLines("\n")
dim(expression)
# line below retrieves the files that should be read using the expression above
mat_test <- matrix(nrow = dim(expression)[1], ncol = dim(expression)[2])

for (cols in seq_along(1:dim(expression)[2])){
    for (rows in seq_along(1:dim(expression)[1])){
        mat_test[rows,cols] <- arqs[[cols]][expression[rows,cols]]
        # mat_test[rows,1] <- arqs[[1]][expression[rows,1]]
        # print(arqs[[1]][expression[rows,1]])
    }
}

# mat_test
# tree_files_path <- arqs[[1]][expression[,1][1:dim(expression)[1]]]
# str(tree_files_path)
# writeLines("\ndtree_files_path =")
# str(tree_files_path)
# writeLines("\n")

# # this block iterates over tree_files_path and creates an array whose
# # rows are a file (along with its path) and columns are the
# # names of the files
# # (if in doubt, compare arqs[1,1], arqs[2,1], arqs[1,20])
# tree_files <- sapply(tree_files_path, FUN = function(x){file.path(data_paths, x)})
# writeLines("\ntree_files =")
# str(tree_files)
# writeLines("\n")

# # this block iterates over tree_files
# # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! I STOPPED HERE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# tree_list <- lapply(tree_files, FUN = function(x){read.table(file.path(x), head = FALSE)})
# # str(tree_list)
# # names(tree_list[[1]])
# # names(tree_list[1]) <- 'test'
# # dim(tree_list[1])
# # dim(tree_list[[1]])

# # writeLines("\ntree_list =")
# # str(tree_list)
# # writeLines("\n")

# # str(tree_list[[1]])
# # head(tree_list[[1]])

# # for (i in test[,1]){
# #     a <- read.table(i, head = FALSE)
# # }
# # a


# # vector("character", 50)
# # arqs[grep("ntgasns-rep-[0-9].dat", arqs[,1])[16]]
# # arqs[grep("ntgasns-rep-[0-9].dat", arqs[,1])[]]
# # arqs[16:65,1]

# # grep("number-[0-9].dat", arqs[,1])
# # arqs[67:116,1]

# # files_vec_trees <- sapply(dir_content, FUN = function(x){
# #     if(length(x[which(str_starts(x, "b")) & which(str_ends(x, "[0-9]"))] != 0)){TRUE}else{FALSE}
# # })

# # files_vec_coop <- sapply(dir_content, FUN = function(x){
# #     if(length(x[which(str_starts(x, "b")) & which(str_ends(x, "[0-9]"))] != 0)){TRUE}else{FALSE}
# # })

# # .GlobalEnv$files_vec_trees = grep("ntgasns-rep-[0-9].dat", arqs)
# # .GlobalEnv$files_vec_coop = grep("number-[0-9].dat", arqs)


# # for (j in files_vec_coop[1]:files_vec_coop[length(files_vec_coop)]){
# # print(c(i, arqs[j], pay_list[[p]]))
# # lido=read.table(paste(pay_list[[p]], i, "/", arqs[j],
# #                       sep=''), head=FALSE, nrows = 300)
# # .GlobalEnv$lido = lido
# # .GlobalEnv$words=strsplit(paste(i), "_")
# # .GlobalEnv$alpha=substr(words[[1]][1],6,9)
# # .GlobalEnv$qmat=substr(words[[1]][5],5,8)
# # .GlobalEnv$subres=cbind(lido, alpha, qmat, rep((j-files_vec_coop[1]),
# #                                     dim(lido)[1]))
# # .GlobalEnv$coops=rbind(coops,subres)
# # }

# # str(arqs)
# # arqs[1,2]
# # arqs[1,3]
# # arqs[1,4]
# # arqs[1,5]
# # names(arqs) <- data_paths[[1]]
# # str(arqs)
# # attributes(arqs)
# # dim(arqs)
# # arqs <- sapply(data_paths[[1]], print)
# # writeLines("\narqs =")
# # str(arqs)

# # head(arqs)

# # arqs=dir(file.path(pay_list[[1]],data_folders[[1]][1]))
# # writeLines("\narqs =")
# # arqs

# # ITERAR SOBRE pay_list[[1]],folders_vec[[1]][1] USANDO STRINGS COMO PATHS, TALVEZ SEJA
# # MELHOR DO Q USAR APPLY


# # folders_vec[1]
# # folders_vec[[1]]
# # arqs <- lapply(pay_list, FUN = function(x){dir(file.path(x,folders_vec[[1]]))})
# # arqs <- lapply(folders_vec, FUN = function(x){dir(file.path(pay_list, x))})
# # dir(file.path(pay_list[1],folders_vec[[1]]))
# # str(arqs)
# #     .GlobalEnv$arqs=dir(file.path(pay_list[[p]],folders_vec[1]))
# # arqs[[1]][1:10]

# tree_list = list()
# coop_list = list()


# # for (p in seq_along(na.omit(pay_list))){
# #     .GlobalEnv$pastas=dir(pay_list[[p]])
# #     .GlobalEnv$folders_vec = grep("alpha0{1,2}.[0-9]",pastas,value = TRUE)
# #     .GlobalEnv$arqs=dir(file.path(pay_list[[p]],folders_vec[1]))
# # }
# # str(folders_vec)
# # str(arqs)
# # arqs[1:10]
# #     .GlobalEnv$files_vec_trees = grep("ntgasns-rep-[0-9].dat", arqs)
# #     .GlobalEnv$files_vec_coop = grep("number-[0-9].dat", arqs)
# #     for (i in folders_vec){
# #       for (j in files_vec_coop[1]:files_vec_coop[length(files_vec_coop)]){
# #         print(c(i, arqs, pay_list[[p]]))
# #         # lido=read.table(paste(pay_list[[p]], i, "/", arqs[j],
# #         #                       sep=''), head=FALSE, nrows = 300)
# #         # .GlobalEnv$lido = lido
# #         # .GlobalEnv$words=strsplit(paste(i), "_")
# #         # .GlobalEnv$alpha=substr(words[[1]][1],6,9)
# #         # .GlobalEnv$qmat=substr(words[[1]][5],5,8)
# #         # .GlobalEnv$subres=cbind(lido, alpha, qmat, rep((j-files_vec_coop[1]),
# #         #                                     dim(lido)[1]))
# #         # .GlobalEnv$coops=rbind(coops,subres)
# #       }
# #   }
# # }
# #       .GlobalEnv$coop_list[[p]] = coops
# #       # the lines below add the corresponding payoff to every df in the list
# #       # splitting the payoff "b1_something" into "b" and "1_something"
# #       .GlobalEnv$pay = strsplit(as.character(names(pay_list)[[p]]), split = 'b')[[1]][2]
# #       # substituting "_" for "." in the string above
# #       substring(pay,2,2) <- '.'
# #       # creating "pay" column in coop_list[[p]]
# #       .GlobalEnv$coop_list[[p]]$pay = rep(pay,nrow(coop_list[[p]]))
# #       # # setting alpha levels in each dataframe of coop_list
# #       levels(.GlobalEnv$coop_list[[p]]$alpha)[1] <- 'Inf'
# #       .GlobalEnv$coop_list[[p]]$alpha <- forcats::fct_relevel(.GlobalEnv$coop_list[[p]]$alpha,
# #                                                               "10.0", "20.0", "50.0", "Inf")
# #       levels(.GlobalEnv$coop_list[[p]]$alpha) <- c("10", "20", "50", "Inf")
# #       .GlobalEnv$coop_list[[p]] <- dplyr::arrange(.GlobalEnv$coop_list[[p]], alpha)
# #     }
# #     # naming columns
# #     for (df in seq_along(coop_list)){
# #     colnames(.GlobalEnv$coop_list[[df]])=c("time","N","fC","fD", "alpha","qmat", "rep", "pay")
# # }

# # str(coop_list)
