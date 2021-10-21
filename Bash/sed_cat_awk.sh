#!/bin/bash
# sed uses regular expressions to find and/or substitute patterns in text files

# returns line containing regexp 'Brazil' in files_script.sh; 'p' stands for print
sed -n '/Brazil/p' ~/Desktop/Programming/Bash/Bashing/test_file.sh

# returns line 9 of test_file.sh
sed -n '9p' ~/Desktop/Programming/Bash/Bashing/test_file.sh

# returns line 9 of all test_file.sh files in every folder under Desktop
sed -n '9p' ~/Desktop/*/test_file.sh

# substitutes the string "2" for "3" at its first occurrence on a line
# sed -i "s/2/3/" Desktop/Programming/Bash/Bashing/test_file.sh

# substitutes the string "2" for "3" at all its occurrences on a line
# sed -i "s/2/3/g" ~/Desktop/Programming/Bash/Bashing/test_file.sh

# substitutes the string "0.005 0.05" for "0.0 0.1 0.5 1.0 5.0" in every file that  matches the wildcard "alpha*",
# under every folder that matches the wildcard "b1_*", in the directory Desktop/shape/PD_sigma4
# sed -i 's/0.005 0.05/0.0 0.1 0.5 1.0 5.0/' Desktop/shape/PD_sigma4/b1_*/alpha*

# escaping special characters functions as in any regexp
# sed -i "s/\*\ 2/\*\ 3/" Desktop/Programming/Bash/Bashing/test_file.sh

# other characters can be used to determine the beginning and end of a pattern
# sed -i "s_\*\ 2_\*\ 3_" Desktop/Programming/Bash/Bashing/test_file.sh # this is more readable than the last one

# substitutes "cd $DIRtheta05/c11c21" by nothing
# [^\ ] states any character except a space
# sed -i "s/cd\ \$DIR[^\ ]theta05\/c11c21//"

# read test.txt, iterate through its lines then get the line number of lines that match the iterator
"line" from lines.txt
while IFS= read -r line; do sed -n "s/$line//p" lines.txt; done < test.txt

# get elements 1 to 30 of lines from file test.txt
while IFS= read -r line; do echo "${line:1:30}"; done < test.txt

