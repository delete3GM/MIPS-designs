# MIPS-designs
## :running: Usage
I recommand using VSCode + iverilog to develop this project.
### Firstly use iverilog to generate .out file
```
iverilog -o .\build\test.out .\tests\test.v .\src\mips.v
```
### Then convert .out file to .vcd file
```
vvp .\build\test.out
```
### Finally use gtkwave to open and analyze .vcd file
```
gtkwave.exe .\build\test.vcd
```







