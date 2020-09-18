# recursive ls
ls -R transfer

# recursive rm; f denies confirmation
rm -r transfer

# recursive rm deleting all files inside every folder of target_folder
# that start with 'all'
rm -r transfer/*/all*
# recursive -r also works with cp

# copying multiple files at once
# copy folder folder1 AND file folder1/target_file to
# transfer (-t stands for target directory)
cp -r folder1 folder1/target_file -t transfer/

# copy the contents of folder1 to transfer
# does not copy theta05 itself, only its contents
cp -r folder1/. -t transfer/
