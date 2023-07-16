### ----------------------------------------------------------------------
### Copyright (C) 2017-2023 Geraldo Ribeiro <geraldo@intmain.io>
### ----------------------------------------------------------------------

STATUS_BAR_SCRIPTS=$(wildcard sb_*)
USR_LOCAL_BIN_SCRIPTS=$(addprefix /usr/local/bin/,$(STATUS_BAR_SCRIPTS)) 

/usr/local/bin/%: %
	cp $^ $@

install: $(USR_LOCAL_BIN_SCRIPTS)
