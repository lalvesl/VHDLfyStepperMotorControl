synthesisFolder=quartusFiles
folderTest=dist_tests
wkd="--workdir=$(folderTest)"
mainEntity=main
flags="--ieee=synopsys"

export ENTITY=$(mainEntity)

build:synthesis
	echo "OK"

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

checkSyntax:analize
	@for file in $$(find src -type f);do \
		ghdl -a $(flags) $$file; \
	done

analize:creteFolderTest
	@ghdl -i $(flags) $(wkd) $$(find src -type f)

clear:
	@rm -rf $(folderTest)
	@rm -rf $$(find $(synthesisFolder) -maxdepth 1 -mindepth 1 -type d)

devTest:
	find src -type f | entr zsh -c "echo \"Restarted...\"\
	&& source ~/.zshrc\
	&& make test\
	"

dev:
	find src -type f | entr zsh -c "echo \"Restarted...\"\
	&& source ~/.zshrc\
	&& pkill -9 \"quartus\"\
	&& make test\
	&& sleep 1\
	& if [ \"\$$(make test |& grep -c \"\\.vhdl:[0-9]\\+:[0-9]\\+:[^@]\")\" -eq 0 ]; then echo \"Transferring program to FPGA...\" & make transferSynthesis & true;else echo \"Tests not passed!\";fi\
	"

creteFolderTest:
	@mkdir -p $(folderTest)

transferSynthesis:synthesis
	quartus_pgm -m jtag -o "p;$(synthesisFolder)/output_files/main.sof"

synthesis:
	quartus_sh --flow compile quartusFiles/main