distFolder=dist
wkd="--workdir=dist"
mainEntity=stepper_half_single_test
flags="--ieee=synopsys"

export ENTITY=$(mainEntity)

runner:build
	@ghdl -r $(flags) $(wkd) $(ENTITY) 

test:build
	@for file in src/test/*;do \
	ENTITY=$$(echo $$file | sed "s/\(.*\/\)\|\(\\.vhdl\)//g"); \
	make runner ENTITY=$$ENTITY; \
	done

build:maker
	@ghdl -e  $(flags) $(wkd) $(ENTITY)

maker:analize
	@ghdl -m $(flags) $(wkd) $(ENTITY) 

analize:
	@ghdl -i $(wkd) src/**/*.vhdl

clear:
	@rm -rf $(distFolder) > /dev/null

dev:
	find src -type f | entr sh -c "clear && echo \"Restarted...\" && make test"