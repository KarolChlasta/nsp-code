#
# Makefile for SA parameter search demo.
#

CLEANFILES = Vm Vm.spk.sim Vm.best Vm.spk.sim.best \
             match.values best.params* SA.save Kdr KM Na *.save sim_status
ULTRACLEANFILES = Vm.spk.data Vm.data
SHELL      = /bin/sh
GENESIS    = genesis

default: run

clean:
	@-for file in $(CLEANFILES); do if [ -f $$file ]; then rm $$file; fi; done

ultraclean: clean
	@-for file in $(ULTRACLEANFILES); \
	do if [ -f $$file ]; then rm $$file; fi; done

# Regenerate the original data files.
# Don't do this unless Vm.data and Vm.spk.data have been lost.
orig:
	@if [ -f sim_status ]; then rm sim_status; fi
	@echo "0" > sim_status
	$(GENESIS) SAorig.g

# Run a practice parameter search.
# This is mainly for debugging.
run:
	@if [ -f sim_status ]; then rm sim_status; fi
	@echo "0" > sim_status
	$(GENESIS) SAdemo.g

# Run a full parameter search from a shell script.
search:
	@if [ -f sim_status ]; then rm sim_status; fi
	@echo "0" > sim_status
	SA_run $(GENESIS) SAdemo.g

# Resume a parameter search that has been halted temporarily.
resume:
	SA_run $(GENESIS) SAdemo.g -resume

# View the output; requires xplot.
view:
	cat Vm.best Vm.data | xplot -geometry 800x600

