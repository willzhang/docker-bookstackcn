#!/bin/bash
if [ ! -f /bookstack/dbupdated ]
then
  /bookstack/BookStack install 2>&1 | tee /bookstack/dbupdated
else
  echo "###db had updated,skip bookstack install,just start it!###"
fi
/bookstack/BookStack
