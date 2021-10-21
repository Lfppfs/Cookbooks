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

# this matches a file named "alpha__.sh", with underscores replacing by one or two digits;
# the file is matched at paths below the current one (./.+), and these paths
# have any possible name ("." specifies any digit and + specifies "one or more of");
# the files found are then streamed using sed, which searches for line number 38 and
# deletes it (using d and the -i option deletes a pattern/line)
# specifying -regextype egrep may not be necessary in this case, I'm not sure
# find -regextype egrep -regex "./.+/alpha[0-9]{1,2}.sh" -exec sed -i "38d" {} ";"

# this regular expression matches files named number-1.dat, number-2.dat and so on up to number-24.dat
# this has to be done using alternation (|), so that find will match
# files number-1.dat up to number-9.dat (./number-[0-9]\.dat), then
# files number-10.dat up to number-19.dat (./number-[1][0-9]\.dat), then
# files number-20.dat up to number-24.dat (./number-[2][0-4]\.dat)
# more info here https://www.regular-expressions.info/numericranges.html
# sed -n "1,26p" simply prints lines 1 to 26 of the file (and not the rest of the file, hence the -n)
find -regextype egrep -regex "./number-[0-9]\.dat|./number-[1][0-9]\.dat|./number-[2][0-4]\.dat" -exec sed -n "1,26p" {} ";"
