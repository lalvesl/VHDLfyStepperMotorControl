distFolder=dist
wkd="--workdir=dist"
mainEntity=main
export ENTITY=$(mainEntity)

runner:build
	@ghdl -r $(wkd) $(ENTITY)

test:build
	@for file in src/test/*;do \
	ENTITY=$$(echo $$file | sed "s/\(.*\/\)\|\(\\.vhdl\)//g"); \
	make runner ENTITY=$$ENTITY; \
	done

build:maker
	@ghdl -e $(wkd) $(ENTITY)

maker:analize
	@ghdl -m $(wkd) $(ENTITY)

analize:
	@ghdl -i $(wkd) src/**/*.vhdl

clear:
	@rm -rf $(distFolder) > /dev/null

dev:
	find src -type f | entr sh -c "echo "Restarting..." && make test"