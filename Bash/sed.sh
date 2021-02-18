#!/bin/bash
# sed uses regular expressions to find and/or substitute patterns in text files

# returns line containing regexp 'Brazil' in target_file.sh; 'p' stands for print
sed -n '/Brazil/p' ~/target_folder/target_file.sh

# returns line 9 of test_file.sh
sed -n '9p' ~/target_folder/target_file.sh

# sed accepts wildcards
# returns line 9 of all target_file.sh files in every folder under target_folder
sed -n '9p' ~/target_folder/*/target_file.sh

# substitutes the string "2" for "3" at its FIRST occurrence on a line
# sed -i "s/2/3/" ~/target_folder/target_file.sh

# substitutes the string "2" for "3" at ALL its occurrences on a line
# sed -i "s/2/3/g" ~/target_folder/target_file.sh

# escaping special characters works as in any regexp
# sed -i "s/\*\ 2/\*\ 3/" ~/target_folder/target_file.sh

# other characters can be used to determine the beginning and end of a pattern
# sed -i "s_\*\ 2_\*\ 3_" ~/target_folder/target_file.sh
# this is more readable than the last one

# substitutes "cd $DIR" by nothing
# sed -i "s/cd\ \$DIR[^\ ]/c11c21//"
# [^\ ] states any character except a space

# read target_file.txt, iterate through its lines then get the line number of lines that match the iterator
# "line" from lines.txt
while IFS= read -r line; do sed -n "s/$line//p" lines.txt; done < target_file.txt

# get elements 1 to 30 of lines from file test.txt
while IFS= read -r line; do echo "${line:1:30}"; done < target_file.txt

# substituting newline characters is tricky since sed reads a file line by line,
# and thus "disconsiders" EOL characters.
# this, for example, does not work (say you want to substitute all EOL for 'aaa'):
# sed -i 's/\n/aaa/' input.in
# but this works, since you force sed to match anything at the end of a line using a regexp:
# sed -i 's/\n*$/aaa/' input.in

# deletes lines beginning with #, except those beginning with #!
# sed -i '/#[^!]/d' ~/target_folder/target_file.sh

# deletes lines 2 through 25 of file alpha0.0_b150_t10000_s5_qmat0.0/number-2.dat
# sed -i '2,25d' alpha0.0_b150_t10000_s5_qmat0.0/number-2.dat

# the r command reads the contents of a file (in this case, alpha0.0_b150_t10000_s5_qmat0.0/number-2.dat) into the
# stream editor; here, it then appends the contents of this file into another file (filetest2.dat)
# the number 1 specifies that this should be done in the first line, however the command below appends the contents
# of the file at the end of line 1 of filetest2.dat, for some reason
# sed '1 r 'filetest2.dat'' alpha0.0_b150_t10000_s5_qmat0.0/number-2.dat

# for appending the contents of filetest2.dat to the beginning of the first line, this does the trick
# sed '1 e cat filetest2.dat' alpha0.0_b150_t10000_s5_qmat0.0/number-2.dat

# the a\ pattern appends a line after a given pattern
# the example below shows how to append "cp seed_initial seed.in" at line number 5 of a file
# called alpha20.sh. The \n just specifies an EOL
# sed -i "5 a\cp seed_initial seed.in\n" alpha20.sh
