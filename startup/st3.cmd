require iocStats,ae5d083
require recsync,1.3.0

require s7plc,1.4.0p
require asyn,4.33.0
require modbus,2.11.0p
require calc,3.7.1


epicsEnvSet("IOC", "ODH-IOC:ODH-IOC")
epicsEnvSet("e3_ODH_VERSION", "1.1")

epicsEnvSet("TOP","$(E3_CMD_TOP)/..")

epicsEnvSet("PLCNAME","kg-gta_odh-plc-01")
epicsEnvSet("IPADDR","172.16.49.12")
epicsEnvSet("INSIZE","214")

loadIocsh("iocStats.iocsh", "IOCNAME=$(IOC)")
loadIocsh("recsync.iocsh",  "IOCNAME=$(IOC)")

# S7 port           : 2000
# Input block size  : 214 bytes
# Output block size : 0 bytes
# Endianness        : BigEndian
# Receive timeout   : 3000 msec
s7plcConfigure("kg-gta_odh-plc-01", $(IPADDR), 2000, 214, 0, 1, 3000, 0)

# Modbus port       : 502
drvAsynIPPortConfigure("kg-gta_odh-plc-01", $(IPADDR):502, 0, 0, 1)

# Link type         : TCP/IP (0)
# Timeout           : 3000 msec
modbusInterposeConfig("kg-gta_odh-plc-01", 0, 3000, 0)

# Slave address     : 0
# Function code     : 16 - Write Multiple Registers
# Addressing        : Absolute (-1)
# Data segment      : 20 words
drvModbusAsynConfigure("kg-gta_odh-plc-01write", "kg-gta_odh-plc-01", 0, 16, -1, 20, 0, 0, "S7-1500")

# Load plc interface database
dbLoadRecords("$(TOP)/db/kg-gta_odh-plc-01.db", "PLCNAME=kg-gta_odh-plc-01, MODVERSION=$(e3_ODH_VERSION), S7_PORT=2000, MODBUS_PORT=502")
dbLoadRecords("$(TOP)/db/Alarms.db")

iocInit

dbl > "$(TOP)/$(IOC)_PVs.list"
