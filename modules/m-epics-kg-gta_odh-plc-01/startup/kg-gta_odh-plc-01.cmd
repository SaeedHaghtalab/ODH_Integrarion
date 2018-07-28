# @field PLCNAME
# @type STRING
# asyn port name for the PLC

# @field IPADDR
# @type STRING
# PLC IP address

# @field RECVTIMEOUT
# @type INTEGER
# PLC->EPICS receive timeout (ms), should be longer than frequency of PLC SND block trigger (REQ input)

# @field REQUIRE_kg-gta_odh-plc-01_VERSION
# @runtime YES

# @field SAVEFILE_DIR
# @type  STRING
# The directory where autosave should save files

# @field REQUIRE_kg-gta_odh-plc-01_PATH
# @runtime YES

# Call the EEE module responsible for configuring IOC to PLC comms configuration
epicsEnvSet("$(PLCNAME)_CONFIGURE_MODBUS_READ", "#")
requireSnippet(s7plc-comms.cmd, "PLCNAME=$(PLCNAME), IPADDR=$(IPADDR), S7DRVPORT=2000, MODBUSDRVPORT=502, INSIZE=152, OUTSIZE=0, BIGENDIAN=1, RECVTIMEOUT=$(RECVTIMEOUT)")

# Load plc interface database
dbLoadRecords("kg-gta_odh-plc-01.db", "PLCNAME=$(PLCNAME), MODVERSION=$(REQUIRE_kg-gta_odh-plc-01_VERSION)")

# Configure autosave
# Number of sequenced backup files to write
save_restoreSet_NumSeqFiles(1)

# Specify directories in which to search for request files
set_requestfile_path("$(REQUIRE_kg-gta_odh-plc-01_PATH)", "misc")

# Specify where the save files should be
set_savefile_path("$(SAVEFILE_DIR)", "")

# Specify what save files should be restored
set_pass0_restoreFile("kg-gta_odh-plc-01.sav")

# Create monitor set
create_monitor_set("kg-gta_odh-plc-01.req", 1, "")
