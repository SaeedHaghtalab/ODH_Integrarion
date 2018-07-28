rm require.lock*
iocsh -r m-epics-kg-gta_odh-plc-01,local -c 'requireSnippet("kg-gta_odh-plc-01.cmd","PLCNAME=kg-gta_odh-plc-01,IPADDR=172.16.39.0,RECVTIMEOUT=3000,SAVEFILE_PATH=./ODH_SAVE")'

