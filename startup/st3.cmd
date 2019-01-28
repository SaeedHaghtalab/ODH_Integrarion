require iocStats,ae5d083
require recsync,1.3.0

require s7plc,1.4.0p
require asyn,4.33.0
require modbus,2.11.0p


epicsEnvSet("IOC", "ODH-IOC:ODH-IOC")

epicsEnvSet("TOP","$(E3_CMD_TOP)/..")

epicsEnvSet("PLCNAME","kg-gta_odh-plc-01")
epicsEnvSet("IPADDR","172.16.49.12")
epicsEnvSet("INSIZE","184")

loadIocsh("iocStats.iocsh", "IOCNAME=$(IOC)")
loadIocsh("recsync.iocsh",  "IOCNAME=$(IOC)")
loadIocsh("s7plc.iocsh", "PLC_NAME=$(PLCNAME),PLC_IP=$(IPADDR),INSIZE=$(INSIZE)")
loadIocsh("modbus_s7plc.iocsh", "PLC_NAME=$(PLCNAME),PLC_IP=$(IPADDR)")

dbLoadRecords("$(TOP)/db/kg-gta_odh-plc-01.db", "PLCNAME=$(PLCNAME), MODVERSION=0")
dbLoadRecords("$(TOP)/db/Alarms.db")

iocInit

dbl > "$(TOP)/$(IOC)_PVs.list"
