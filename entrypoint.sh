#!/bin/bash
if [ ! -f /opt/bookstack/dbupdated ]
then
  /opt/bookstack/BookStack install 2>&1 | tee /opt/bookstack/dbupdated
else
  echo "###db had updated,skip bookstack install,just start it!###"
fi
/opt/bookstack/BookStack
