distFolder=dist
folderTest=dist_tests
wkd="--workdir=$(folderTest)"
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

analize:creteFolderTest
	@ghdl -i $(wkd) src/**/*.vhdl

clear:
	@rm -rf $(folderTest) > /dev/null

dev:
	find src -type f | entr sh -c "clear && echo \"Restarted...\" && make test"

creteFolderTest:
	mkdir -p $(folderTest)