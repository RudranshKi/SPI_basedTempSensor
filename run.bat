@echo off
iverilog -o exec.vvp LM07_read.v tb_LM07.v
vvp exec.vvp
gtkwave dump.vcd