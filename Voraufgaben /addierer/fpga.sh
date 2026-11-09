#!/usr/bin/env bash
# Synthese (GHDL + yosys), Place & Route (openXC7) und Laden auf das Arty S7-50.
# Aufruf: ./fpga.sh [top] [xdc]          z.B. ./fpga.sh adder adder.xdc
# Mit FLASH=1 wird dauerhaft ins SPI-Flash geschrieben statt ins SRAM.
set -euo pipefail
cd "$(dirname "$0")"

TOP=${1:-adder}
XDC=${2:-$TOP.xdc}
PART=xc7s50csga324-1
OSS=~/.apio/packages/oss-cad-suite
XC7=~/.apio/packages/openxc7
DB=$XC7/share/nextpnr/external/prjxray-db/spartan7
export PATH=$OSS/bin:$XC7/bin:$PATH

mkdir -p _build
SRC=$(ls *.vhd | grep -v '_tb\.vhd$')

yosys -q -m ghdl -p "ghdl --std=08 $SRC -e $TOP; synth_xilinx -arch xc7 -top $TOP; write_json _build/$TOP.json"
nextpnr-xilinx -q --chipdb $XC7/chipdb/xc7s50csga324.bin --xdc "$XDC" \
    --json _build/$TOP.json --fasm _build/$TOP.fasm
fasm2frames --part $PART --db-root $DB _build/$TOP.fasm > _build/$TOP.frames
xc7frames2bit --part_file $DB/$PART/part.yaml --part_name $PART \
    --frm_file _build/$TOP.frames --output_file _build/$TOP.bit

if [ "${FLASH:-0}" = 1 ]; then
    openFPGALoader --board arty_s7_50 -f _build/$TOP.bit
else
    openFPGALoader --board arty_s7_50 _build/$TOP.bit
fi
