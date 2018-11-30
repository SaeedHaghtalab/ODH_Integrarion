#! /bin/bash

source /opt/epics/base-3.15.5/require/3.0.2/bin/setE3Env.bash

/usr/bin/procServ -f -n odhioc -L /var/log/procServ/odh/out-odhioc.log -i ^C^D -x ^Q -c /var/run/procServ/odh 2000 /opt/epics/base-3.15.5/require/3.0.2/bin/iocsh.bash /home/ess/e3-ODH/startup/st3.cmd

