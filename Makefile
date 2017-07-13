# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

.PHONY: run save
save-experiment:
	-@git add . ||:
	-@git commit -m "Snapshot for running an experiment" ||:
run: save-experiment
	@echo "\"$(shell date "+%Y%m%d%H%M%S")\"","\"$(shell git rev-parse --short HEAD)\"","\"$(RUN_ARGS)\""  >> LOGBOOK.txt
	$(RUN_ARGS)
