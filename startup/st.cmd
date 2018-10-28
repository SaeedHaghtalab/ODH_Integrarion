require s7plc,1.4.0p
require asyn,4.33.0
require modbus,2.11.0p

epicsEnvSet("TOP","$(E3_CMD_TOP)/..")

epicsEnvSet("PLCNAME","kg-gta_odh-plc-01")
epicsEnvSet("IPADDR","172.16.49.12")
epicsEnvSet("RECVTIMEOUT","3000")
epicsEnvSet("S7DRVPORT","2000")
epicsEnvSet("MODBUSDRVPORT","502")
epicsEnvSet("$(PLCNAME)_CONFIGURE_MODBUS_READ","#")
epicsEnvSet("INSIZE","184")
epicsEnvSet("BIGENDIAN","1")

var s7plcDebug 0
s7plcConfigure($(PLCNAME), $(IPADDR), $(S7DRVPORT), $(INSIZE), 0, $(BIGENDIAN), $(RECVTIMEOUT), 0)
drvAsynIPPortConfigure($(PLCNAME),$(IPADDR):$(MODBUSDRVPORT),0,0,1)
modbusInterposeConfig($(PLCNAME), 0, $(RECVTIMEOUT), 0)
$($(PLCNAME)_CONFIGURE_MODBUS_READ='') drvModbusAsynConfigure("$(PLCNAME)read", $(PLCNAME), 0, 3, 0, 1, 0, 1000, "S7-1500")
drvModbusAsynConfigure("$(PLCNAME)write", $(PLCNAME), 0, 16, -1, 2, 0, 0, "S7-1500")

dbLoadRecords("$(TOP)/db/kg-gta_odh-plc-01.db", "PLCNAME=$(PLCNAME), MODVERSION=0")
