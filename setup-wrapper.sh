#!/bin/bash -e
touch log-stdout.log
touch log-stderr.log
echo `date` >> log-stdout.log
echo `date` >> log-stderr.log
./setup.sh > >(tee -a log-stdout.log) 2> >(tee -a log-stderr.log >&2)
read -p "Press enter to exit ..."