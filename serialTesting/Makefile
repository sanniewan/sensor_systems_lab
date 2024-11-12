Target=SerialTop
TOP=SerialTop
OBJS+=SerialTop.v uart_rx.v four_byte_receiver_rx.v

################################################################################
 # make all
################################################################################

all: ${Target}.bit

$(Target).json: $(OBJS)
	yosys -p "synth_ecp5 -top ${TOP} -json $@" $(OBJS)

$(Target)_out.config: $(Target).json
	nextpnr-ecp5 --25k --package CABGA256 --speed 6 --json $< --textcfg $@ --lpf $(Target).lpf --freq 65

$(Target).bit: $(Target)_out.config
	ecppack --svf ${Target}.svf $< $@

${Target}.svf: ${Target}.bit

################################################################################
 # ecpdap tools for programming and flashing board
################################################################################

scan:
	ecpdap scan

fscan:
	ecpdap flash scan

prog: ${Target}.svf
	ecpdap program --freq 5000 $(Target).bit

flash: ${Target}.svf
	ecpdap flash --freq 5000 write $(Target).bit

################################################################################
 # make tools
################################################################################

clean:
	rm -f *.svf *.bit *.config *.ys *.json

.PHONY: prog clean