include ${EPICS_ENV_PATH}/module.Makefile

# Let s7plc_comms decide the version of s7plc and modbus
AUTO_DEPENDENCIES = NO
USR_DEPENDENCIES += s7plc_comms
MISCS = ${AUTOMISCS} $(addprefix misc/, creator)

USR_DEPENDENCIES += autosave
USR_DEPENDENCIES += synappsstd
MISCS += $(addprefix misc/, kg-gta_odh-plc-01.req)
