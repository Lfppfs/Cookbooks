# !/bin/bash

#################################################
# Create a script which will print a random word.
# There is a file containing a list of words on your system (usually /usr/share/dict/words or /usr/dict/words).
# Hint: Piping will be useful here.

cat -n /usr/share/dict/words | grep -w "$RANDOM"

# this command below works too
# sed -n "$RANDOM"p /usr/share/dict/words

# this command below works as well
# cat -n /usr/share/dict/words | sed -n "$RANDOM"p

#################################################
# Expand the previous activity so that if a number is supplied as the first command line argument
# then it will select from only words with that many characters.
#  Hint: Grep may be useful here

# documentation in man grep
egrep 'e{2}' /usr/share/dict/words
#^início da linha
#. qualquer letra
# {comprimento da string}
#$ final da linha
egrep '^.{2}$' /usr/share/dict/words
