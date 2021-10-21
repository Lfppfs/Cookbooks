# system2 invokes the OS command specified by command
# note that there is also the function system, but its docs state >
# "This interface has become rather complicated over the years:
# see system2 for a more portable and flexible interface which is recommended for new code"

# commands must be input as character strings
system2("ls")
# return value is invisible, unless stated otherwise through stderr or stdout arguments
system2("ls", stdout = TRUE)
# printing the return value returns an error code (with 0 for success)
print(system2("ls"))
# arguments to command are input through argument args, also as strings
system2("ls", "-l ~/Desktop", stdout = TRUE)

system2("mkdir", "./folder_test", stdout = TRUE)
system2("rm", "./folder_test", stdout = TRUE) # returns a warning since args is missing -r
system2("rm", "-r ./folder_test", stdout = TRUE) # now this will work
