#!/usr/bin/env bash

salt-master 2>/tmp/salt-master.stderr 1>/tmp/salt-master.stdout &
salt-minion 2>/tmp/salt-minion.stderr 1>/tmp/salt-minion.stdout &

# Wait for minion key to appear
while [ "$(salt-key --list unacc | wc -l)" -eq 1 ]; do
    echo "waiting for minion key to appear"
    sleep 1
done

# accepting minion key and waiting for confirmation
echo "accepting salt minion key"
while [ "$(salt-key --list acc | wc -l)" -eq 1 ]; do
    salt-key -Ay
    sleep 1
done

bash 
