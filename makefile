synthesisFolder=quartusFiles
folderTest=dist_tests
wkd="--workdir=$(folderTest)"
mainEntity=stepper_half_single_test
flags="--ieee=synopsys"

export ENTITY=$(mainEntity)

runner:buildTest
	@ghdl -r $(flags) $(wkd) $(ENTITY) 

test:buildTest
	@for file in src/test/*;do \
	ENTITY=$$(echo $$file | sed "s/\(.*\/\)\|\(\\.vhdl\)//g"); \
	make runner ENTITY=$$ENTITY; \
	done

buildTest:makeTest
	@ghdl -e  $(flags) $(wkd) $(ENTITY)

makeTest:analize
	@ghdl -m $(flags) $(wkd) $(ENTITY) 

analize:creteFolderTest
	@ghdl -i $(wkd) src/**/*.vhdl

clear:
	@rm -rf $(folderTest)
	@rm -rf $$(find $(synthesisFolder) -maxdepth 1 -mindepth 1 -type d)

dev:
	find src -type f | entr zsh -c "echo \"Restarted...\"\
	&& source ~/.zshrc\
	&& make test\
	&& if [ \"\$$(make test | grep -c failed)\" -eq 0 ]; then echo \"Transferring program to FPGA...\" && make transferSynthesis;else echo \"Tests not passed!\";fi\
	"

creteFolderTest:
	@mkdir -p $(folderTest)

transferSynthesis:synthesis
	quartus_pgm -m jtag -o "p;$(synthesisFolder)/output_files/main.sof"

synthesis:
	quartus_sh --flow compile quartusFiles/main