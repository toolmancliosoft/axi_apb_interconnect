CONFIG ?= config/dx1_interconnect.yaml
.PHONY: smoke generate check clean
generate:
	python3 scripts/generate.py --config $(CONFIG) --out build/generated
check:
	python3 scripts/check_config.py $(CONFIG)
smoke:
	./scripts/smoke.sh
clean:
	rm -rf build work
