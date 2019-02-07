# GCDMachine
VHDL Coding on FPGA DE2 Board; Find GCD of two inputs.

## Authors
Jeff Westwood, Sung Kwan Ahn

## Summary
The project is implementation of GCD algorithm onto FPGA DE2-board written in VHDL.
The codes are written on 
```
Quartus II 13.0 Web Edition
```
Simulated on 
```
ModelSim - Altera
```
Programmed on to 
```
FPGA DE2 Board for testing
```

Data path is built with
* 8 to 4 Mux
* Inverter
* Register
* Zero Detector
* 4-bit adder

## Project Overview

### Data Path
![](GCDMachine/images/D.JPG)

### Controller
![](GCDMachine/images/C.JPG)

### Final Design
![](GCDMachine/images/E.JPG)
