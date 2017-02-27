#!/bin/bash

# Update the container version tag in scripts and documentation

: ${1?Must supply a version number (e.g. $0 1.2.3)}

exp='s/\(callstats\/fluentd-kubernetes-cloudwatch:\)[0-9][0-9.]\+/\1'"$1"'/g'

sed -i -e "$exp" README.md *.sh
