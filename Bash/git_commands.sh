# fixing common mistakes and undoing bad commits
# this script was created based on this video from Corey Schafer
# https://youtu.be/FdZecVxzJbk

# if you altered some file (but did not commit the changes) and then want to discard the changes, simply use
git checkout file
# e. g. if you altered the file code1.py and want to discard the changes, enter
git checkout code1.py
# the file will return to the stage before the changes were made

# if you commited something and messed up the commit message, you can use
git commit --amend -m 'Now you can set the right message here'
# this should not be done if the commit has been pushed to a shared repository, because changing
# the commit message will change the commit hash, and this can cause problems to other people

git log --stat # this command shows the files that were changed within the commit that was ammended

# if the commits were made to the master branch but needed to be done to another branch, you can first
# grab the hash of the commit you wish to take off the master and put it in another branch
git log
# then switch the branch
git branch 'anotherbranch'
# then cherry-pick
git cherry-pick 'hashfromthecommityouwanttochange'
# now you have the commit on the anotherbranch, but it still exists on the master branch
# to delete the commit you can go to the master and then
# there are three types of git reset: soft, hard and mixed (the default)
git reset --soft 'hashfromthecommityouwanttodelete'
# soft resets the branch back to the commit you specified, but it keeps the changes made in the staging area
git reset  'hashfromthecommityouwanttodelete' #(mixed)
# mixed resets the branch back to the commit you specified, but it keeps the changes made
# in the working directory, but not in the staging area
git reset --hard 'hashfromthecommityouwanttodelete'
# hard resets the branch back to the commit you specified
# it makes the tracked files match the state that they were in at the hash they specify
# (it discards the changes)
# git --hard leaves untracked files alone. in order to get rid of these files as well
# you can use git clean
git clean -df #(d for directory, f for files)

# git reset --hard can be reset as well, so that the changes will not be lost (if they were made under 30 days)
# this can be done by using
git reflog # this will show all commits, including the ones undone by git reset --hard
# you can then copy the hash from the commit you want to 'revive' and then do
git checkout 'hashfromthecommityouwanttorevive'
# this will make the commit get detached, which basically means that it is not in any branch and it will
# be deleted some time in the future if you do not branch it using
git branch 'somenameforthebranch'
git checkout master

# git revert creates new commits to create new commits, undoing bad commits without rewriting
# history, so that you can use it with shared repos (unlike git commit --ammend)
git revert 'hashfromthecommityouwanttorevert'
# you can use
git diff 'hashfromthecommityoureverted' 'hashfromthecommityouwantedtorevert'
# to see the differences between the bad commit and the new one
