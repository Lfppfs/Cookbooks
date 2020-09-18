# zip zips archives into one or more files
# the line below zips file_to_zip.mkv into new_file.zip (this new name must be stated)
zip new_file.zip file_to_zip.mkv

# -s option splits the file into multiple zip files
# it takes a size argument and a character standing for kB, Mb Gb etc.
# the line below splits file_to_zip.mkv into zip files of 500Mb each
# -sv returns a verbose output
zip -sv -s 500m new_file.zip file_to_zip.mkv

# -F tries to fix a broken zip file; -FF tries to do it harder
zip -F new_file.zip

# unzip will unzip a given file, but usually cannot handle split files
# internet foruns tell to try fixing it with -F but I wasn't able to do unzip a split file in any way
