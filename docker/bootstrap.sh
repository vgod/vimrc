#!/bin/bash
# Usage: bootstrap.sh [command]
# - command: Run the command as user csidev.
# Environment Variables:
# - USERID : user id for user csidev.
# - GROUPID: group id for user csidev.

# change userid to correct userid
DEVUSER=devuser
PROJROOT=/devprj
echo usermod -u $USERID $DEVUSER
echo groupmod -g $GROUPID $DEVUSER
usermod -u $USERID $DEVUSER
groupmod -g $GROUPID $DEVUSER

# Make sure we can access the mounted volumn
chown $DEVUSER.$DEVUSER $PROJROOT


# execute given command. Otherwise, enter bash shell.
echo "Switching user to $DEVUSER"
if [ $# -eq 0 ]; then
  su -l $DEVUSER
else
  cmd="su $DEVUSER -c \"cd $PROJROOT; $@\""
  echo $cmd
  eval $cmd
fi
