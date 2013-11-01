#!/bin/bash

first=true
version=$1

if [ "$1" == "" ]
then
  echo "build.cm.sh: must specify cm version"
  exit 1
fi

# The whole run1/run2 situation just allows a way to specify an
# order to build in. Sometimes I may not want a public build to
# go out first.

# Public devices. These will get the full treatment
#  - clobber (if first)
#  - sync (if first)
#  - cherry picks (if first)
#  - upload
#  - tweet
#  - odexed
  pub_devices_run1=()
  pub_devices_run2=(tenderloin)

# Personal devices. These won't get uploaded at all.
# Just built on the new codebase
  personal_devices_run1=(jfltevzw dlx d2vzw)
  personal_devices_run2=(toro)

# Build for each device in pub_devices
  for i in ${pub_devices_run1[@]}
  do
    if [ "$first" == true ]
    then
      /home/dp/.bin/build.cm$version.generic -f -p -s -c -u -t $i
      first=false
    else
      /home/dp/.bin/build.cm$version.generic -f -u -t $i
    fi
  done

# Build for each device in personal_devices
  for i in ${personal_devices_run1[@]}
  do
    if [ "$first" == true ]
    then
      /home/dp/.bin/build.cm$version.generic -f -p -s -c $i
      first=false
    else
      /home/dp/.bin/build.cm$version.generic -f $i
    fi
  done

# Build for each device in pub_devices_run2
  for i in ${pub_devices_run2[@]}
  do
    if [ "$first" == true ]
    then
      /home/dp/.bin/build.cm$version.generic -f -p -s -c -u -t $i
      first=false
    else
      /home/dp/.bin/build.cm$version.generic -f -u -t $i
    fi
  done

# Build for each device in personal_devices
  for i in ${personal_devices_run2[@]}
  do
    if [ "$first" == true ]
    then
      /home/dp/.bin/build.cm$version.generic -f -p -s -c $i
      first=false
    else
      /home/dp/.bin/build.cm$version.generic -f $i
    fi
  done
