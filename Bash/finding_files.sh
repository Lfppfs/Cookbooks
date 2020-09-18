# several different commands using bash find

# the following line searches the working directory for any file which name matches the regexp '*.ipynb',
# then searches all of the matching files for the regexp /dplyr/
# -name and -exec are both options of find
# the syntax of -exec is: -exec command {} ';', that is: command is the command to be executed and it will
# be executed on any of the files (represented by the brackets {}) returned by find; the ';'
# tells the shell that this is the spot where the -exec command finishes
# awk scans files for patterns, which can be given by a regexp (in this case, /dplyr/)
# note that find takes a regexp enclosed in '', while awk takes a regexp enclosed in '//'
find  -name '*.ipynb' -exec awk /dplyr/ {} ';'

# paths come after the find and before options; default path (as above) is the working directory
find ./ode_new/ -name "files_script.sh"

# not sure as to what line below does, guess it's the same as the line above
sed -i "/cd\ \/home/p" /*/*/*/files_script.sh

# the command below finds all directories (type -d) whose names follow the regex "alpha[0-9]*"
# -regextype posix-egrep specifies the type of regex to be used
find ~/target_folder -regextype posix-egrep -type d -name "alpha[0-9]*"

# the command below finds all directories (type -d) whose names follow the regex "alpha[0-9]*" AND deletes all these directories
# as well as their contents. not sure why the + is necessary (the explanation given in the docs isn't very clear)
find ~/target_folder -regextype posix-egrep -type d -name "alpha[0-9]*" -exec rm -r {} +

# the command below does the same as the above but only deletes the dirs if they are empty, otherwise it returns an error
# (see https://unix.stackexchange.com/questions/164873/find-delete-does-not-delete-non-empty-directories)
# find ~/target_folder -regextype posix-egrep -type d -name "alpha[0-9]*" -delete

# maxdepth argument specifies the directory level into which find will descend; -maxdepth 1 thus applies the command only
# to the local directory and not to any of its subdirectories
find target_folder/ -maxdepth 1 -name "*.pdf"
